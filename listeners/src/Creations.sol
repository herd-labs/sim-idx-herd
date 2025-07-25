// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./utils/TraceUtils.sol";
import "./types/Structs.sol";
import "sim-idx-generated/Generated.sol";

contract CreationsListener is Raw$OnCall, Raw$OnPreCall, EntryPoint$PreInnerHandleOpFunction, TraceUtils {
    //resets in every trace
    bytes4 factoryFuncSig = 0x00000000;
    //resets in every trace
    address factoryCaller = 0x0000000000000000000000000000000000000000;

    // Track factory addresses for CREATE3 pattern detection
    address lastFactoryAddress = 0x0000000000000000000000000000000000000000;

    // Mapping to track contracts created in the current transaction
    mapping(address => bool) private contractsCreatedInTx;

    mapping(address => ContractCallInfo) private contractCallInfo;
    // Mapping to store creation traces by contract address
    mapping(address => CreationTraceData) private pendingCreationTraces;
    // Array to track contract addresses that need processing in postTransaction
    address[] private contractsToProcess;

    event CreationsEthereum(CreationsData);
    event CreationsBase(CreationsData);

    function emitCreations(CreationsData memory data, uint256 chainId) internal {
        if (chainId == 1) {
            emit CreationsEthereum(data);
        } else if (chainId == 8453) {
            emit CreationsBase(data);
        }
    }

    function preInnerHandleOpFunction(PreFunctionContext memory, EntryPoint$InnerHandleOpFunctionInputs memory inputs)
        external
        override
    {
        smartAccountSender = inputs.opInfo.mUserOp.sender;
        isStartOfUserOp = true;
    }

    function onCall(RawCallContext memory ctx) external override {
        if (ctx.txn.call.callDepth() == 0) {
            // Process any pending creation traces
            for (uint256 i = 0; i < contractsToProcess.length; i++) {
                address contractAddress = contractsToProcess[i];
                CreationTraceData storage traceData = pendingCreationTraces[contractAddress];

                // Now we can access the deployed bytecode
                bytes memory deployedBytecode = contractAddress.code;

                // Emit the creation trace with the deployed bytecode information
                emitCreations(
                    CreationsData({
                        blockNumber: traceData.blockNumber,
                        blockTimestamp: traceData.blockTimestamp,
                        contractAddress: traceData.contractAddress,
                        initializationCodeHash: traceData.initializationCodeHash,
                        initializationCodeLength: traceData.initializationCodeLength,
                        deployedBytecodeHash: sha256(deployedBytecode),
                        deployedBytecodeLength: uint64(deployedBytecode.length) * 2 + 2,
                        txnHash: ctx.txn.hash(),
                        isFactory: traceData.isFactory,
                        directDeploy: traceData.directDeploy,
                        deployerAddress: traceData.deployerAddress,
                        deployerType: traceData.deployerType,
                        factoryAddress: traceData.factoryAddress,
                        deploymentType: traceData.deploymentType,
                        txFrom: traceData.txFrom,
                        txTo: traceData.txTo,
                        factoryFuncSig: traceData.factoryFuncSig,
                        factoryCaller: traceData.factoryCaller
                    }),
                    block.chainid
                );
            }

            // Clear the arrays for the next transaction
            for (uint256 i = 0; i < contractsToProcess.length; i++) {
                address contractAddress = contractsToProcess[i];

                // Clear the contractsCreatedInTx at end of tx
                contractsCreatedInTx[contractAddress] = false;
            }

            delete contractsToProcess;

            //reset on end of the tx
            currentCallDepth = 0;
        }
    }

    function onPreCall(RawPreCallContext memory ctx) external override {
        currentCallDepth = uint64(ctx.txn.call.callDepth());

        // get the first tx to
        if (uint64(ctx.txn.call.callDepth()) == 0) {
            firstTxTo = ctx.txn.call.callee();
        }

        // continually track user op
        handleUserOp(uint64(ctx.txn.call.callDepth()));

        // Store the latest function signature for the callee contract
        contractCallInfo[ctx.txn.call.callee()] = ContractCallInfo({
            callDepth: currentCallDepth,
            traceFrom: ctx.txn.call.caller(),
            funcSig: bytes4(ctx.txn.call.callData())
        });

        //only process if deployment trace. DO NOT PUT ANY GENERIC LOGIC BELOW THAT NEEDS TO BE TRACKED THROUGH ALL TRACES.
        if (
            ctx.txn.call.callType() == CallType.DEPLOYMENT || ctx.txn.call.callType() == CallType.CREATE
                || ctx.txn.call.callType() == CallType.CREATE2
        ) {
            string memory call_type_string;
            if (ctx.txn.call.callType() == CallType.DEPLOYMENT) {
                call_type_string = "TXN";
            } else if (ctx.txn.call.callType() == CallType.CREATE) {
                call_type_string = "CREATE";
            } else if (ctx.txn.call.callType() == CallType.CREATE2) {
                call_type_string = "CREATE2";
            }

            // Check if caller is EOA or contract
            address factoryAddress; //starts as null
            address tempFactoryCheckAddress = ctx.txn.call.caller();
            address tempLastFactoryForSizeCheck = lastFactoryAddress;
            bool isFactory;
            uint256 factorySize;
            uint256 lastFactorySize;
            assembly {
                factorySize := extcodesize(tempFactoryCheckAddress)
                lastFactorySize := extcodesize(tempLastFactoryForSizeCheck)
            }

            //if temp_factory_address has code or was created in this transaction... note that if a contract is created in a constructor, the factory won't have any "size" yet
            if (factorySize > 0 || contractsCreatedInTx[tempFactoryCheckAddress]) {
                // Deployer is a contract (factory)
                isFactory = true;
                factoryAddress = ctx.txn.call.caller();

                // Check if this is a CREATE3 pattern (factory was created in this transaction, and the factory was created by a factory that is less than 40 bytes long)
                if (
                    contractsCreatedInTx[factoryAddress]
                        && lastFactoryAddress != 0x0000000000000000000000000000000000000000 && factorySize < 40
                        && ctx.txn.call.callType() == CallType.CREATE2
                ) {
                    call_type_string = "CREATE3";
                    // Use the original factory that created this factory
                    factoryAddress = pendingCreationTraces[factoryAddress].factoryAddress;
                }
            } else {
                // Deployer is an EOA
                isFactory = false;
                factoryFuncSig = 0x00000000; //we def have some contracts that carried the factory funcsig from a previous factory creation in the same txn
                factoryCaller = 0x0000000000000000000000000000000000000000;
            }

            // after factory_address is finalized, get the function signature called on the factory.
            if (isFactory) {
                factoryFuncSig = contractCallInfo[factoryAddress].funcSig;
                if (factoryCaller != tx.origin) {
                    //we only care if it's a contract that called the factory
                    factoryCaller = contractCallInfo[factoryAddress].traceFrom;
                }
            }

            // Determine deployer address and type based on smart account sender
            address deployerAddress;
            string memory deployerType;

            if (smartAccountSender != 0x0000000000000000000000000000000000000000) {
                // If we have a smart account sender, use it as the deployer
                deployerAddress = smartAccountSender;
                deployerType = "smart";
            } else {
                // Otherwise use the transaction origin (EOA)
                deployerAddress = tx.origin;
                deployerType = "EOA";
            }

            // Store creation trace data for processing in postTransactionTo
            pendingCreationTraces[ctx.txn.call.callee()] = CreationTraceData({
                blockNumber: uint64(block.number),
                blockTimestamp: uint64(block.timestamp),
                contractAddress: ctx.txn.call.callee(),
                initializationCodeHash: sha256(abi.encodePacked(ctx.txn.call.callData())),
                initializationCodeLength: uint64(ctx.txn.call.callData().length) * 2 + 2,
                data: ctx.txn.call.callData(),
                isFactory: isFactory,
                directDeploy: (firstTxTo == ctx.txn.call.callee()),
                deployerAddress: deployerAddress,
                deployerType: deployerType,
                factoryAddress: factoryAddress,
                deploymentType: call_type_string,
                factoryFuncSig: factoryFuncSig,
                factoryCaller: factoryCaller,
                txFrom: tx.origin,
                txTo: firstTxTo
            });

            // Mark this contract as created in this transaction
            contractsCreatedInTx[ctx.txn.call.callee()] = true;

            // Add contract address to the list for processing
            contractsToProcess.push(ctx.txn.call.callee());

            // this always gets set to the factory address of this trace, resetting to null address if no factory
            lastFactoryAddress = factoryAddress;
        }
    }
}

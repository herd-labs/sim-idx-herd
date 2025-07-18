// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./utils/TraceUtils.sol";
import "./types/Structs.sol";
import "sim-idx-generated/Generated.sol";

contract CreationsListener is Raw$OnCall, EntryPoint$PreInnerHandleOpFunction, TraceUtils {
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

    event CreationsBase(CreationsData);

    function preInnerHandleOpFunction(
        PreFunctionContext memory ,
        EntryPoint$InnerHandleOpFunctionInputs memory inputs
    ) external override {
        smartAccountSender = inputs.opInfo.mUserOp.sender;
        isStartOfUserOp = true;
    }

    function onCall(RawCallContext memory ctx) external override {
        if (ctx.txn.call.callDepth == 0) {
            // Process any pending creation traces
            for (uint i = 0; i < contractsToProcess.length; i++) {
                address contractAddress = contractsToProcess[i];
                CreationTraceData storage traceData = pendingCreationTraces[contractAddress];
                
                // Now we can access the deployed bytecode
                bytes memory deployedBytecode = contractAddress.code;

                // Emit the creation trace with the deployed bytecode information
                emit CreationsBase(
                    CreationsData({
                        blockNumber: traceData.blockNumber,
                        blockTimestamp: traceData.blockTimestamp,
                        contractAddress: traceData.contractAddress,
                        initializationCodeHash: traceData.initializationCodeHash,
                        initializationCodeLength: traceData.initializationCodeLength,
                        deployedBytecodeHash: sha256(deployedBytecode),
                        deployedBytecodeLength: uint64(deployedBytecode.length)*2 + 2,
                        txnHash: ctx.txn.hash,
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
                    })
                );
            }
            
            // Clear the arrays for the next transaction
            for (uint i = 0; i < contractsToProcess.length; i++) {
                address contractAddress = contractsToProcess[i];
    
                // Clear the contractsCreatedInTx at end of tx
                contractsCreatedInTx[contractAddress] = false;
            }
            
            delete contractsToProcess;
            
            //reset on end of the tx
            currentCallDepth = 0;
        }
    }

    /** 
     * TODO: Add a preCall trigger whenever we implement this trigger.
    */
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./utils/TraceUtils.sol";
import "./types/Structs.sol";
import "sim-idx-generated/Generated.sol";

contract LogsListener is Raw$OnCall, Raw$OnPreCall, EntryPoint$PreInnerHandleOpFunction, Raw$OnLog, TraceUtils {
    uint64 internal logIndex = 0;
    mapping(address => ContractCallInfo) private contractCallInfo;

    event LogsEthereum(LogsData);
    event LogsBase(LogsData);
    event LogsArbitrum(LogsData);

    function emitLogs(LogsData memory data, uint256 chainId) internal {
        if (chainId == 1) {
            emit LogsEthereum(data);
        } else if (chainId == 8453) {
            emit LogsBase(data);
        } else if (chainId == 42161) {
            emit LogsArbitrum(data);
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
            // Reset the mapping state when transaction is complete
            // Only loop up to the maximum call depth we've seen plus 1
            for (uint64 i = 0; i <= maxCallDepthSeen; i++) {
                lastChildIndex[i] = 0;
            }

            currentCallDepth = 0;
            previousCallDepth = 0;
            // Reset the max call depth for the next transaction
            maxCallDepthSeen = 0;
            // Reset the first trace flag for the next transaction
            isFirstTraceInTx = true;
            firstTxTo = 0x0000000000000000000000000000000000000000;
        }
    }

    function onLog(RawLogContext memory ctx) external override {
        logIndex++;

        emitLogs(
            LogsData({
                contractAddress: ctx.txn.call.callee(),
                topic0: ctx.topics().length > 0 ? ctx.topics()[0] : bytes32(0),
                topic1: ctx.topics().length > 1 ? ctx.topics()[1] : bytes32(0),
                topic2: ctx.topics().length > 2 ? ctx.topics()[2] : bytes32(0),
                topic3: ctx.topics().length > 3 ? ctx.topics()[3] : bytes32(0),
                data: ctx.data(),
                txnHash: ctx.txn.hash(),
                blockNumber: uint64(block.number),
                blockTimestamp: uint64(block.timestamp),
                evtIndex: logIndex,
                traceFrom: contractCallInfo[ctx.txn.call.callee()].traceFrom,
                txFrom: tx.origin,
                txTo: firstTxTo,
                originalCallDepth: contractCallInfo[ctx.txn.call.callee()].callDepth,
                emittedAfterTraceAddress: generateTraceAddress(currentCallDepth),
                userOpFrom: smartAccountSender,
                funcSig: contractCallInfo[ctx.txn.call.callee()].funcSig
            }),
            block.chainid
        );
    }

    function onPreCall(RawPreCallContext memory ctx) external override {
        if (uint64(ctx.txn.call.callDepth()) == 0) {
            firstTxTo = ctx.txn.call.callee();
        }
        // Track the maximum call depth we've seen
        if (uint64(ctx.txn.call.callDepth()) > maxCallDepthSeen) {
            maxCallDepthSeen = uint64(ctx.txn.call.callDepth());
        }

        currentCallDepth = uint64(ctx.txn.call.callDepth());

        // handle user op
        handleUserOp(uint64(ctx.txn.call.callDepth()));

        // Store the current call depth and function signature for the callee contract
        contractCallInfo[ctx.txn.call.callee()] = ContractCallInfo({
            callDepth: currentCallDepth,
            traceFrom: ctx.txn.call.caller(),
            funcSig: bytes4(ctx.txn.call.callData())
        });

        // Process trace address and update indices
        processTraceAddress(ctx.txn.call.callee(), uint64(ctx.txn.call.callDepth()));
    }
}

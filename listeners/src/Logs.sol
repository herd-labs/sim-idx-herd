// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./utils/TraceUtils.sol";
import "./types/Structs.sol";
import "sim-idx-generated/Generated.sol";

contract LogsListener is Raw$OnCall, EntryPoint$PreInnerHandleOpFunction, Raw$OnLog, TraceUtils {
    uint64 internal logIndex = 0;
    mapping(address => ContractCallInfo) private contractCallInfo;

    event LogsBase(LogsData);

    function preInnerHandleOpFunction(
        PreFunctionContext memory ,
        EntryPoint$InnerHandleOpFunctionInputs memory inputs
    ) external override {
        smartAccountSender = inputs.opInfo.mUserOp.sender;
        isStartOfUserOp = true;
    }

    function onCall(RawCallContext memory ctx) external override {
        if (ctx.txn.call.callDepth == 0) {
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

        emit LogsBase(LogsData({
            contractAddress: ctx.txn.call.callee,
            topic0: ctx.topics[0],
            topic1: ctx.topics[1],
            topic2: ctx.topics[2],
            topic3: ctx.topics[3],
            data: ctx.data,
            txnHash: ctx.txn.hash,
            blockNumber: uint64(block.number),
            blockTimestamp: uint64(block.timestamp),
            evtIndex: logIndex,
            traceFrom: contractCallInfo[ctx.txn.call.callee].traceFrom,
            txFrom: tx.origin,
            txTo: firstTxTo,
            originalCallDepth: contractCallInfo[ctx.txn.call.callee].callDepth,
            emittedAfterTraceAddress: generateTraceAddress(currentCallDepth),
            userOpFrom: smartAccountSender,
            funcSig: contractCallInfo[ctx.txn.call.callee].funcSig
        }));
    }

    /** 
     * TODO: Add a preCall trigger whenever we implement this trigger.
    */
}

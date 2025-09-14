// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./utils/TraceUtils.sol";
import "./types/Structs.sol";
import "./lib/LibString.sol";
import "sim-idx-generated/Generated.sol";

contract LogsListener is Raw$OnCall, Raw$OnPreCall, EntryPoint$PreInnerHandleOpFunction, Raw$OnLog, TraceUtils {
    uint64 internal logIndex = 0;
    mapping(address => ContractCallInfo) private contractCallInfo;

    event LogsEthereum(LogsData);
    event LogsBase(LogsData);
    // event LogsArbitrum(LogsData);
    event LogsWorldChain(LogsData);

    function emitLogs(LogsData memory data, uint256 chainId) internal {
        if (chainId == 1) {
            emit LogsEthereum(data);
        } else if (chainId == 8453) {
            emit LogsBase(data);
        } else if (chainId == 42161) {
            // emit LogsArbitrum(data);
        } else if (chainId == 480) {
            emit LogsWorldChain(data);
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
        LogsData memory data;
        data.contract_address = LibString.toHexString(ctx.txn.call.callee());
        data.topic0 = ctx.topics().length > 0 ? LibString.toHexString(abi.encodePacked(ctx.topics()[0])) : "0x0000000000000000000000000000000000000000000000000000000000000000";
        data.topic1 = ctx.topics().length > 1 ? LibString.toHexString(abi.encodePacked(ctx.topics()[1])) : "0x0000000000000000000000000000000000000000000000000000000000000000";
        data.topic2 = ctx.topics().length > 2 ? LibString.toHexString(abi.encodePacked(ctx.topics()[2])) : "0x0000000000000000000000000000000000000000000000000000000000000000";
        data.topic3 = ctx.topics().length > 3 ? LibString.toHexString(abi.encodePacked(ctx.topics()[3])) : "0x0000000000000000000000000000000000000000000000000000000000000000";
        data.data = LibString.toHexString(ctx.data());
        data.txn_hash = LibString.toHexString(abi.encodePacked(ctx.txn.hash()));
        data.block_number = uint64(block.number);
        data.block_timestamp = uint64(block.timestamp);
        data.evt_index = logIndex;
        data.trace_from = contractCallInfo[ctx.txn.call.callee()].trace_from;
        data.tx_from = LibString.toHexString(tx.origin);
        data.tx_to = LibString.toHexString(firstTxTo);
        data.original_call_depth = contractCallInfo[ctx.txn.call.callee()].call_depth;
        data.emitted_after_trace_address = generateTraceAddress(currentCallDepth);
        data.user_op_from = LibString.toHexString(smartAccountSender);
        data.funcsig = contractCallInfo[ctx.txn.call.callee()].func_sig;

        emitLogs(
            data,
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
            call_depth: currentCallDepth,
            trace_from: LibString.toHexString(ctx.txn.call.caller()),
            func_sig: LibString.toHexString(abi.encodePacked(bytes4(ctx.txn.call.callData())))
        });

        // Process trace address and update indices
        processTraceAddress(ctx.txn.call.callee(), uint64(ctx.txn.call.callDepth()));
    }
}

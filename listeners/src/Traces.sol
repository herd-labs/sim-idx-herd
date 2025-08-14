// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./utils/TraceUtils.sol";
import "./types/Structs.sol";
import "./lib/LibString.sol";
import "sim-idx-generated/Generated.sol";

contract TracesListener is Raw$OnCall, Raw$OnPreCall, EntryPoint$PreInnerHandleOpFunction, TraceUtils {
    event TracesEthereum(TracesData);
    event TracesBase(TracesData);
    event TracesArbitrum(TracesData);

    function emitTraces(TracesData memory data, uint256 chainId) internal {
        if (chainId == 1) {
            emit TracesEthereum(data);
        } else if (chainId == 8453) {
            emit TracesBase(data);
        } else if (chainId == 42161) {
            emit TracesArbitrum(data);
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

    function onPreCall(RawPreCallContext memory ctx) external override {
        if (uint64(ctx.txn.call.callDepth()) > maxCallDepthSeen) {
            maxCallDepthSeen = uint64(ctx.txn.call.callDepth());
        }
        if (isFirstTraceInTx) {
            lastChildIndex[0] = 0;
            isFirstTraceInTx = false;
        }

        currentCallDepth = uint64(ctx.txn.call.callDepth());

        // Handle UserOp logic. this runs after the preInnerHandleOp.
        handleUserOp(uint64(ctx.txn.call.callDepth()));

        // Process trace address and update indices
        string memory traceAddress = processTraceAddress(ctx.txn.call.callee(), uint64(ctx.txn.call.callDepth()));

        // Update function signature mappings
        bytes4 parentFunctionSignatureBytes =
            updateFunctionSignatures(uint64(ctx.txn.call.callDepth()), ctx.txn.call.callData());
        string memory parentFunctionSignature = LibString.toHexString(abi.encodePacked(parentFunctionSignatureBytes));

        if (uint64(ctx.txn.call.callType()) == 3) {
            caller = ctx.txn.call.delegator();
            callee = ctx.txn.call.delegatee();
        } else {
            caller = ctx.txn.call.caller();
            callee = ctx.txn.call.callee();
        }

        // Break down hex conversions to avoid stack too deep
        string memory txnHashHex = LibString.toHexString(abi.encodePacked(ctx.txn.hash()));
        string memory callerHex = LibString.toHexString(caller);
        string memory calleeHex = LibString.toHexString(callee);
        string memory funcSigHex = LibString.toHexString(abi.encodePacked(bytes4(ctx.txn.call.callData())));
        string memory txFromHex = LibString.toHexString(tx.origin);
        string memory txToHex = LibString.toHexString(firstTxTo);
        string memory userOpFromHex = LibString.toHexString(smartAccountSender);

        emitTraces(
            TracesData({
                block_number: uint64(block.number),
                block_timestamp: uint64(block.timestamp),
                txn_hash: txnHashHex,
                caller: callerHex,
                callee: calleeHex,
                func_sig: funcSigHex,
                parent_func_sig: parentFunctionSignature,
                tx_from: txFromHex,
                tx_to: txToHex,
                call_type: uint64(ctx.txn.call.callType()),
                user_op_from: userOpFromHex,
                call_depth: uint64(ctx.txn.call.callDepth()),
                trace_address: traceAddress,
                success: ctx.txn.isSuccessful()
            }),
            block.chainid
        );
    }
}

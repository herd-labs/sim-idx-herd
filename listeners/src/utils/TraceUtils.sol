// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "sim-idx-sol/Simidx.sol";
import "../lib/LibString.sol";

contract TraceUtils {
    mapping(uint64 => bytes4) internal lastFunctionSignature;
    address internal smartAccountSender = 0x0000000000000000000000000000000000000000;
    bool internal isStartOfUserOp = false;
    uint64 internal currentCallDepth = 0;
    uint64 internal userOpCallDepth = 0;

    //updated each trace
    address internal caller = 0x0000000000000000000000000000000000000000;
    address internal callee = 0x0000000000000000000000000000000000000000;

    // Add mapping to track the last child index at each depth
    mapping(uint64 => uint64) internal lastChildIndex;

    // Add a variable to track the previous call depth
    uint256 internal previousCallDepth = 0;

    // Add a variable to track if this is the first transaction
    bool internal isFirstTransaction = true;

    // Add a variable to track the maximum call depth seen
    uint64 internal maxCallDepthSeen = 0;

    // Add a variable to track if this is the. first trace in a transaction
    bool internal isFirstTraceInTx = true;

    address internal firstTxTo = 0x0000000000000000000000000000000000000000;

    function handleUserOp(RawCallContext memory ctx) internal {
        if (isStartOfUserOp) {
            //we can't use the call depth in preInnerHandleOp since it doesn't exist in ctx and is before currentCallDepth updates.
            userOpCallDepth = uint64(ctx.txn.call.callDepth);
        }
        if (
            smartAccountSender != 0x0000000000000000000000000000000000000000
                && ctx.txn.call.callDepth <= userOpCallDepth && !isStartOfUserOp
        ) {
            //reset completely each time a userop is finished
            smartAccountSender = 0x0000000000000000000000000000000000000000;
            userOpCallDepth = 0;
        }
        //this always gets reset to false
        isStartOfUserOp = false;
    }

    // Update function signature mappings
    function updateFunctionSignatures(RawCallContext memory ctx) internal returns (bytes4) {
        // Update the mapping with every trace
        lastFunctionSignature[uint64(ctx.txn.call.callDepth)] = bytes4(ctx.data);

        // The function signature of the parent is the last seen signature at the depth above
        bytes4 parentFunctionSignature;
        if (ctx.txn.call.callDepth > 0) {
            parentFunctionSignature = lastFunctionSignature[uint64(ctx.txn.call.callDepth - 1)];
        }

        return parentFunctionSignature;
    }

    // Process trace address and update indices
    function processTraceAddress(RawCallContext memory ctx) internal returns (string memory) {
        string memory traceAddress;

        // Special handling for the first trace in a transaction
        if (isFirstTraceInTx) {
            // For the first trace, always use index 0 without incrementing
            lastChildIndex[0] = 0;
            traceAddress = LibString.toString(uint256(0));
            isFirstTraceInTx = false;
            firstTxTo = ctx.txn.call.callee;
        } else {
            // Normal handling for subsequent traces
            if (ctx.txn.call.callDepth > previousCallDepth) {
                // Call depth increased - start new index at 0
                lastChildIndex[uint64(ctx.txn.call.callDepth)] = 0;
            } else if (ctx.txn.call.callDepth < previousCallDepth) {
                // Call depth decreased - increment the index at the new depth
                lastChildIndex[uint64(ctx.txn.call.callDepth)]++;
            } else {
                // Same depth - increment the index
                lastChildIndex[uint64(ctx.txn.call.callDepth)]++;
            }

            // Generate trace_address string after handling call depth changes
            traceAddress = generateTraceAddress(uint256(ctx.txn.call.callDepth));
        }

        // Update previous call depth for next call
        previousCallDepth = ctx.txn.call.callDepth;

        return traceAddress;
    }

    function generateTraceAddress(uint256 depth) internal view returns (string memory) {
        if (depth == 0) {
            return LibString.toString(lastChildIndex[0]);
        }

        string memory result = LibString.toString(lastChildIndex[0]);
        for (uint64 i = 1; i <= depth; i++) {
            result = string(abi.encodePacked(result, ",", LibString.toString(lastChildIndex[i])));
        }
        return result;
    }
}

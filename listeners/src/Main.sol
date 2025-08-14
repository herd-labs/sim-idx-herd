// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "sim-idx-sol/Simidx.sol";
import "sim-idx-generated/Generated.sol";
import "./Traces.sol";
import "./Logs.sol";
import "./Creations.sol";

//think of this as the entrypoint (start)
contract Triggers is BaseTriggers {
    function triggers() external virtual override {
        //we'll specify a specific block number to start from
        tracesTriggers(Chains.Base, 34150555);
        logsTriggers(Chains.Base, 34150555);
        creationsTriggers(Chains.Base, 34150555);

        tracesTriggers(Chains.Ethereum, 23132322);
        logsTriggers(Chains.Ethereum, 23132322);
        creationsTriggers(Chains.Ethereum, 23132322);

        // tracesTriggers(Chains.Arbitrum, 1);
        // logsTriggers(Chains.Arbitrum, 1);
        // creationsTriggers(Chains.Arbitrum, 1);
    }

    function tracesTriggers(Chains chain, uint64 startBlock) internal {
        TracesListener tracesListener = new TracesListener();

        addTrigger(chainAbi(chain.withStartBlock(startBlock), EntryPoint$Abi()), tracesListener.triggerPreInnerHandleOpFunction());
        addTrigger(chainGlobal(chain.withStartBlock(startBlock)), tracesListener.triggerOnCall());
        addTrigger(chainGlobal(chain.withStartBlock(startBlock)), tracesListener.triggerOnPreCall());
    }

    function logsTriggers(Chains chain, uint64 startBlock) internal {
        LogsListener logsListener = new LogsListener();
        addTrigger(chainAbi(chain.withStartBlock(startBlock), EntryPoint$Abi()), logsListener.triggerPreInnerHandleOpFunction());
        addTrigger(chainGlobal(chain.withStartBlock(startBlock)), logsListener.triggerOnCall());
        addTrigger(chainGlobal(chain.withStartBlock(startBlock)), logsListener.triggerOnLog());
        addTrigger(chainGlobal(chain.withStartBlock(startBlock)), logsListener.triggerOnPreCall());
    }

    function creationsTriggers(Chains chain, uint64 startBlock) internal {
        CreationsListener creationsListener = new CreationsListener();
        addTrigger(
            chainAbi(chain.withStartBlock(startBlock), EntryPoint$Abi()), creationsListener.triggerPreInnerHandleOpFunction()
        );
        addTrigger(chainGlobal(chain.withStartBlock(startBlock)), creationsListener.triggerOnCall());
        addTrigger(chainGlobal(chain.withStartBlock(startBlock)), creationsListener.triggerOnPreCall());
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "sim-idx-sol/Simidx.sol";
import "sim-idx-generated/Generated.sol";
import "./Traces.sol";
import "./Logs.sol";
import "./Creations.sol";

contract Triggers is BaseTriggers {
    function triggers() external virtual override {
        tracesTriggers(Chains.Base, 34146634);
        logsTriggers(Chains.Base, 34146634);
        creationsTriggers(Chains.Base, 34146634);

        tracesTriggers(Chains.Ethereum, 23131640);
        logsTriggers(Chains.Ethereum, 23131640);
        creationsTriggers(Chains.Ethereum, 23131640);
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

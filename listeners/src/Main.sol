// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "sim-idx-sol/Simidx.sol";
import "sim-idx-generated/Generated.sol";
import "./Traces.sol";
import "./Logs.sol";
import "./Creations.sol";

contract Triggers is BaseTriggers {
    function triggers() external virtual override {
        tracesTriggers();
        logsTriggers();
        creationsTriggers();
    }

    function tracesTriggers() internal {
        TracesListener tracesListener = new TracesListener();
        addTrigger(chainAbi(Chains.Base, EntryPoint$Abi()), tracesListener.triggerPreInnerHandleOpFunction());
        addTrigger(chainGlobal(Chains.Base), tracesListener.triggerOnCall());
        addTrigger(chainGlobal(Chains.Base), tracesListener.triggerOnPreCall());
    }

    function logsTriggers() internal {
        LogsListener logsListener = new LogsListener();
        addTrigger(chainAbi(Chains.Base, EntryPoint$Abi()), logsListener.triggerPreInnerHandleOpFunction());
        addTrigger(chainGlobal(Chains.Base), logsListener.triggerOnCall());
        addTrigger(chainGlobal(Chains.Base), logsListener.triggerOnLog());
        addTrigger(chainGlobal(Chains.Base), logsListener.triggerOnPreCall());
    }

    function creationsTriggers() internal {
        CreationsListener creationsListener = new CreationsListener();
        addTrigger(
            chainAbi(Chains.Base, EntryPoint$Abi()), creationsListener.triggerPreInnerHandleOpFunction()
        );
        addTrigger(chainGlobal(Chains.Base), creationsListener.triggerOnCall());
        addTrigger(chainGlobal(Chains.Base), creationsListener.triggerOnPreCall());
    }
}

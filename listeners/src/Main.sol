// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "sim-idx-sol/Simidx.sol";
import "sim-idx-generated/Generated.sol";
import "./Traces.sol";
import "./Logs.sol";
import "./Creations.sol";

contract Triggers is BaseTriggers {
    // avoid stack too deep
    struct Listeners {
        TracesListener tracesListener;
        LogsListener logsListener;
        CreationsListener creationsListener;
    }

    function triggers() external virtual override {
        Listeners memory listeners = Listeners({
            tracesListener: new TracesListener(),
            logsListener: new LogsListener(),
            creationsListener: new CreationsListener()
        });
        addTrigger(chainAbi(Chains.Base, EntryPoint$Abi()), listeners.tracesListener.triggerPreInnerHandleOpFunction());
        addTrigger(chainGlobal(Chains.Base), listeners.tracesListener.triggerOnCall());
        addTrigger(chainGlobal(Chains.Base), listeners.tracesListener.triggerOnPreCall());

        addTrigger(chainAbi(Chains.Base, EntryPoint$Abi()), listeners.logsListener.triggerPreInnerHandleOpFunction());
        addTrigger(chainGlobal(Chains.Base), listeners.logsListener.triggerOnCall());
        addTrigger(chainGlobal(Chains.Base), listeners.logsListener.triggerOnLog());
        addTrigger(chainGlobal(Chains.Base), listeners.logsListener.triggerOnPreCall());

        addTrigger(
            chainAbi(Chains.Base, EntryPoint$Abi()), listeners.creationsListener.triggerPreInnerHandleOpFunction()
        );
        addTrigger(chainGlobal(Chains.Base), listeners.creationsListener.triggerOnCall());
        addTrigger(chainGlobal(Chains.Base), listeners.creationsListener.triggerOnPreCall());
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

struct TracesData {
    uint64 blockTimestamp;
    uint64 blockNumber;
    string txnHash;
    string caller;
    string callee;
    string funcSig;
    string parentFuncSig;
    string txFrom;
    string txTo;
    string userOpFrom;
    uint64 callDepth;
    string traceAddress;
    bool success;
    uint64 callType;
}

struct LogsData {
    string contractAddress;
    string topic0;
    string topic1;
    string topic2;
    string topic3;
    string data;
    string txnHash;
    uint64 blockNumber;
    uint64 blockTimestamp;
    uint64 evtIndex;
    string traceFrom;
    string txFrom;
    string txTo;
    uint64 originalCallDepth;
    string emittedAfterTraceAddress;
    string userOpFrom;
    string funcSig;
}

struct ContractCallInfo {
    string traceFrom;
    uint64 callDepth;
    string funcSig;
}

struct CreationTraceData {
    uint64 blockNumber;
    uint64 blockTimestamp;
    string contractAddress;
    string initializationCodeHash;
    uint64 initializationCodeLength;
    string data;
    bool isFactory;
    bool directDeploy;
    string deployerAddress;
    string deployerType;
    string factoryAddress;
    string deploymentType;
    string factoryFuncSig;
    string factoryCaller;
    string txFrom;
    string txTo;
}

struct CreationsData {
    uint64 blockNumber;
    uint64 blockTimestamp;
    string contractAddress;
    string initializationCodeHash;
    uint64 initializationCodeLength;
    string deployedBytecodeHash;
    uint64 deployedBytecodeLength;
    string txnHash;
    bool isFactory;
    bool directDeploy;
    string deployerAddress;
    string deployerType;
    string factoryAddress;
    string deploymentType;
    string txFrom;
    string txTo;
    string factoryFuncSig;
    string factoryCaller;
}

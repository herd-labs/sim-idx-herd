// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

struct TracesData {
    uint64 blockTimestamp;
    uint64 blockNumber;
    bytes32 txnHash;
    address caller;
    address callee;
    bytes4 funcSig;
    bytes4 parentFuncSig;
    address txFrom;
    address txTo;
    address userOpFrom;
    uint64 callDepth;
    string traceAddress;
    bool success;
    uint64 callType;
}

struct LogsData {
    address contractAddress;
    bytes32 topic0;
    bytes32 topic1;
    bytes32 topic2;
    bytes32 topic3;
    bytes data;
    bytes32 txnHash;
    uint64 blockNumber;
    uint64 blockTimestamp;
    uint64 evtIndex;
    address traceFrom;
    address txFrom;
    address txTo;
    uint64 originalCallDepth;
    string emittedAfterTraceAddress;
    address userOpFrom;
    bytes4 funcSig;
}

struct ContractCallInfo {
    address traceFrom;
    uint64 callDepth;
    bytes4 funcSig;
}

struct CreationTraceData {
    uint64 blockNumber;
    uint64 blockTimestamp;
    address contractAddress;
    bytes32 initializationCodeHash;
    uint64 initializationCodeLength;
    bytes data;
    bool isFactory;
    bool directDeploy;
    address deployerAddress;
    string deployerType;
    address factoryAddress;
    string deploymentType;
    bytes4 factoryFuncSig;
    address factoryCaller;
    address txFrom;
    address txTo;
}

struct CreationsData {
    uint64 blockNumber;
    uint64 blockTimestamp;
    address contractAddress;
    bytes32 initializationCodeHash;
    uint64 initializationCodeLength;
    bytes32 deployedBytecodeHash;
    uint64 deployedBytecodeLength;
    bytes32 txnHash;
    bool isFactory;
    bool directDeploy;
    address deployerAddress;
    string deployerType;
    address factoryAddress;
    string deploymentType;
    address txFrom;
    address txTo;
    bytes4 factoryFuncSig;
    address factoryCaller;
}

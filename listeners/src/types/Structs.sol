// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

struct TracesData {
    uint64 block_timestamp;
    uint64 block_number;
    string txn_hash;
    string caller;
    string callee;
    string func_sig;
    string parent_func_sig;
    string tx_from;
    string tx_to;
    string user_op_from;
    uint64 call_depth;
    string trace_address;
    bool success;
    uint64 call_type;
}

struct LogsData {
    string contract_address;
    string topic0;
    string topic1;
    string topic2;
    string topic3;
    string data;
    string txn_hash;
    uint64 block_number;
    uint64 block_timestamp;
    uint64 evt_index;
    string trace_from;
    string tx_from;
    string tx_to;
    uint64 original_call_depth;
    string emitted_after_trace_address;
    string user_op_from;
    string func_sig;
}

struct ContractCallInfo {
    string trace_from;
    uint64 call_depth;
    string func_sig;
}

struct CreationTraceData {
    uint64 block_number;
    uint64 block_timestamp;
    string contract_address;
    string initialization_code_hash;
    uint64 initialization_code_length;
    string data;
    bool is_factory;
    bool direct_deploy;
    string deployer_address;
    string deployer_type;
    string factory_address;
    string deployment_type;
    string factory_func_sig;
    string factory_caller;
    string tx_from;
    string tx_to;
}

struct CreationsData {
    uint64 block_number;
    uint64 block_timestamp;
    string contract_address;
    string initialization_code_hash;
    uint64 initialization_code_length;
    string deployed_bytecode_hash;
    uint64 deployed_bytecode_length;
    string txn_hash;
    bool is_factory;
    bool direct_deploy;
    string deployer_address;
    string deployer_type;
    string factory_address;
    string deployment_type;
    string tx_from;
    string tx_to;
    string factory_func_sig;
    string factory_caller;
}

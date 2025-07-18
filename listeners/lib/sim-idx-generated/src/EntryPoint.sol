// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/sim-idx-sol/src/Triggers.sol";
import "lib/sim-idx-sol/src/Context.sol";

function EntryPoint$Abi() pure returns (Abi memory) {
    return Abi("EntryPoint");
}
struct EntryPoint$SigValidationFailedFunctionOutputs {
    uint256 outArg0;
}

struct EntryPoint$ValidateSenderAndPaymasterFunctionInputs {
    bytes initCode;
    address sender;
    bytes paymasterAndData;
}

struct EntryPoint$AddStakeFunctionInputs {
    uint32 unstakeDelaySec;
}

struct EntryPoint$BalanceOfFunctionInputs {
    address account;
}

struct EntryPoint$BalanceOfFunctionOutputs {
    uint256 outArg0;
}

struct EntryPoint$DepositToFunctionInputs {
    address account;
}

struct EntryPoint$DepositsFunctionInputs {
    address outArg0;
}

struct EntryPoint$DepositsFunctionOutputs {
    uint112 deposit;
    bool staked;
    uint112 stake;
    uint32 unstakeDelaySec;
    uint48 withdrawTime;
}

struct EntryPoint$GetDepositInfoFunctionInputs {
    address account;
}

struct EntryPoint$IStakeManager$DepositInfo {
    uint112 deposit;
    bool staked;
    uint112 stake;
    uint32 unstakeDelaySec;
    uint48 withdrawTime;
}

struct EntryPoint$GetDepositInfoFunctionOutputs {
    EntryPoint$IStakeManager$DepositInfo info;
}

struct EntryPoint$GetNonceFunctionInputs {
    address sender;
    uint192 key;
}

struct EntryPoint$GetNonceFunctionOutputs {
    uint256 nonce;
}

struct EntryPoint$GetSenderAddressFunctionInputs {
    bytes initCode;
}

struct EntryPoint$UserOperation {
    address sender;
    uint256 nonce;
    bytes initCode;
    bytes callData;
    uint256 callGasLimit;
    uint256 verificationGasLimit;
    uint256 preVerificationGas;
    uint256 maxFeePerGas;
    uint256 maxPriorityFeePerGas;
    bytes paymasterAndData;
    bytes signature;
}

struct EntryPoint$GetUserOpHashFunctionInputs {
    EntryPoint$UserOperation userOp;
}

struct EntryPoint$GetUserOpHashFunctionOutputs {
    bytes32 outArg0;
}

struct EntryPoint$IEntryPoint$UserOpsPerAggregator {
    EntryPoint$UserOperation[] userOps;
    address aggregator;
    bytes signature;
}

struct EntryPoint$HandleAggregatedOpsFunctionInputs {
    EntryPoint$IEntryPoint$UserOpsPerAggregator[] opsPerAggregator;
    address beneficiary;
}

struct EntryPoint$HandleOpsFunctionInputs {
    EntryPoint$UserOperation[] ops;
    address beneficiary;
}

struct EntryPoint$IncrementNonceFunctionInputs {
    uint192 key;
}

struct EntryPoint$EntryPoint$MemoryUserOp {
    address sender;
    uint256 nonce;
    uint256 callGasLimit;
    uint256 verificationGasLimit;
    uint256 preVerificationGas;
    address paymaster;
    uint256 maxFeePerGas;
    uint256 maxPriorityFeePerGas;
}

struct EntryPoint$EntryPoint$UserOpInfo {
    EntryPoint$EntryPoint$MemoryUserOp mUserOp;
    bytes32 userOpHash;
    uint256 prefund;
    uint256 contextOffset;
    uint256 preOpGas;
}

struct EntryPoint$InnerHandleOpFunctionInputs {
    bytes callData;
    EntryPoint$EntryPoint$UserOpInfo opInfo;
    bytes context_;
}

struct EntryPoint$InnerHandleOpFunctionOutputs {
    uint256 actualGasCost;
}

struct EntryPoint$NonceSequenceNumberFunctionInputs {
    address outArg0;
    uint192 outArg1;
}

struct EntryPoint$NonceSequenceNumberFunctionOutputs {
    uint256 outArg0;
}

struct EntryPoint$SimulateHandleOpFunctionInputs {
    EntryPoint$UserOperation op;
    address target;
    bytes targetCallData;
}

struct EntryPoint$SimulateValidationFunctionInputs {
    EntryPoint$UserOperation userOp;
}

struct EntryPoint$WithdrawStakeFunctionInputs {
    address withdrawAddress;
}

struct EntryPoint$WithdrawToFunctionInputs {
    address withdrawAddress;
    uint256 withdrawAmount;
}

struct EntryPoint$AccountDeployedEventParams {
    bytes32 userOpHash;
    address sender;
    address factory;
    address paymaster;
}

struct EntryPoint$DepositedEventParams {
    address account;
    uint256 totalDeposit;
}

struct EntryPoint$SignatureAggregatorChangedEventParams {
    address aggregator;
}

struct EntryPoint$StakeLockedEventParams {
    address account;
    uint256 totalStaked;
    uint256 unstakeDelaySec;
}

struct EntryPoint$StakeUnlockedEventParams {
    address account;
    uint256 withdrawTime;
}

struct EntryPoint$StakeWithdrawnEventParams {
    address account;
    address withdrawAddress;
    uint256 amount;
}

struct EntryPoint$UserOperationEventEventParams {
    bytes32 userOpHash;
    address sender;
    address paymaster;
    uint256 nonce;
    bool success;
    uint256 actualGasCost;
    uint256 actualGasUsed;
}

struct EntryPoint$UserOperationRevertReasonEventParams {
    bytes32 userOpHash;
    address sender;
    uint256 nonce;
    bytes revertReason;
}

struct EntryPoint$WithdrawnEventParams {
    address account;
    address withdrawAddress;
    uint256 amount;
}

abstract contract EntryPoint$OnAccountDeployedEvent {
    function onAccountDeployedEvent(EventContext memory ctx, EntryPoint$AccountDeployedEventParams memory inputs) virtual external;

    function triggerOnAccountDeployedEvent() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes32(0xd51a9c61267aa6196961883ecf5ff2da6619c37dac0fa92122513fb32c032d2d),
            triggerType: TriggerType.EVENT,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onAccountDeployedEvent.selector
        });
    }
}

abstract contract EntryPoint$OnBeforeExecutionEvent {
    function onBeforeExecutionEvent(EventContext memory ctx) virtual external;

    function triggerOnBeforeExecutionEvent() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes32(0xbb47ee3e183a558b1a2ff0874b079f3fc5478b7454eacf2bfc5af2ff5878f972),
            triggerType: TriggerType.EVENT,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onBeforeExecutionEvent.selector
        });
    }
}

abstract contract EntryPoint$OnDepositedEvent {
    function onDepositedEvent(EventContext memory ctx, EntryPoint$DepositedEventParams memory inputs) virtual external;

    function triggerOnDepositedEvent() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes32(0x2da466a7b24304f47e87fa2e1e5a81b9831ce54fec19055ce277ca2f39ba42c4),
            triggerType: TriggerType.EVENT,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onDepositedEvent.selector
        });
    }
}

abstract contract EntryPoint$OnSignatureAggregatorChangedEvent {
    function onSignatureAggregatorChangedEvent(EventContext memory ctx, EntryPoint$SignatureAggregatorChangedEventParams memory inputs) virtual external;

    function triggerOnSignatureAggregatorChangedEvent() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes32(0x575ff3acadd5ab348fe1855e217e0f3678f8d767d7494c9f9fefbee2e17cca4d),
            triggerType: TriggerType.EVENT,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onSignatureAggregatorChangedEvent.selector
        });
    }
}

abstract contract EntryPoint$OnStakeLockedEvent {
    function onStakeLockedEvent(EventContext memory ctx, EntryPoint$StakeLockedEventParams memory inputs) virtual external;

    function triggerOnStakeLockedEvent() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes32(0xa5ae833d0bb1dcd632d98a8b70973e8516812898e19bf27b70071ebc8dc52c01),
            triggerType: TriggerType.EVENT,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onStakeLockedEvent.selector
        });
    }
}

abstract contract EntryPoint$OnStakeUnlockedEvent {
    function onStakeUnlockedEvent(EventContext memory ctx, EntryPoint$StakeUnlockedEventParams memory inputs) virtual external;

    function triggerOnStakeUnlockedEvent() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes32(0xfa9b3c14cc825c412c9ed81b3ba365a5b459439403f18829e572ed53a4180f0a),
            triggerType: TriggerType.EVENT,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onStakeUnlockedEvent.selector
        });
    }
}

abstract contract EntryPoint$OnStakeWithdrawnEvent {
    function onStakeWithdrawnEvent(EventContext memory ctx, EntryPoint$StakeWithdrawnEventParams memory inputs) virtual external;

    function triggerOnStakeWithdrawnEvent() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes32(0xb7c918e0e249f999e965cafeb6c664271b3f4317d296461500e71da39f0cbda3),
            triggerType: TriggerType.EVENT,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onStakeWithdrawnEvent.selector
        });
    }
}

abstract contract EntryPoint$OnUserOperationEventEvent {
    function onUserOperationEventEvent(EventContext memory ctx, EntryPoint$UserOperationEventEventParams memory inputs) virtual external;

    function triggerOnUserOperationEventEvent() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes32(0x49628fd1471006c1482da88028e9ce4dbb080b815c9b0344d39e5a8e6ec1419f),
            triggerType: TriggerType.EVENT,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onUserOperationEventEvent.selector
        });
    }
}

abstract contract EntryPoint$OnUserOperationRevertReasonEvent {
    function onUserOperationRevertReasonEvent(EventContext memory ctx, EntryPoint$UserOperationRevertReasonEventParams memory inputs) virtual external;

    function triggerOnUserOperationRevertReasonEvent() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes32(0x1c4fada7374c0a9ee8841fc38afe82932dc0f8e69012e927f061a8bae611a201),
            triggerType: TriggerType.EVENT,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onUserOperationRevertReasonEvent.selector
        });
    }
}

abstract contract EntryPoint$OnWithdrawnEvent {
    function onWithdrawnEvent(EventContext memory ctx, EntryPoint$WithdrawnEventParams memory inputs) virtual external;

    function triggerOnWithdrawnEvent() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes32(0xd1c19fbcd4551a5edfb66d43d2e337c04837afda3482b42bdf569a8fccdae5fb),
            triggerType: TriggerType.EVENT,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onWithdrawnEvent.selector
        });
    }
}

abstract contract EntryPoint$OnSigValidationFailedFunction {
    function onSigValidationFailedFunction(FunctionContext memory ctx, EntryPoint$SigValidationFailedFunctionOutputs memory outputs) virtual external;

    function triggerOnSigValidationFailedFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x8f41ec5a),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onSigValidationFailedFunction.selector
        });
    }
}

abstract contract EntryPoint$PreSigValidationFailedFunction {
    function preSigValidationFailedFunction(PreFunctionContext memory ctx) virtual external;

    function triggerPreSigValidationFailedFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x8f41ec5a),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preSigValidationFailedFunction.selector
        });
    }
}

abstract contract EntryPoint$OnValidateSenderAndPaymasterFunction {
    function onValidateSenderAndPaymasterFunction(FunctionContext memory ctx, EntryPoint$ValidateSenderAndPaymasterFunctionInputs memory inputs) virtual external;

    function triggerOnValidateSenderAndPaymasterFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x957122ab),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onValidateSenderAndPaymasterFunction.selector
        });
    }
}

abstract contract EntryPoint$PreValidateSenderAndPaymasterFunction {
    function preValidateSenderAndPaymasterFunction(PreFunctionContext memory ctx, EntryPoint$ValidateSenderAndPaymasterFunctionInputs memory inputs) virtual external;

    function triggerPreValidateSenderAndPaymasterFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x957122ab),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preValidateSenderAndPaymasterFunction.selector
        });
    }
}

abstract contract EntryPoint$OnAddStakeFunction {
    function onAddStakeFunction(FunctionContext memory ctx, EntryPoint$AddStakeFunctionInputs memory inputs) virtual external;

    function triggerOnAddStakeFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x0396cb60),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onAddStakeFunction.selector
        });
    }
}

abstract contract EntryPoint$PreAddStakeFunction {
    function preAddStakeFunction(PreFunctionContext memory ctx, EntryPoint$AddStakeFunctionInputs memory inputs) virtual external;

    function triggerPreAddStakeFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x0396cb60),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preAddStakeFunction.selector
        });
    }
}

abstract contract EntryPoint$OnBalanceOfFunction {
    function onBalanceOfFunction(FunctionContext memory ctx, EntryPoint$BalanceOfFunctionInputs memory inputs, EntryPoint$BalanceOfFunctionOutputs memory outputs) virtual external;

    function triggerOnBalanceOfFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x70a08231),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onBalanceOfFunction.selector
        });
    }
}

abstract contract EntryPoint$PreBalanceOfFunction {
    function preBalanceOfFunction(PreFunctionContext memory ctx, EntryPoint$BalanceOfFunctionInputs memory inputs) virtual external;

    function triggerPreBalanceOfFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x70a08231),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preBalanceOfFunction.selector
        });
    }
}

abstract contract EntryPoint$OnDepositToFunction {
    function onDepositToFunction(FunctionContext memory ctx, EntryPoint$DepositToFunctionInputs memory inputs) virtual external;

    function triggerOnDepositToFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xb760faf9),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onDepositToFunction.selector
        });
    }
}

abstract contract EntryPoint$PreDepositToFunction {
    function preDepositToFunction(PreFunctionContext memory ctx, EntryPoint$DepositToFunctionInputs memory inputs) virtual external;

    function triggerPreDepositToFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xb760faf9),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preDepositToFunction.selector
        });
    }
}

abstract contract EntryPoint$OnDepositsFunction {
    function onDepositsFunction(FunctionContext memory ctx, EntryPoint$DepositsFunctionInputs memory inputs, EntryPoint$DepositsFunctionOutputs memory outputs) virtual external;

    function triggerOnDepositsFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xfc7e286d),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onDepositsFunction.selector
        });
    }
}

abstract contract EntryPoint$PreDepositsFunction {
    function preDepositsFunction(PreFunctionContext memory ctx, EntryPoint$DepositsFunctionInputs memory inputs) virtual external;

    function triggerPreDepositsFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xfc7e286d),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preDepositsFunction.selector
        });
    }
}

abstract contract EntryPoint$OnGetDepositInfoFunction {
    function onGetDepositInfoFunction(FunctionContext memory ctx, EntryPoint$GetDepositInfoFunctionInputs memory inputs, EntryPoint$GetDepositInfoFunctionOutputs memory outputs) virtual external;

    function triggerOnGetDepositInfoFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x5287ce12),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onGetDepositInfoFunction.selector
        });
    }
}

abstract contract EntryPoint$PreGetDepositInfoFunction {
    function preGetDepositInfoFunction(PreFunctionContext memory ctx, EntryPoint$GetDepositInfoFunctionInputs memory inputs) virtual external;

    function triggerPreGetDepositInfoFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x5287ce12),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preGetDepositInfoFunction.selector
        });
    }
}

abstract contract EntryPoint$OnGetNonceFunction {
    function onGetNonceFunction(FunctionContext memory ctx, EntryPoint$GetNonceFunctionInputs memory inputs, EntryPoint$GetNonceFunctionOutputs memory outputs) virtual external;

    function triggerOnGetNonceFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x35567e1a),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onGetNonceFunction.selector
        });
    }
}

abstract contract EntryPoint$PreGetNonceFunction {
    function preGetNonceFunction(PreFunctionContext memory ctx, EntryPoint$GetNonceFunctionInputs memory inputs) virtual external;

    function triggerPreGetNonceFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x35567e1a),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preGetNonceFunction.selector
        });
    }
}

abstract contract EntryPoint$OnGetSenderAddressFunction {
    function onGetSenderAddressFunction(FunctionContext memory ctx, EntryPoint$GetSenderAddressFunctionInputs memory inputs) virtual external;

    function triggerOnGetSenderAddressFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x9b249f69),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onGetSenderAddressFunction.selector
        });
    }
}

abstract contract EntryPoint$PreGetSenderAddressFunction {
    function preGetSenderAddressFunction(PreFunctionContext memory ctx, EntryPoint$GetSenderAddressFunctionInputs memory inputs) virtual external;

    function triggerPreGetSenderAddressFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x9b249f69),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preGetSenderAddressFunction.selector
        });
    }
}

abstract contract EntryPoint$OnGetUserOpHashFunction {
    function onGetUserOpHashFunction(FunctionContext memory ctx, EntryPoint$GetUserOpHashFunctionInputs memory inputs, EntryPoint$GetUserOpHashFunctionOutputs memory outputs) virtual external;

    function triggerOnGetUserOpHashFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xa6193531),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onGetUserOpHashFunction.selector
        });
    }
}

abstract contract EntryPoint$PreGetUserOpHashFunction {
    function preGetUserOpHashFunction(PreFunctionContext memory ctx, EntryPoint$GetUserOpHashFunctionInputs memory inputs) virtual external;

    function triggerPreGetUserOpHashFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xa6193531),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preGetUserOpHashFunction.selector
        });
    }
}

abstract contract EntryPoint$OnHandleAggregatedOpsFunction {
    function onHandleAggregatedOpsFunction(FunctionContext memory ctx, EntryPoint$HandleAggregatedOpsFunctionInputs memory inputs) virtual external;

    function triggerOnHandleAggregatedOpsFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x4b1d7cf5),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onHandleAggregatedOpsFunction.selector
        });
    }
}

abstract contract EntryPoint$PreHandleAggregatedOpsFunction {
    function preHandleAggregatedOpsFunction(PreFunctionContext memory ctx, EntryPoint$HandleAggregatedOpsFunctionInputs memory inputs) virtual external;

    function triggerPreHandleAggregatedOpsFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x4b1d7cf5),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preHandleAggregatedOpsFunction.selector
        });
    }
}

abstract contract EntryPoint$OnHandleOpsFunction {
    function onHandleOpsFunction(FunctionContext memory ctx, EntryPoint$HandleOpsFunctionInputs memory inputs) virtual external;

    function triggerOnHandleOpsFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x1fad948c),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onHandleOpsFunction.selector
        });
    }
}

abstract contract EntryPoint$PreHandleOpsFunction {
    function preHandleOpsFunction(PreFunctionContext memory ctx, EntryPoint$HandleOpsFunctionInputs memory inputs) virtual external;

    function triggerPreHandleOpsFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x1fad948c),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preHandleOpsFunction.selector
        });
    }
}

abstract contract EntryPoint$OnIncrementNonceFunction {
    function onIncrementNonceFunction(FunctionContext memory ctx, EntryPoint$IncrementNonceFunctionInputs memory inputs) virtual external;

    function triggerOnIncrementNonceFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x0bd28e3b),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onIncrementNonceFunction.selector
        });
    }
}

abstract contract EntryPoint$PreIncrementNonceFunction {
    function preIncrementNonceFunction(PreFunctionContext memory ctx, EntryPoint$IncrementNonceFunctionInputs memory inputs) virtual external;

    function triggerPreIncrementNonceFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x0bd28e3b),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preIncrementNonceFunction.selector
        });
    }
}

abstract contract EntryPoint$OnInnerHandleOpFunction {
    function onInnerHandleOpFunction(FunctionContext memory ctx, EntryPoint$InnerHandleOpFunctionInputs memory inputs, EntryPoint$InnerHandleOpFunctionOutputs memory outputs) virtual external;

    function triggerOnInnerHandleOpFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x1d732756),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onInnerHandleOpFunction.selector
        });
    }
}

abstract contract EntryPoint$PreInnerHandleOpFunction {
    function preInnerHandleOpFunction(PreFunctionContext memory ctx, EntryPoint$InnerHandleOpFunctionInputs memory inputs) virtual external;

    function triggerPreInnerHandleOpFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x1d732756),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preInnerHandleOpFunction.selector
        });
    }
}

abstract contract EntryPoint$OnNonceSequenceNumberFunction {
    function onNonceSequenceNumberFunction(FunctionContext memory ctx, EntryPoint$NonceSequenceNumberFunctionInputs memory inputs, EntryPoint$NonceSequenceNumberFunctionOutputs memory outputs) virtual external;

    function triggerOnNonceSequenceNumberFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x1b2e01b8),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onNonceSequenceNumberFunction.selector
        });
    }
}

abstract contract EntryPoint$PreNonceSequenceNumberFunction {
    function preNonceSequenceNumberFunction(PreFunctionContext memory ctx, EntryPoint$NonceSequenceNumberFunctionInputs memory inputs) virtual external;

    function triggerPreNonceSequenceNumberFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x1b2e01b8),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preNonceSequenceNumberFunction.selector
        });
    }
}

abstract contract EntryPoint$OnSimulateHandleOpFunction {
    function onSimulateHandleOpFunction(FunctionContext memory ctx, EntryPoint$SimulateHandleOpFunctionInputs memory inputs) virtual external;

    function triggerOnSimulateHandleOpFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xd6383f94),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onSimulateHandleOpFunction.selector
        });
    }
}

abstract contract EntryPoint$PreSimulateHandleOpFunction {
    function preSimulateHandleOpFunction(PreFunctionContext memory ctx, EntryPoint$SimulateHandleOpFunctionInputs memory inputs) virtual external;

    function triggerPreSimulateHandleOpFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xd6383f94),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preSimulateHandleOpFunction.selector
        });
    }
}

abstract contract EntryPoint$OnSimulateValidationFunction {
    function onSimulateValidationFunction(FunctionContext memory ctx, EntryPoint$SimulateValidationFunctionInputs memory inputs) virtual external;

    function triggerOnSimulateValidationFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xee219423),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onSimulateValidationFunction.selector
        });
    }
}

abstract contract EntryPoint$PreSimulateValidationFunction {
    function preSimulateValidationFunction(PreFunctionContext memory ctx, EntryPoint$SimulateValidationFunctionInputs memory inputs) virtual external;

    function triggerPreSimulateValidationFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xee219423),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preSimulateValidationFunction.selector
        });
    }
}

abstract contract EntryPoint$OnUnlockStakeFunction {
    function onUnlockStakeFunction(FunctionContext memory ctx) virtual external;

    function triggerOnUnlockStakeFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xbb9fe6bf),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onUnlockStakeFunction.selector
        });
    }
}

abstract contract EntryPoint$PreUnlockStakeFunction {
    function preUnlockStakeFunction(PreFunctionContext memory ctx) virtual external;

    function triggerPreUnlockStakeFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xbb9fe6bf),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preUnlockStakeFunction.selector
        });
    }
}

abstract contract EntryPoint$OnWithdrawStakeFunction {
    function onWithdrawStakeFunction(FunctionContext memory ctx, EntryPoint$WithdrawStakeFunctionInputs memory inputs) virtual external;

    function triggerOnWithdrawStakeFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xc23a5cea),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onWithdrawStakeFunction.selector
        });
    }
}

abstract contract EntryPoint$PreWithdrawStakeFunction {
    function preWithdrawStakeFunction(PreFunctionContext memory ctx, EntryPoint$WithdrawStakeFunctionInputs memory inputs) virtual external;

    function triggerPreWithdrawStakeFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0xc23a5cea),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preWithdrawStakeFunction.selector
        });
    }
}

abstract contract EntryPoint$OnWithdrawToFunction {
    function onWithdrawToFunction(FunctionContext memory ctx, EntryPoint$WithdrawToFunctionInputs memory inputs) virtual external;

    function triggerOnWithdrawToFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x205c2878),
            triggerType: TriggerType.FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.onWithdrawToFunction.selector
        });
    }
}

abstract contract EntryPoint$PreWithdrawToFunction {
    function preWithdrawToFunction(PreFunctionContext memory ctx, EntryPoint$WithdrawToFunctionInputs memory inputs) virtual external;

    function triggerPreWithdrawToFunction() view external returns (Trigger memory) {
        return Trigger({
            abiName: "EntryPoint",
            selector: bytes4(0x205c2878),
            triggerType: TriggerType.PRE_FUNCTION,
            listenerCodehash: address(this).codehash,
            handlerSelector: this.preWithdrawToFunction.selector
        });
    }
}

contract EntryPoint$EmitAllEvents is
  EntryPoint$OnAccountDeployedEvent,
EntryPoint$OnBeforeExecutionEvent,
EntryPoint$OnDepositedEvent,
EntryPoint$OnSignatureAggregatorChangedEvent,
EntryPoint$OnStakeLockedEvent,
EntryPoint$OnStakeUnlockedEvent,
EntryPoint$OnStakeWithdrawnEvent,
EntryPoint$OnUserOperationEventEvent,
EntryPoint$OnUserOperationRevertReasonEvent,
EntryPoint$OnWithdrawnEvent
{
  event AccountDeployed(bytes32 userOpHash, address sender, address factory, address paymaster);
event BeforeExecution();
event Deposited(address account, uint256 totalDeposit);
event SignatureAggregatorChanged(address aggregator);
event StakeLocked(address account, uint256 totalStaked, uint256 unstakeDelaySec);
event StakeUnlocked(address account, uint256 withdrawTime);
event StakeWithdrawn(address account, address withdrawAddress, uint256 amount);
event UserOperationEvent(bytes32 userOpHash, address sender, address paymaster, uint256 nonce, bool success, uint256 actualGasCost, uint256 actualGasUsed);
event UserOperationRevertReason(bytes32 userOpHash, address sender, uint256 nonce, bytes revertReason);
event Withdrawn(address account, address withdrawAddress, uint256 amount);

  function onAccountDeployedEvent(EventContext memory ctx, EntryPoint$AccountDeployedEventParams memory inputs) virtual external override {
    emit AccountDeployed(inputs.userOpHash, inputs.sender, inputs.factory, inputs.paymaster);
  }
function onBeforeExecutionEvent(EventContext memory ctx) virtual external override {
    emit BeforeExecution();
  }
function onDepositedEvent(EventContext memory ctx, EntryPoint$DepositedEventParams memory inputs) virtual external override {
    emit Deposited(inputs.account, inputs.totalDeposit);
  }
function onSignatureAggregatorChangedEvent(EventContext memory ctx, EntryPoint$SignatureAggregatorChangedEventParams memory inputs) virtual external override {
    emit SignatureAggregatorChanged(inputs.aggregator);
  }
function onStakeLockedEvent(EventContext memory ctx, EntryPoint$StakeLockedEventParams memory inputs) virtual external override {
    emit StakeLocked(inputs.account, inputs.totalStaked, inputs.unstakeDelaySec);
  }
function onStakeUnlockedEvent(EventContext memory ctx, EntryPoint$StakeUnlockedEventParams memory inputs) virtual external override {
    emit StakeUnlocked(inputs.account, inputs.withdrawTime);
  }
function onStakeWithdrawnEvent(EventContext memory ctx, EntryPoint$StakeWithdrawnEventParams memory inputs) virtual external override {
    emit StakeWithdrawn(inputs.account, inputs.withdrawAddress, inputs.amount);
  }
function onUserOperationEventEvent(EventContext memory ctx, EntryPoint$UserOperationEventEventParams memory inputs) virtual external override {
    emit UserOperationEvent(inputs.userOpHash, inputs.sender, inputs.paymaster, inputs.nonce, inputs.success, inputs.actualGasCost, inputs.actualGasUsed);
  }
function onUserOperationRevertReasonEvent(EventContext memory ctx, EntryPoint$UserOperationRevertReasonEventParams memory inputs) virtual external override {
    emit UserOperationRevertReason(inputs.userOpHash, inputs.sender, inputs.nonce, inputs.revertReason);
  }
function onWithdrawnEvent(EventContext memory ctx, EntryPoint$WithdrawnEventParams memory inputs) virtual external override {
    emit Withdrawn(inputs.account, inputs.withdrawAddress, inputs.amount);
  }

  function allTriggers() view external returns (Trigger[] memory) {
    Trigger[] memory triggers = new Trigger[](10);
    triggers[0] = this.triggerOnAccountDeployedEvent();
    triggers[1] = this.triggerOnBeforeExecutionEvent();
    triggers[2] = this.triggerOnDepositedEvent();
    triggers[3] = this.triggerOnSignatureAggregatorChangedEvent();
    triggers[4] = this.triggerOnStakeLockedEvent();
    triggers[5] = this.triggerOnStakeUnlockedEvent();
    triggers[6] = this.triggerOnStakeWithdrawnEvent();
    triggers[7] = this.triggerOnUserOperationEventEvent();
    triggers[8] = this.triggerOnUserOperationRevertReasonEvent();
    triggers[9] = this.triggerOnWithdrawnEvent();
    return triggers;
  }
}
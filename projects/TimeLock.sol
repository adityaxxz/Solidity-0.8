// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// time lock is a mechanism used to delay the execution of functions within a smart contract until a specified period of time has passed. This is often used for security or governance purposes, allowing stakeholders to review and confirm actions before they are actually executed.

contract TimeLock {
    address public owner;
    error NotOwnerError();
    error AlreadyQueuedError(bytes32 txId);
    error timestampNotinRangeError(uint blocktimestamp,uint timestamp);
    error NotQueuedError(bytes32 txId);
    error timestampNotPassedError(uint blocktimestamp ,uint timestamp);
    error timestampExpiredError(uint blocktimestamp ,uint expiresAt);


    event Queue(bytes32 indexed txId,address indexed target,uint value,string func ,bytes data ,uint timestamp);
    event Execute(bytes32 indexed txId,address indexed target,uint value,string func ,bytes data ,uint timestamp);
    event Cancel(bytes32 indexed txId);

    uint public constant MIN_DELAY = 10;
    uint public constant MAX_DELAY = 1000;
    uint public constant GRACE_PERIOD = 1000;


    mapping (bytes32 => bool) public queued;

    constructor() {
        owner = msg.sender;
    }

    receive () external payable {}

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwnerError();
        }
        _;
    }
    
    function getTxId(address _target,uint _value,string calldata _func ,bytes calldata _data ,uint _timestamp) public pure returns(bytes32 txId) {
        return keccak256(abi.encode(_target,_value,_func,_data,_timestamp));
    }

    function queue(address _target,uint _value,string calldata _func ,bytes calldata _data ,uint _timestamp) external onlyOwner {
        // create tx id
        // check tx id is unique
        // check timestamp 
        // queue tx = true
        bytes32 txId = getTxId(_target,_value,_func,_data,_timestamp);
        if (queued[txId]) {
            revert AlreadyQueuedError(txId);
        }

        if(_timestamp < block.timestamp + MIN_DELAY || _timestamp > block.timestamp + MAX_DELAY) {
            revert timestampNotinRangeError(block.timestamp,_timestamp);
        }

        queued[txId] = true;
        emit Queue (txId, _target,_value,_func,_data,_timestamp);
    }

    function execute(address _target,uint _value,string calldata _func ,bytes calldata _data ,uint _timestamp) external payable onlyOwner returns (bytes memory){
        // check tx is queue 
        // check block.timestamp > _timestamp
        // delete tx from queue
        // execute the tx
        bytes32 txId = getTxId(_target,_value,_func,_data,_timestamp);
        if (!queued[txId]) {
            revert NotQueuedError(txId);
        }

        if (block.timestamp < _timestamp) {
            revert timestampNotPassedError(block.timestamp ,_timestamp);
        }

        if (block.timestamp > _timestamp + GRACE_PERIOD ) {
            revert timestampExpiredError(block.timestamp,_timestamp + GRACE_PERIOD);
        }

        queued[txId] = false;

        bytes memory data;
        if (bytes(_func).length > 0) {
            data = abi.encodePacked(bytes4(keccak256(bytes(_func))), _data);
        } 
        else {
            data = _data;
        }

        (bool success ,bytes memory res) = _target.call{value: _value}(data);
        require(success , "success failed");
        emit Execute(txId ,_target,_value,_func,_data,_timestamp);
        return res;
    }

    function cancel(bytes32 _txId) external onlyOwner {
        if (!queued[_txId]) {
            revert NotQueuedError(_txId);
        } 
        queued[_txId] = false;
        emit Cancel(_txId);
    }
}

contract testTimeLock {
    address public timelock;

    constructor(address _timelock) {
        timelock = _timelock;
    }

    function test() external view {
        require(msg.sender == timelock);
    }

    function getTimestamp() external view returns (uint) {
        return block.timestamp + 100;
    }
}
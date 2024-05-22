// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// 3 ways to send ETH
// transfer - 2300 gas, reverts
// send - 2300 gas, returns bool
// call - all gas, returns bool and data (recommended)

contract SendEth {
    constructor () payable {}

    receive () external payable {}

    function sendviaTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    function sendviaSend(address payable _to) external payable {
        bool sent = _to.send(123);
        require(sent , "send failed");
    }

    function sendviaCall(address payable _to) external payable {
        (bool success ,) = _to.call{value : 123}("");
        require(success, "call failed");
    }
    
}

contract EthReceiver {
    event Log(uint amount , uint gas);

    receive () external payable { 
        emit Log(msg.value , gasleft());
    }
}
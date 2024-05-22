// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// When you declare a function as payable, it means that the function is capable 
// of receiving Ether as part of the transaction when it is called.


contract Payable {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {
        
    }

    function getbalance() external view returns (uint) {
        return address(this).balance;
    }
}
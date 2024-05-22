// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// constructors are special functions used to initialize the state variables of 
// a contract when it is deployed. The constructor function is executed only once 
// during the contract deployment process and cannot be called again afterward.

contract Constructors {
    address public owner;
    uint public x;
    
    constructor(uint a) {
        owner = msg.sender; 
        x = a;
    }   
}



// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// variable that is permanently stored in the contract's storage.
// It represents the state of the contract and can hold data that persists 
// across different function calls and throughout the lifetime of the contract.

contract StateVariable {
    uint public myUint = 123;

// local variables are variables that are defined and used within the scope 
// of a function.Unlike state variables, local variables do not persist between 
// different function invocations and are only accessible within the specific 
// function where they are declared.

    function foo() external pure {
        uint notStateVariable = 456;
    }
}
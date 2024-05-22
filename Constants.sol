// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// values that remain constant/immutable throughout the execution of a contract.
// constants reduces gas cost 

// 378 gas
contract constants {
    address public constant MY_ADDRESS = 0x7A9C7Ee18c3eE5F3eb4968f44D1bcEb8aFB76F68;
    uint public constant MY_UINT = 123;

}

// 2489 gas
contract Var {
    address public MY_ADDRESS = 0x7A9C7Ee18c3eE5F3eb4968f44D1bcEb8aFB76F68;

}
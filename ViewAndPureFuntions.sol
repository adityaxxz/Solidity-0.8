// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// pure functions cannot access any state variables, while view functions can 
// read the state variables but cannot modify them.

contract viewandpure {
    uint public num;
    function viewFunc() external view returns (uint) {
        return num;
    }

    function pureFunc() external pure returns (uint) {
        return 1;
    }

    function addnum (uint x) external view returns (uint) {
        return num + x;
    }

    function add (uint x,uint y) external pure returns (uint) {
        return x + y;
    }

}
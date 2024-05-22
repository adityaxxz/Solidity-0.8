// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// external : when we deploy this contact , we will be able to call this func.
// pure : function is read-only , it doesn't write anything to blockchain.

contract FunctionIntro {
    function add (uint x,uint y) external pure returns (uint) {
        return x + y;
    }

    function sub (uint x,uint y) external pure returns (uint) {
        return x - y;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract FunctionOutputs {
    function returnMany() public pure returns (uint , bool) {
        return (1 , true);
    }

    function named() public pure returns (uint x, bool b) {
        return (1 , true);
    }

    function assigned() public pure returns (uint x, bool b) {
        x = 1;
        b = true;
        // return (x , b);
    }

// "destructuring assignment" refers to the process of assigning multiple 
// variables in a single statement by extracting values from funtion returned 
// values or arrays.

    function destructingAssigments() public pure {
        (uint x, bool b) = returnMany();
        (, bool _b) = returnMany();   // only use 2nd output as variable
    }

}
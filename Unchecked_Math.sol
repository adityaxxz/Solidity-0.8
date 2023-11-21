// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract UncheckedMath {
    function add(uint x, uint y) external pure returns (uint) {
        // 941 gas
        return x + y;

        // 759 gas 
        // unchecked {
        //     return x + y;
        // }
    }

    function sub(uint x, uint y) external pure returns (uint) {
        // 	963 gas 

        return x - y;
        // 781 gas
        // unchecked {
        //     return x - y;
        // }
    }
    
    function sumOfCubes(uint x,uint y) external pure returns(uint) {
        unchecked {
            uint x3 = x * x * x;
            uint y3 = y * y * y;
            return x3 + y3;
        }
    }
}
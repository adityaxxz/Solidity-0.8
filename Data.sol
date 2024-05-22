// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// data types - values and references 

contract ValueTypes {
    bool public b = true;
    uint public u = 123;        // uint = uint256 0 to 2**256 - 1
                                //        uint16 0 to 2**16 - 1 
                                //        uint8 0 to 2**8 - 1 

    int public a = -123;        // int = int256 -2**255 to 2**255 - 1
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public add = 0xCCFD7490d9F4a44d3664CDCF5E2721863C507e81;
    bytes32 public b32 = 0x68d398130987158c304b7376f432d8d7f7d22f45f3ecd91215e7433b8baccd6f;
    

}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// Keccak-256 is a cryptographic hash function used to convert input data into a fixed-size hexadecimal string (usually 64 characters long).

contract HashFunc {
    function hash(string memory text , uint num , address addr) external pure
    returns(bytes32) {
        return keccak256(abi.encodePacked(text , num ,addr));
        
    }

    function encode(string memory text0 , string memory text1) external pure returns (bytes memory) {
        return (abi.encode(text0 , text1));
    }

    // modifies the bytes by making it smaller (tightly packed)
    function encodePacked(string memory text0 , string memory text1) external pure returns (bytes memory) {
        return (abi.encodePacked(text0 , text1));
    }

// Hash Collision - bytes32 value remains same for input "AA" "BB" & "A" "ABB"
    // - to avoid use a uint in between them.
    function collision(string memory text0 ,uint x, string memory text1) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text0 ,x, text1));
    }
}
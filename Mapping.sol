// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// ["alice", "bob", "charlie"]
// {"alice" : true , "bob" : true , "charlie" = true}

// Nested mapping is a two-dimensional mapping, which means that it maps an 
// address to another mapping. 

contract Mapping {
    mapping (address => uint) public balances;
    mapping (address => mapping(address => bool)) public nested;

    function examples() external {
        balances[msg.sender] = 123;
        uint bal = balances[msg.sender];
        uint bal2 = balances[address(1)];   // returns 0

        balances[msg.sender] += 456;    // add 456 to 123 = 579

        delete balances[msg.sender];    // reset to default value 0

        nested[msg.sender][address(this)] = true; 
        // sets the value of the nested mapping to true for the key msg.sender 
        // and the value address(this).
    }

}
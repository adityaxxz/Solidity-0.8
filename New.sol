// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Account {  
    address public bank;
    address public owner;

    constructor (address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}

// Deploy Account contract using AccountFactory & new keyword 
contract Accountfactory {
    Account[] public accounts;

    function createAccount(address _owner) external payable {
        Account acc = new Account{value : 100}(_owner);
        accounts.push(acc);
    }
}
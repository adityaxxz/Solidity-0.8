// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// selfdestruct
// - delete contract
// - force send Ether to any address
contract Kill {
    constructor() payable {}

    function kill() external  {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
}

contract helper {
    // returns the amount of ether stored in helper
    function getBalance() external view returns (uint) {
        return address(this).balance;

    }

    function kill(Kill _kill) external {                                                                                                                        
        _kill.kill();
    } 
}
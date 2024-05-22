// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// immutable variables cannot be modified once they are initialized in the 
// constructor or during their declaration & are evaluated at deployment time. 

contract Immutable {
    // 45712 gas - not immutable
    // 43579 gas - immutable
    address public immutable owner;
    
    constructor() {
        owner = msg.sender;
    }

    uint public x;
    function foo() external {
        require(owner == msg.sender);
        x += 1;
    }

}
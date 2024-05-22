// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// view modifier assures that the function only performs read-only operations 
// on the contract's state variables and does not modify them.

contract GlobalVariables {
    function globalvars() external view returns (address , uint , uint) {
        address sender = msg.sender;
        uint timestamp = block.timestamp;
        uint blocknum = block.number;
        return (sender , timestamp , blocknum);
    }
}
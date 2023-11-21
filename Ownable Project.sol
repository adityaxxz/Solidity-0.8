// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Ownable {
    address public owner;

    constructor () {
        owner = msg.sender;
    } 

    modifier onlyOwner() {
        require(msg.sender == owner , "not owner");
        _;
    }

    function setOwner(address newOwner) external onlyOwner {
        require (newOwner != address(0) , "Invalid Address");
        owner = newOwner;
    } 

    function OnlyOwnerCanCall() external onlyOwner {
        
    }

    function AnyoneCanCall() external  {

    }
}
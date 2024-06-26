// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }
    
    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner , "caller is not owner");
        payable(msg.sender).transfer(_amount);

        // 2nd method to transfer ether using call: 
        // (bool sent ,) = msg.sender.call{value : amount}("");
        // require(sent , "Failed to send Ether");
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// Anyone will be able to deposit eth & Only owner can withdraw
contract PiggyBank {
    address public owner = msg.sender;
    event Deposit(uint amount);
    event Withdraw(uint amount);

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner , "Not Owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }

}
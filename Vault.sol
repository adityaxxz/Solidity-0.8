// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "./IERC20.sol";

contract Vault {
    IERC20 public immutable token;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function _mint(address _to,uint _amount) private {
        totalSupply += _amount;
        balanceOf[_to] += _amount;
    }

    function _burn(address _from,uint _amount) private {
        totalSupply -= _amount;
        balanceOf[_from] -= _amount;
    } 

    function deposit(uint amount) external {
        /*
        a = amount
        b = balance of token before deposit
        t = total supply
        s = shares to mint

        (T + s) / T = (a + B) / B
        s = aT / B
        */

        uint shares;

        if (totalSupply == 0) {
            shares = amount;
        }
        else {
            shares = (amount * totalSupply) / token.balanceOf(address(this));
        }

        _mint(msg.sender,shares);
        token.transferFrom(msg.sender , address(this) , amount);

    }

    function withdraw(uint shares) external {
        /*
        a = amount
        b = balance of token before deposit
        t = total supply
        s = shares to mint

        (T - s) / T = (B - a) / B
        a = sT / B
        */

        uint amount = (shares * token.balanceOf(address(this))) / totalSupply;
        _burn(msg.sender , shares);
        token.transfer(msg.sender , amount);
    }
} 
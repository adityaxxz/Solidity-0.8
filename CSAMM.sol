// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// Constant Sum Automated Market Maker 
// In a Constant Sum AMM, the sum of the values of the tokens in the liquidity pool is kept constant, rather than the product. One popular example of a Constant Sum AMM is the Bancor protocol. In a Constant Sum AMM, when one token's quantity in the pool increases, the quantity of the other token in the pool must decrease by an amount that maintains the constant sum.

import "./IERC20_Interface.sol";

contract CSAMM {
    IERC20 public immutable token0;
    IERC20 public immutable token1;

    uint public reserve0;
    uint public reserve1;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token0,address _token1) {
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    function _mint(address _to,uint _amount) private {
        balanceOf[_to] += _amount;
        totalSupply += _amount;
    }

    function _burn(address _from,uint _amount) private {
        balanceOf[_from] -= _amount;
        totalSupply -= _amount;
    }

    function update(uint _res0,uint _res1) private {
        reserve0 = _res0;
        reserve1 = _res1;
    }

    // trade one token for another token inside this amm
    function swap(address tokenIn,uint amountIn) external returns(uint amountOut) {
        require(tokenIn == address(token0) || tokenIn == address(token1),"invalid token");

        bool istoken0 = tokenIn == address(token0);
        (IERC20 tokenin , IERC20 tokenout ,uint resIn ,uint resOut) = istoken0 ? (token0,token1,reserve0 ,reserve1 ) : (token1,token0,reserve1,reserve0);

        tokenin.transferFrom(msg.sender, address(this), amountIn);
        uint amount = tokenin.balanceOf(address(this)) - resIn;

        // calculate amount out (including fees)
        // dx = dy
        // 0.3% fee
        amountOut = (amount * 997) / 1000;

        // update reserve0 and reserve1
        (uint res0 ,uint res1) = istoken0 ? 
            (resIn + amountIn , resOut - amountOut) : (resOut - amountOut , resIn + amountIn);

        update(res0,res1);


        // transfer token out
        tokenout.transfer(msg.sender, amountOut);
    }

    // to add tokens to this amm to earn some fees
    function addLiquidity(uint _amount0,uint _amount1) external returns (uint shares){
        token0.transferFrom(msg.sender,address(this),_amount0);
        token1.transferFrom(msg.sender,address(this),_amount1);

        uint bal0 = token0.balanceOf(address(this));
        uint bal1 = token1.balanceOf(address(this));

        uint d0 = bal0 - reserve0;
        uint d1 = bal1 - reserve1;
        /*
        a = amount in
        L = total liquidity
        s = shares to mint
        T = total supply
        s = a * T / L
        */
        if(totalSupply == 0) {
            shares = d0 + d1;
        }
        else {
            shares = ((d0 + d1) * totalSupply) / (reserve0 + reserve1);
        }

        require(shares > 0,"shares = 0");
        _mint(msg.sender,shares);

        update(bal0,bal1);
    }

    function removeLiquidity(uint _shares) external returns (uint d0,uint d1)  {
        /*
        a = amount in
        L = total liquidity
        s = shares to mint
        T = total supply

        a / L = s / L
        a = L * s / T 
          = (reserve0 + reserve1) * s / T
        */

        d0 = (reserve0 * _shares) / totalSupply;
        d1 = (reserve1 * _shares) / totalSupply;

        _burn(msg.sender,_shares);
        update(reserve0 - d0,reserve1 - d1);

        if (d0 > 0) {
            token0.transfer(msg.sender,d0);
        }

        if (d1 > 0) {
            token1.transfer(msg.sender,d1);
        }
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// Function modifier - reuse code before and / or after function

contract FunctionModifier {
    bool public paused;
    uint public count;

    function setpause(bool p) external {
        paused = p;
    }

    modifier WhenNotPaused() {
        require (!paused , "paused");
        _;      // Underscore tells solidity to call the actual function that 
                // this function modifier wraps
    }
 
    function inc() external WhenNotPaused {
        count += 1;
    }

    function dec() external WhenNotPaused {
        count -= 1;
    }


    modifier cap (uint x) {
        require (x < 100, "x >= 100");
        _;
    }

    function incBy(uint x) external WhenNotPaused cap(x) {
        count += x;
    }

    modifier sandwich() {
        count += 10;
        _;
        count *= 2;

    }

    function foo() external sandwich {
        count += 1;
    }
}
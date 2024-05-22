// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// require : require statement is used to enforce certain conditions that must 
// be met for the execution of a function to proceed. If the condition specified 
// in require evaluates to false, it will throw an exception, revert any changes 
// made to the state, and stop the execution of the function.

// revert : revert statement is used to immediately stop the execution of a 
// function and revert any changes made to the state.

// assert : the assert statement is used to check for conditions that should 
// always be true. If the condition specified in assert evaluates to false, 
// it indicates an internal error or an invalid state that should never occur. 
// In such cases, the execution is immediately halted, and all state changes 
// made during the transaction are reverted.

// gas refund , state updates are reverted
// custom errors - saves gas

contract Errors {
    function testRequire(uint i) public pure {
        require (i <= 10 , "i > 10");
    }

    function testRevert(uint i) public pure {
        if (i > 10) {
            revert ("i > 10");
        }
    }

    uint public a = 123;
    function testAssert() public view {
        assert(a == 123);
    }

    function foo(uint i) public {
        a += 1;
        require (i < 10);
    }


    error MyError(address caller, uint i);

    function testCustomError(uint i) public view {
        if (i > 10) {
            revert MyError(msg.sender,i);
        }
    }
} 
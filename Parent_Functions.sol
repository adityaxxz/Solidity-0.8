// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// calling parent functions - direct & 
// super - calls all functions from parent contract

//     E
//   /   \
//  F     G
//   \   /
//     H
contract E {
    event Log(string message);
    
    function foo() public virtual {
        emit Log ("E. foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log ("F. foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log ("F. foo");
        super.bar();
    }
}

contract G is E {
    function foo() public virtual override {
        emit Log ("G. foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log ("G. foo");
        super.bar();
    }
}

contract H is F , G {
    function foo() public override(F,G) {
        F.foo();
    }

    function bar() public override(F,G) {
        super.bar();
    }    
}
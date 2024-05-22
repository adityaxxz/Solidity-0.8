// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract S {
    string public name;

    constructor (string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor (string memory _text) {
        text = _text;
    }
}

// Initialising parent constructor 
contract U is S("aditya"),T("eth") {
    
}

contract V is S, T {
    constructor (string memory _name , string memory _text) S(_name) T(_text) {}
}

contract W is S("aditya") , T {
    constructor (string memory _text) T(_text) {}
}

// Order of execution : S , T , V0
contract V0 is S, T {
    constructor (string memory _name , string memory _text) S(_name) T(_text) {}
}

// Order of execution : S , T , V1
contract V1 is S, T {
    constructor (string memory _name , string memory _text) T(_text) S(_name)  {}
}

// Order of execution : T , S , V1
contract V2 is T, S {
    constructor (string memory _name , string memory _text) T(_text) S(_name)  {}
}

// Order of execution : T , S , V1
contract V3 is T, S {
    constructor (string memory _name , string memory _text) S(_name) T(_text) {}
}

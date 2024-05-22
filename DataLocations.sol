// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// Memory vs Storage vs Calldata

// Persistence: memory is temporary and cleared after function execution, while storage 
// is persistent and retains its value between function calls. calldata is read-only and 
// represents the function call input.

// Modifiability: memory and storage can be read from and written to, while calldata is 
// read-only.

// Scope: memory is local to a function and used for temporary storage. storage is used 
// for contract-level state variables. calldata is specific to a function call and contains
// the input data.

// Gas Cost: Accessing memory and storage usually incurs gas costs, while reading from 
// calldata is usually gas-free. However, modifying memory and storage variables and 
// writing to calldata have associated gas costs.

contract DataLocations{
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping (address => MyStruct) public myStructs;

// use storage to update data and use memory to read data
    function example(uint[] calldata y , string calldata s ) external returns (uint[] memory){
        myStructs[msg.sender] = MyStruct({foo : 123 , text : "bar"});

        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "foo";

        MyStruct memory readOnly = myStructs[msg.sender];
        readOnly.foo = 456;

        _internal(y);
        _internal2(s);

        // Initialise Array in memory
        uint[] memory memArr = new uint[] (3);
        memArr[0] = 34;
        return memArr;

    }

    function _internal (uint[] calldata y) private pure {
        // uint x = y[0];
    }

    function _internal2 (string calldata s) private pure {
        // string calldata x = s;
    }
}
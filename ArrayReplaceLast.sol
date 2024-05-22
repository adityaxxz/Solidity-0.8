// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Gas efficient method , but order of array changes.
// Replace the element u want to remove , then pop the last element.

contract ArrayReplaceLast{
    uint[] public arr;

    // [1,2,3,4] -- remove(1) --> [1,4,3]
    // [1,4,3] -- remove(2) --> [1,4]

    function remove(uint index) public {
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }

    function test () external {
        arr = [1,2,3,4];
        
        remove(1);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);
        assert(arr.length == 3);

        remove(2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr.length == 2);
    }
}
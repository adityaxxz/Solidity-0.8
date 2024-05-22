 // SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Arrays {
    uint[] public nums = [1,2,3,4,5];
    uint[3] public numsFixed = [4,5,6];

    function example() external {
        uint i = nums[1];
        nums.push(6);       // [1,2,3,4,5,6]
        nums[2] = 777;      // [1,2,777,4,5,6]
        delete nums[3];     // [1,2,777,0,5,6]
        nums.pop();         // [1,2,777,0,5]
        uint len = nums.length;

        // create array in memory
        uint[] memory arr = new uint[](5);
        arr[1] = 123;
    }

    function returnArray() external view returns (uint[] memory) {
        return nums;
    }

}
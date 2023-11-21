// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// start - 50518 gas
// use calldata - 48773 gas
// load state variables to memory - 48562 gas
// short circuit - 48244 gas
// loop increments - 48214 gas
// cache array length - 48179 gas
// load array elements to memory - 48017 gas

contract GasGolf {
    uint public total;

    // [1,2,3,4,5,100]
    function sumIfEvenAndLessthan99(uint[] calldata nums) external {
        uint _total = total;
        uint len = nums.length;
        for (uint i = 0; i < len ; ++i) {
            uint num = nums[i];
            if (num % 2 == 0 && num < 99) {
                _total += num;
            }
        }
        total = _total;
    }
}
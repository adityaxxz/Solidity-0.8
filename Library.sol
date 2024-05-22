// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// using internal coz , function will be embedded inside Test 
library Math {
    function max(uint x , uint y) internal pure returns (uint){
        return x >= y ? x : y;
    }
}
contract Test {
    function testMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x,y);
    }
}

library ArrayLib {
    function find(uint[] storage arr, uint x) internal view returns(uint) {
        for (uint i = 0 ; i < arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }
        revert ("Not Found");
    }
}
contract TestArray {
    using ArrayLib for uint[]; 

    uint[] public arr = [1,2,3,4,5];
    function testFind() external view  returns (uint) {
        // return ArrayLib.find(arr,3);
        return arr.find(5);
    }
}
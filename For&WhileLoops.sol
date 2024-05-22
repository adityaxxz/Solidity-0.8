// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract ForAndWhileLoops {
    function loops() external pure {
        for (uint i = 0 ; i < 10 ; i++) {
            if (i == 5) {
                continue;
            }
            if (i == 7) {
                break;
            }
        }

        uint j = 0;
        while (j < 10) {
            j++;
        }
    }

    function sumN (uint _n) external pure returns (uint) {
        uint sum = 0;
        for (uint i = 0 ; i <= _n ; i++) {
            sum += i;
        }
        return sum;
    }
}
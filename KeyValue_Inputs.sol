// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract XYZ {
    function someFuncWithManyInputs(
        uint256 x,
        uint256 y,
        uint256 z,
        address a,
        bool b,
        string memory c
    ) public pure returns (uint256) {}

    function callFunc() external pure returns (uint256) {
        return someFuncWithManyInputs(1, 2, 3, address(0), true, "A");
    }

    function callFuncWithKeyValues() external pure returns (uint256) {
        return
            someFuncWithManyInputs({
                x: 1,
                z: 6,
                a: address(0),
                b: true,
                c: "a",
                y: 7
            });
    }
}

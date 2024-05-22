// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

interface ICounter {
    function count() external view returns (uint);
    function inc() external;
    
}

contract CallInterface {
    uint public count;

    function examples(address counter) external {
        ICounter(counter).inc();
        count = ICounter(counter).count();
    }
}
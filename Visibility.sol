// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// visibility 
// private - only inside contract
// internal - only inside contract and child contracts
// public - inside and outside contract
// external - only from outside contract

contract VisibilityBase{
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint) {
        return 0;
    }

    function internalFunc() internal pure returns(uint) {
        return 100;
    }

    function publicFunc() public pure returns(uint) {
        return 200;
    }

    function externalFunc() external  pure returns(uint) {
        return 300;
    }

    function example() external view {
        x + y + z;

        privateFunc();
        internalFunc();
        publicFunc();
        // externalFunc();     Can't call here, only from outside the contract
        // this.externalFunc();    using this we can call but more gas
    }
}

contract VisibilityChild is VisibilityBase {
    function eg() external view {
        y + z;

        internalFunc();
        publicFunc();
        
    }
}
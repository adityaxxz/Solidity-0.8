// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract TestMultiCall {
    function f1() external view returns (uint ,uint) {
        return (1 , block.timestamp);
    }

    function f2() external view returns (uint ,uint) {
        return (2 , block.timestamp);
    }

    function getData1() external pure returns(bytes memory) {
        // abi.encodeWithSignature("f1()");
        return abi.encodeWithSelector(this.f1.selector);

    }

    function getData2() external pure returns(bytes memory) {
        // abi.encodeWithSignature("f2()");
        return abi.encodeWithSelector(this.f2.selector);

    }
}

contract MultiCall {
    function multicall(address[] calldata targets , bytes[] calldata data) external view returns (bytes[] memory) {
        require(targets.length == data.length ,"targets length != data length");
        bytes[] memory results = new bytes[](data.length);

        for(uint i ; i < targets.length; i++) {
            (bool success ,bytes memory result) = targets[i].staticcall(data[i]);
            require(success , "call failed");
            results[i] = result;
        }   

        return results;
    }
}


// staticcall function is a low-level operation that allows you to execute a read-only (constant) function of another contract without actually modifying the state of the current contract. It's a way to query information from other contracts without consuming any gas.
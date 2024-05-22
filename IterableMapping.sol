// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract IterableMapping {
    mapping(address => uint) public balances;
    mapping (address => bool) public inserted;  //keeps track if key is inserted or not
    address[] public keys;     

    function set(address key , uint val) external {
        balances[key] = val;
        if (!inserted[key]) {     // key is not yet inserted
            inserted[key] = true;
            keys.push(key);
        }
    }

    function getSize() external view returns (uint) {
        return keys.length;
    }

    function first() external view returns (uint) {
        return balances[keys[0]];
    }

    function last() external view returns (uint) {
        return balances[keys[keys.length - 1]];
    }

    function get(uint i) external view returns (uint) {
        return balances[keys[i]];
    }
}
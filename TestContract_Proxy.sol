// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract TestContract1 {
    address public owner = msg.sender;

    function  setOwner  (address _owner) public  {
        require(msg.sender == owner , "Not owner");
        owner = _owner;
    }
}

contract TestContract2 {
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;

    uint public y;

    constructor (uint _x,uint _y) payable {
        x = _x;
        y = _y;
    }
}

// payable so that we can send ether when its deployed
// callvalue() - amount of etehr to send to contract 
// 0x20 = 32 in hexadecimal

contract Proxy {
    event Deploy(address);
    
    // fallback() external payable;

    function deploy(bytes memory _code) external payable returns (address addr){
        assembly {
            // create(v, p, n)
            // v = amount of ETH to send
            // p = pointer in memory to start of code
            // n = size of the code 
            addr := create(callvalue(), add(_code , 0x20) , mload(_code))
        }
        require (addr != address(0) , "deploy failed");
        // emit Deploy(addr);
    }
    
    function execute (address target,bytes memory data) external payable{
        (bool success , ) = target.call{value: msg.value}(data);
        require (success , "failed");

    }
}

contract helper {
    function getbytecode1() external pure returns (bytes memory) {
        bytes memory bytecode = type (TestContract1).creationCode;
        return bytecode;
    }

    function getbytecode2(uint _x, uint _y) external pure returns (bytes memory) {
        bytes memory bytecode = type (TestContract2).creationCode;
        return abi.encodePacked(bytecode , abi.encode(_x,_y));
    }

    function getcalldata(address _owner) external pure returns (bytes memory) {
        return abi.encodeWithSignature("setOwner(address)" , _owner);
    }

}
    
// TestContract1 = getbytecode1 -> deploy() -> copy addr from logs -> 
// deploy TestContract1 using At Address -> copy random address from above ->
// paste into getcalldata() -> copy the bytecode from it -> paste address of TestContract1
// and copied bytecode into execute() in proxy.


// TestContarct2 = getbytecode2 enter inputs -> copy bytecode & paste into execute()
// -> copy the addr from the logs -> deploy TestContract2 using At Address & enter 
// some random ether value above.
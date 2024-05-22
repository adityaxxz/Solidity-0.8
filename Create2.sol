// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// Allows to easily compute the address of the contract that u wanna deploy
contract DeployWithCreate2 {
    address public owner;

    constructor(address _owner) {
        owner = _owner; 
    }

}

//salt: random no. which determines the address of the contract to be deployed
contract Create2Factory {
    event Deploy(address addr);

    function deploy(uint _salt) external {
        DeployWithCreate2 _contract = new DeployWithCreate2{
            salt: bytes32(_salt)
        }(msg.sender);
        emit Deploy(address(_contract));
        
    }

    function getAddress(bytes memory bytecode , uint _salt) public view returns (address) {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff), address(this), _salt, keccak256(bytecode)));
        return address(uint160(uint(hash)));
    }

    function getbyteCode(address _owner) public pure returns (bytes memory) {
        bytes memory bytecode = type(DeployWithCreate2).creationCode;
        return abi.encodePacked(bytecode , abi.encode(_owner));
    }
}
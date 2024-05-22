// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Transparent upgradeable proxy pattern
// Topics :- 
// - Intro (wrong way) 
// - Return data from fallback
// - Storage for implementation and admin
// - Separate user / admin interfaces
// - Proxy admin
// - Demo

contract CounterV1 {
    uint public count;

    function inc() external {
        count += 1;
    }

    function admin() external view returns (address) {
        return address(1);
    }

    function implementation() external view returns (address) {
        return address(2);
    }
}

contract CounterV2 {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}
 
contract Proxy {
    bytes32 private constant IMPLEMENTATION_SLOT = bytes32(uint(keccak256("eip1967.proxy.implementation ")) - 1);

    bytes32 private constant ADMIN_SLOT = bytes32(uint(keccak256("eip1967.proxy.admin")) - 1);

    constructor() {
        setAdmin(msg.sender);
    }

    function _delegate(address _implementation) private {
        assembly {
            // Copy msg.data. We take full control of memory in this inline assembly
            // block because it will not return to Solidity code. We overwrite the
            // Solidity scratch pad at memory position 0.

            // calldatacopy(t, f, s) - copy s bytes from calldata at position f to memory at position t
            // calldatasize() - size of call data in bytes
            calldatacopy(0, 0, calldatasize())

            // Call the implementation.
            // out and outsize are 0 because we don't know the size yet.

            // delegatecall(g, a, in, insize, out, outsize) -
            // - call contract at address a
            // - with input memory [in…(in+insize))
            // - providing g gas
            // - and output area memory[out…(out+outsize))
            // - returning 0 on error (eg. out of gas) and 1 on success
            let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

            // Copy the returned data.
            // returndatacopy(t, f, s) - copy s bytes from returndata at position f to memory at position t
            // returndatasize() - size of the last returndata
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall returns 0 on error.
            case 0 {
                // revert(p, s) - end execution, revert state changes, return data memory[p…(p+s))
                revert(0, returndatasize())
            }
            default {
                // return(p, s) - end execution, return data memory[p…(p+s))
                return(0, returndatasize())
            }
        }
    }

    function _fallback() private {
        _delegate(getImplementation());
    }

    fallback() external payable {
        _fallback();
    }

    receive() external payable {
        _fallback();
    }

    modifier ifAdmin() {
        if (msg.sender == getAdmin()) {
            _;
        } else {
            _fallback();
        }
    }


    function changeAdmin(address _admin) external ifAdmin {
        setAdmin(_admin);
    }


    function upgradeTo(address _implementation) external ifAdmin {
        setImplementation(_implementation);
    }

    function getAdmin() private view returns (address) {
        return StorageSlot.getaddressslot(ADMIN_SLOT).value;
    }

    function setAdmin(address _admin) private {
        require(_admin != address(0),"admin is zero address");
        StorageSlot.getaddressslot(ADMIN_SLOT).value = _admin;
    }

    function getImplementation() private view returns (address) {
        return StorageSlot.getaddressslot(IMPLEMENTATION_SLOT).value;
    }

    function setImplementation(address _implementation) private {
        require(_implementation.code.length > 0 ,"not a contract");
        StorageSlot.getaddressslot(IMPLEMENTATION_SLOT).value = _implementation;
    }

    function admin() external ifAdmin returns (address) {
        return getAdmin();
    }

    function implementation() external ifAdmin returns (address) {
        return getImplementation();
    }
}

contract ProxyAdmin {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender,"not owner");
        _;
    }

    function changeProxyAdmin(address payable proxy,address _admin) external onlyOwner {
        Proxy(proxy).changeAdmin(_admin);
    }

    function upgrade(address payable proxy,address implementation) external onlyOwner {
        Proxy(proxy).upgradeTo(implementation);
    }

    function getProxyAdmin(address proxy) external view returns (address) {
        (bool ok , bytes memory res ) = proxy.staticcall(abi.encodeCall(Proxy.admin,()));
        require(ok , "call failed");
        return abi.decode(res,(address));
    }

    function getProxyImplementation(address proxy) external view returns (address) {
        (bool ok , bytes memory res ) = proxy.staticcall(abi.encodeCall(Proxy.implementation,()));
        require(ok , "call failed");
        return abi.decode(res,(address));
    }
}

library StorageSlot {
    struct AddressSlot {
        address value;
    }

    function getaddressslot(bytes32 slot) internal pure returns(AddressSlot storage r) {
        assembly {
            r.slot := slot
        }
    }
}

contract TestSlot {
    bytes32 public constant SLOT = keccak256("TEST_SLOT");

    function getSlot() external view returns (address) {
        return StorageSlot.getaddressslot(SLOT).value;
    }
 
    function writeLot(address _addr) external {
        StorageSlot.getaddressslot(SLOT).value = _addr;

    }
    
    
    
}

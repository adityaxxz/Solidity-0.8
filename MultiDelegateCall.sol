// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract MultiDelegateCall {
    error delegatecallfailed();

    function multidelegatecall(bytes[] calldata data) external payable returns (bytes[] memory results) {
        results = new bytes[](data.length);
        for (uint i ; i < data.length ; i++) {
            (bool success , bytes memory res) = address(this).delegatecall(data[i]);
            // require(success , "call failed");
            if (!success) {
                revert delegatecallfailed();
            }
            results[i] = res;
        }
    } 
}

// Why use multi delegatecall? Why not multi call?
// alice -> multi call --- call ---> test (msg.sender = multi call)

contract TestMultiDelegateCall is MultiDelegateCall {
    event Log(address caller , string func ,uint i);

    function f1(uint x , uint y) external {
        emit Log(msg.sender , "f1" ,x + y);
    }

    function f2() external returns (uint) {
        emit Log(msg.sender , "f2" , 2);
        return 111;  
    }

    mapping(address => uint) public balanceOf;
// WARNING: unsafe code when used in combination with multi-delegatecall
// user can mint multiple times for the price of msg.value
    function mint() external payable {
        balanceOf[msg.sender] += msg.value;
    }

}

contract helper {
    function getfunc1data(uint x ,uint y) external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegateCall.f1.selector ,x,y);
    }

    function getfunc2data() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegateCall.f2.selector);
    }

    function getMintData() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegateCall.mint.selector);
    }
    
}
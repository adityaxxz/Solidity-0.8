// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    // fallback () external payable {
    //    emit Log("fallback was called");
    // }

    // receive () external payable {}

    function foo(string memory _message ,uint _x) external payable returns (bool,uint) {
        message = _message;
        x = _x;
        return (true , 999);
    }
}

contract Call {
    bytes public data;

    function callfoo(address _test) external payable {
        (bool success , bytes memory _data) = _test.call{value : 111}
        (abi.encodeWithSignature("foo(string,uint256)", "call foo ",123));
        require (success , "call failed");
        data = _data;
    } 

    function callDoesNotExist(address _test) external {
       (bool success ,) =  _test.call(abi.encodeWithSignature("DoesNotExist()"));
        require (success , "call does exists");
    }
}
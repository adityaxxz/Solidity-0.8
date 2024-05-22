// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Event {
    event log(string message , uint val);
    event Indexedlog(address indexed sender , uint val);

    function example() external {
        emit log("foo",1234);
        emit Indexedlog(msg.sender, 567);
    } 
    // Smart Contract to send anyone messages , message will be public 
    event Message (address indexed _from,address indexed _to,string msg);

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to , message);
        
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// fallback function is a special func that is executed when a contract receives a message (transaction or a call) that 
// does not match any of its defined functions or does not provide any data.

// Fallback executed when :-
// - function doesn't exist
// - directly send ETH

/*
fallback() or receive() ?

    Ether is sent to contract
                |
        is msg.data empty?
              /          \
            yes           no
            /               \
    receive() exists?       fallback()
         /        \
       yes         no
      /              \
   recieve         fallback
*/
contract Fallback{
    event Log(string func, address sender , uint value , bytes data);
    fallback() external payable {
        emit Log("fallback",msg.sender,msg.value,msg.data);
    }

    // receive() external payable {
    //      emit Log("receive",msg.sender,msg.value,"");
    // }
}
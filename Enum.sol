// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Enum {
    enum Status {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }

    Status public status;

    struct Order {
        address buyer;
        Status status;

    }

    Order[] public orders;

    function get() external view returns (Status) {
        return status;
    }

    function set(Status s) external {
        status = s;
    }

    function ship() external {
        status = Status.Shipped;
    }

    function reset() external {
        delete status;     // reset the status state variable to its default value
    }
    
}
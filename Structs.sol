// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;

    }

    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function examples() external {
        Car memory bmw = Car("X5",2010, msg.sender);
        Car memory audi = Car({year : 2015 , model :"Audi A8" ,  owner : msg.sender});

        Car memory tesla;
        tesla.model = "S class";
        tesla.year = 2020;
        tesla.owner = msg.sender;

        cars.push(bmw);
        cars.push(audi);
        cars.push(tesla);

        cars.push(Car("Ferrari" , 2022 , msg.sender));

        Car storage gaadi = cars[0];   //storage stores the state variable permanantly
        gaadi.model;
        gaadi.year = 1999;

        delete gaadi.owner;
        delete cars[1];
        
    }
}
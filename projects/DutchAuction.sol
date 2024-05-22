// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// a Dutch auction is a type of auction where the price of an item starts high and gradually decreases until a buyer accepts the current price or until a specific time period expires. The first buyer to accept the current price wins the auction and purchases the item.

interface IERC721 {
    function transferFrom(address _from , address _to ,uint _nftId) external;
}

contract DutchAuction {
    uint private constant DURATION = 7 days;
    
    IERC721 public immutable nft;
    uint public immutable nftId;

    address payable public immutable seller;
    uint public immutable startingPrice;
    uint public immutable startAt;
    uint public immutable expiresAt;
    uint public immutable discountRate;

    constructor(uint _startingPrice , uint _discountRate,address _nft,uint _nftId){
        seller = payable (msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;

        require(_startingPrice >= _discountRate * DURATION , "starting price < discount ");

        nft = IERC721(_nft);
        nftId = _nftId;
    } 

    // Calculate the current price of nft
    function getPrice() public view returns (uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expiresAt , "action expired");

        uint price = getPrice();
        require(msg.value >= price , "ETH < price");

        nft.transferFrom(seller , msg.sender , nftId);
        // if buyer send to much eth then refund
        uint refund = msg.value - price;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller);
    }


}
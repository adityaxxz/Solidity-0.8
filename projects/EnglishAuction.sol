// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

interface IERC721 {
    function transferFrom(address _from , address _to ,uint _nftId) external;
}

contract EnglishAuction {
    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address highestBidder, uint amount);
 
    IERC721 public immutable nft;
    uint public immutable nftId;

    address payable public immutable seller;
    uint32 public endAt;
    bool public started;
    bool public ended;

    uint public highestBid;
    address public highestBidder;
    mapping (address => uint) public bids;

    constructor(address _nft , uint _nftId , uint _startingBid) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable (msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(msg.sender == seller , "Not Seller");
        require(!started , "Started");

        started = true;
        endAt = uint32(block.timestamp + 60);    // 60 seconds
        nft.transferFrom(seller , address (this) , nftId);
        emit Start();

    }

    function bid() external payable {
        require(started , "Not Started");
        require(block.timestamp < endAt , "ended");
        require(msg.value > highestBid , "value < highest bid");

        if (highestBidder != address(0)) {
            bids[highestBidder] += highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;
        emit Bid(msg.sender , msg.value);
        
    }

    function withdraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender , bal);
    }

    function end() external {
        require(started , "Not Started");
        require(!ended , "Ended");
        require(block.timestamp >= endAt , "not ended");

        ended = true;

        if (highestBidder != address(0)) {
            // transfer the ownership of the nft to highest bidder
            nft.transferFrom(address(this) , highestBidder , nftId);
            seller.transfer(highestBid);
        }  else {
            nft.transferFrom(address(this) , seller ,nftId);
        }
        emit End(highestBidder , highestBid);

    }
}
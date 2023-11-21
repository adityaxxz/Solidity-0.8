// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "./ERC20_TokenContract.sol";

contract StakingRewards {
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardToken;

    address public owner;
    uint public duration;
    uint public finishAt;
    uint public updateAt;
    uint public rewardRate;
    uint public rewardPerTokenStored;
    mapping(address => uint) public userRewardPerTokenPaid;
    mapping(address => uint) public rewards;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    modifier onlyOwner() {
        require(owner == msg.sender,"not owner");
        _;
    }

    modifier updateReward(address _account) {
        rewardPerTokenStored = rewardPerToken();
        updateAt = min(block.timestamp ,finishAt);

        if (_account != address(0)) {
            rewards[_account] = earned(_account);
        }
        _;
    }


    constructor(address _stakingtoken,address _rewardstoken) {
        owner = msg.sender;
        stakingToken = IERC20(_stakingtoken);
        rewardToken = IERC20(_rewardstoken);
    }

    function setRewardsDuration(uint _duration) external  onlyOwner{
        require(finishAt < block.timestamp , "reward duration not finished");
        duration = _duration;
    }

    function notifyRewardAmount(uint _amount) external  onlyOwner updateReward(address(0)) {
        if(block.timestamp > finishAt) {
            rewardRate = _amount / duration;
        } else {
            uint remainingRewards = rewardRate * (finishAt - block.timestamp);
            rewardRate = (remainingRewards + _amount) / duration;
        }
        require(rewardRate > 0 , "reward rate = 0");
        require(rewardRate * duration <= rewardToken.balanceOf(address(this)),"reward amount > balance");

        finishAt = block.timestamp + duration;
        updateAt = block.timestamp;
    }

    function stake(uint _amount) external updateReward(msg.sender) {
        require(_amount > 0 , "amount = 0 ");
        stakingToken.transferFrom(msg.sender,address(this),_amount);
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
    }

    function withdraw(uint _amount) external updateReward(msg.sender){
        require(_amount > 0 , "amount = 0 ");
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
        stakingToken.transfer(msg.sender,_amount);
    }

    // function lastTimeRewardAppicable() public view returns(uint) {
    //     return min(block.timestamp, finishAt);
    // }

    function min(uint x, uint y) private pure returns (uint) {
        return x <= y ? x : y;
    }

    function rewardPerToken() public view returns(uint) {
        if(totalSupply == 0) {
            return rewardPerTokenStored;
        }
        return rewardPerTokenStored + (rewardRate * (min(block.timestamp ,finishAt) - updateAt) * 1e18)/totalSupply;
    }

    function earned(address _account) public view returns (uint) {
        return (balanceOf[_account] * (rewardPerToken() - userRewardPerTokenPaid[_account])) / 1e18 + rewards[_account];
    }

    function getReward() external updateReward(msg.sender) {
        uint reward = rewards[msg.sender];
        if(reward > 0) {
            rewards[msg.sender] = 0;
            rewardToken.transfer(msg.sender,reward);
        }
    }
}
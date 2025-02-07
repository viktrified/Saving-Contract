// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./ERC20.sol";

contract Saving is MyToken {
    mapping(address => uint) public userBalance;

    event Save(address indexed user, uint amount);
    event Withdraw(address indexed user, uint amount);

    constructor(uint _initialSupply) MyToken(name, symbol, decimals,_initialSupply) {}

    function saveToken(uint _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        token[msg.sender] -= _amount;
        userBalance[msg.sender] += _amount;

        emit Save(msg.sender, _amount);
    }

    function withdraw(uint _amount) external {
        require(_amount > 0, "Withdraw amount must be greater than zero");
        require(userBalance[msg.sender] >= _amount, "Insufficient savings balance");
        userBalance[msg.sender] -= _amount;
        token[msg.sender] += _amount;

        emit Withdraw(msg.sender, _amount);
    }

    function checkSavings(address _user) external view returns (uint) {
        return userBalance[_user];
    }
}
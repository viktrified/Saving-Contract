// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./ERC20.sol";

contract Saving is MyToken {
    mapping(address => uint) public userBalance;

    event Save(address indexed user, uint amount);
    event Withdraw(address indexed user, uint amount);

    error AmountZero(); 
    error InsufficientBalance(uint available, uint required); 

    constructor(uint _initialSupply) MyToken(name, symbol, decimals, _initialSupply) {}

    function saveToken(uint _amount) external {
        if (_amount == 0) revert AmountZero();

        token[msg.sender] -= _amount;
        userBalance[msg.sender] += _amount;

        emit Save(msg.sender, _amount);
    }

    function withdraw(uint _amount) external {
        if (_amount == 0) revert AmountZero();
        if (userBalance[msg.sender] < _amount) revert InsufficientBalance(userBalance[msg.sender], _amount);

        userBalance[msg.sender] -= _amount;
        token[msg.sender] += _amount;

        emit Withdraw(msg.sender, _amount);
    }

    function checkSavings(address _user) external view returns (uint) {
        return userBalance[_user];
    }

    function getTotalReserve() internal view returns (uint) {
        return userBalance[address(this)];
    }
}

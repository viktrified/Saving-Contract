// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address private owner;

    mapping(address => uint256) private token;
    mapping(address => mapping(address => uint256)) private allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply) {
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * (10 ** _decimals);
        token[owner] = totalSupply;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Caller is not the contract owner");
        _;
    }

    modifier onlyCaller {
        require(msg.sender == msg.sender, "Caller is not caller");
        _;
    }

    function balanceOf(address account) public view onlyCaller returns (uint256) {
        return token[account];
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(token[msg.sender] >= amount, "ERC20: insuffient funds");
        token[msg.sender] -= amount;
        token[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
        return true;
    }

    function allowance(address _owner, address spender) public view returns (uint256) {
        _owner = owner;
        return allowances[owner][spender];
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        require(allowances[sender][msg.sender] >= amount, "ERC20: transfer amount exceeds allowance");

        allowances[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }
}
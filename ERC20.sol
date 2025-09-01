//SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ERC20 {

    address public owner;
    string public tokenName;
    string public tokenSymbol;
    uint256 public decimals = 3;


    uint256 public totalSupply;

    constructor(string memory _tokenSymbol, string memory _tokenName, uint256 _totalSupply){ 
        owner = msg.sender;
        
        tokenName = _tokenName;
        tokenSymbol = _tokenSymbol;
        totalSupply = _totalSupply;
    }

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);


    function transfer(address _to, uint256 _amount) public returns(bool success){
        require(balances[msg.sender] >= _amount, "insufficient balance");
        require(_to != address(0), "invalid address");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function transferfrom(address _from, address _to, uint256 _amount) public returns(bool success){
        require(balances[_from] >= _amount, "insufficient balance");
        require(allowances[_from][msg.sender] >= _amount, "insufficient allowance");
        require(_to != address(0), "invalid address");

        balances[_from] -= _amount;
        balances[_to] += _amount;
        allowances[_from][msg.sender] -= _amount;

        emit Transfer(_from, _to, _amount);
        return true;
    }

    function approve (address _spender, uint256 _amount) public returns(bool success){
        allowances[msg.sender][_spender] = _amount;

        
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }
}

contract Test{
        // function balanceOf(address _accountOwner) public view returns(uint256 balance_){
    //     balance_ = balances[_accountOwner];
    // }

    // function allowance(address _owner, address _spender) public view returns(uint256 allowanceBal_){
    //     allowanceBal_ = allowances[_owner][_spender];
    // }

    // function name() public view returns(string memory name_){
    //     name_ = tokenName;
    // }

    // function symbol() public view returns(string memory symbol_){
    //     symbol_ = tokenSymbol;
    // }

    // function decimals() public view returns(uint256 decimals_){
    //     decimals_ = decimals;
    // }
}
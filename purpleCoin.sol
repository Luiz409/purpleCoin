// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract purpleCoin{

        uint256 private totalSupply;
        mapping (address => uint256) public balanceOf;
        address payable private owner;
        string public name;
        string public symbol;
        uint8 public decimals;

        mapping (address => mapping(address => uint256)) private allowance;

        constructor () {
            
            owner = payable(msg.sender);
            balanceOf[owner] = totalSupply;
            name = "purpleCoin";
            symbol = "PC";
            decimals = 2;
            totalSupply = 1000 ** decimals;

        }

        modifier onlyOwner {
            require(msg.sender == owner);
            _;
        }

        receive() external payable{}

        event Approval(address indexed _owner, address indexed _spender, uint256 _value);
        event Transfer(address indexed _from, address indexed _to, uint256 _value);

        function transfer(address _to, uint256 _value) public returns (bool success){
            require (balanceOf[msg.sender] >= _value);
            require (_to != address(0));

            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;

            emit Transfer(msg.sender, _to, _value);

            return true;
        }

        function approve(address _spender, uint256 _value) public returns (bool success){
            require(_spender != address(0));
            allowance[msg.sender][_spender] = _value;

            emit Approval(msg.sender,_spender,_value);
            
            return true;
        }

        function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
            require(allowance[_from][msg.sender] >= _value);
            require(balanceOf[_from] >= _value);
            require(_from != address(0));
            require(_to != address(0));

            balanceOf[_from] -= _value;
            balanceOf[_to] += _value;
            allowance[msg.sender][_from] -= _value;

            emit Transfer(_from,_to,_value);

            return true;
        }

        function contractBalance () external view onlyOwner returns(uint256){
            return address(this).balance;
        }

    
        function withdraw () public onlyOwner { 
            owner.transfer(address(this).balance); 
        }

        function reality () public pure returns (string memory){
            return "purpleCoin >>> bitCoin";
        }
}

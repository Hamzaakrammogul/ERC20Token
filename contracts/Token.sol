//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

abstract contract Token is ERC20, Pausable{
    address public admin;

 constructor() Pausable() ERC20 ('MyToken', 'HAT') {
    _mint(msg.sender, 10000*10**18);
    admin= msg.sender;
 }
//This function will only work when token is not paused
 function mint(address to, uint amount) whenNotPaused external {
    require(msg.sender==admin,"Only Admin");
    _mint(to, amount);
 }
//This function will only works when token is paused
 function burn(uint amount) whenPaused() external{ 
    _burn(msg.sender, amount);
 }
    // Transfer tokens when not paused
     
    function transfer(address _to, uint256 _value) public whenNotPaused override returns (bool) {
        return super.transfer(_to, _value);
    }
    
    // transferFrom function to tansfer tokens when token is not paused
     
    function transferFrom(address _from, address _to, uint256 _value) public whenNotPaused override returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }
    
    // approve spender when not paused
     
    function approve(address _spender, uint256 _value) public whenNotPaused override returns (bool) {
        return super.approve(_spender, _value);
    }
    
   //increaseApproval of spender when not paused 
    function increaseAllowance(address _spender, uint _addedValue) public whenNotPaused override returns (bool success) {
        return super.increaseAllowance(_spender, _addedValue);
    }
   // decreaseApproval of spender when not paused
    function decreaseAllowance(address _spender, uint _subtractedValue) public whenNotPaused override returns (bool success) {
        return super.decreaseAllowance(_spender, _subtractedValue);
    }
}
contract RealToken is Token{
    
}
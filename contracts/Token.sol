//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";




 contract Token is ERC20, Pausable{
       address public admin;
    


 constructor() Pausable()  ERC20 ('MyToken', 'HAT') {
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
   //Transfer tokens when not paused
     
    function transfer(address to, uint256 amount) public whenNotPaused override returns (bool) {
        return super.transfer(to, amount);
    }
    
   //transferFrom function to tansfer tokens when token is not paused
     
    function transferFrom(address from, address to, uint256 amount) public whenNotPaused override returns (bool) {
        return super.transferFrom(from, to, amount);
    }
    
   //approve spender when not paused
     
    function approve(address spender, uint256 amount) public whenNotPaused override returns (bool) {
        return super.approve(spender, amount);
    }
    
   //increaseApproval of spender when not paused 
    function increaseAllowance(address spender, uint addedValue) public whenNotPaused override returns (bool ) {
        return super.increaseAllowance(spender, addedValue);
    }
   // decreaseApproval of spender when not paused
    function decreaseAllowance(address spender, uint subtractedValue) public whenNotPaused override returns (bool ) {
        return super.decreaseAllowance(spender, subtractedValue);
    }
     modifier onlyOwner{
      address owner;
      require (msg.sender==owner, "only Owner can pause");
      _;
    }

    

    

}
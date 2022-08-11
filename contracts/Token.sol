//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

contract Ownable{
    //Admin is whoever deploy the contract
       address  public admin;
    //newAdmin is whoever gets the ownership of this contract next
       address  public newAdmin;
    //An event that will emitted whenever ownership transferred sucessfully
       event OwnershipTransferred(address indexed _from, address indexed _to);

    //Modifeir that will make sure that only admin can pause the contract
     modifier onlyOwner{
      require (msg.sender==admin, "only Owner can pause");
      _;
    }
    //This function will transfer ownership from admin to new admin
    function transferOwnership(address _to) public onlyOwner {
        newAdmin = _to;
    }
    //This function will be used by newAdmin/newOwner to accept ownership
    function acceptOwnership() public {
        require(msg.sender == newAdmin);
        emit OwnershipTransferred(admin, newAdmin);
        admin = newAdmin;
        newAdmin = address(0);
    }
 
}

 contract Token is ERC20, Pausable, Ownable{

 constructor() Pausable()  ERC20 ('MyToken', 'HAT')  {
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

    //This function will Pause the function
    function pausedSet() public onlyOwner whenNotPaused  {
      return super._pause();
         }
    //This function will unPause the function
    function unPausedSet() public onlyOwner whenPaused  {
        return super._unpause();
         }
}
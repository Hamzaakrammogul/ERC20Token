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

     modifier onlyOwner{
      require (msg.sender==admin, "only Owner can access");
      _;
    }

    function transferOwnership(address _to) public onlyOwner {
        newAdmin = _to;
    }

    function acceptOwnership() public {
        require(msg.sender == newAdmin);
        emit OwnershipTransferred(admin, newAdmin);
        admin = newAdmin;
        newAdmin = address(0);
    }
}

 contract Token is ERC20, Pausable, Ownable{

 constructor() Pausable() Ownable() ERC20 ('My Token', 'HAT')  {
    _mint(msg.sender, 1000000 * 10 **18);
    admin= msg.sender;
 }

 function mint(address to, uint amount) whenNotPaused external {
    require(msg.sender==admin,"Only Admin");
    _mint(to, amount);
 }

 function burn(uint amount) external{ 
    _burn(msg.sender, amount);
 } 

    function transfer(address to, uint256 amount) public whenNotPaused override returns (bool) {
        return super.transfer(to, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public whenNotPaused override returns (bool) {
        return super.transferFrom(from, to, amount);
    }

    function approve(address spender, uint256 amount) public whenNotPaused override returns (bool) {
        return super.approve(spender, amount);
    }

    function increaseAllowance(address spender, uint addedValue) public whenNotPaused override returns (bool ) {
        return super.increaseAllowance(spender, addedValue);
    }

    function decreaseAllowance(address spender, uint subtractedValue) public whenNotPaused override returns (bool ) {
        return super.decreaseAllowance(spender, subtractedValue);
    }

    function pausedSet() public onlyOwner whenNotPaused  {
      return super._pause();
         }

    function unPausedSet() public onlyOwner whenPaused  {
        return super._unpause();
         }
          function decimals() public view virtual override returns (uint8) {
        return 18;
    }

}
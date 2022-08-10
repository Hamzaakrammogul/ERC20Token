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
}
contract RealToken is Token{
    
}
pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./BirdCoinTest.sol";

contract BirdCoinTestCrowdsale is Ownable {
 using SafeMath for uint256;

 bool public areTokensUnlocked = false;
 BirdCoin public token;

 /********************************* Events  ***********************************/

 event TokenPurchase(address indexed beneficiary, uint256 amount);

 /******************************* Constructor  ********************************/

 function BirdCoinTestCrowdsale() {
  token = new BirdCoinTest();
 }

 /******************************* Token unlock  *******************************/

 function unlockTokens() onlyOwner public {
  require(!areTokensUnlocked);
  token.unlockTokens();
  areTokensUnlocked = true;
 }
}

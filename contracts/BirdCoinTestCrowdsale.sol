pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./BirdCoinTest.sol";

contract BirdCoinTestCrowdsale is Ownable {
 using SafeMath for uint256;

 address constant ALLOCATOR_WALLET = 0x123; // some test wallet
 uint256 constant tokenAmount = 1;
 uint256 constant public CAP = 1000000 ether;
 bool public areTokensUnlocked = false;
 uint256 public tokensAllocated;
 BirdCoinTest public token;

 /********************************* Events  ***********************************/

 event TokenPurchase(address indexed beneficiary, uint256 amount);

 /******************************* Constructor  ********************************/

 function BirdCoinTestCrowdsale() {
  token = new BirdCoinTest();
 }

 /******************************** Modifiers **********************************/

 modifier onlyAllocator() {
  require(msg.sender == ALLOCATOR_WALLET);
  _;
 }

 /***************************** Token allocation  ******************************/

 function allocateTokens(address addr) public onlyAllocator {
  require(validPurchase(tokenAmount));
  tokensAllocated = tokensAllocated.add(tokenAmount);
  token.mint(addr, tokenAmount);
  TokenPurchase(msg.sender, tokenAmount);
 }

 function validPurchase(uint256 providedAmount) internal constant returns (bool) {
  bool isCapReached = tokensAllocated.add(providedAmount) > CAP;

  if (isCapReached) {
   token.finishMinting();
  }

  return !isCapReached;
 }

 /******************************* Token unlock  ********************************/

 function unlockTokens() onlyOwner public {
  require(!areTokensUnlocked);
  token.unlockTokens();
  areTokensUnlocked = true;
 }
}

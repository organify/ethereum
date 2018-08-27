pragma solidity ^0.4.24;


import "./whitelist/Whitelist.sol";
import "./Ownable.sol";
import "./SafeMath.sol";

contract MonthlySubscription is Whitelist {
   using SafeMath for uint256;
   mapping (string => uint256) private price;
    /**
    * @dev This will set the string we will use for the month + the price it will cost pe month. 
    */
   function setPrice(string _role, uint256 _price) public
   onlyOwner {
       price[_role] = _price;
   }
    /**
    * @dev This will call the price according to the string pricexmonth
    */
   function getPrice(string _role) public
   view returns (uint256)
   {
       return price[_role];
   }
    /**
    * @dev gets msg.value, makes sure its bigger than minimmun for month payment.
    */
   function subscribe(string _role) public payable{
       require(msg.value >= price[_role]);
       owner.transfer(msg.value);
       addAddressToWhitelist(msg.sender, _role);
   }

   function isSubscribed(address _address, string _role)
   public onlyIfWhitelisted(_address, _role)
   view
   returns (bool){
       //do something here
       return true;
   }
}
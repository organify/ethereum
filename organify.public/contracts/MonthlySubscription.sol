pragma solidity ^0.4.24;


import "./whitelist/Whitelist.sol";
import "./Ownable.sol";

contract MonthlySubscription is Whitelist {
    event SubscriptionRejected(address _address);

    function subscribe(address _address, string _role) public onlyOwner{
        addAddressToWhitelist(_address, _role);
    }

    function isSubscribed(address _address, string _role) 
    public onlyIfWhitelisted(_address, _role)
    view
    returns (bool){
        //do something here
        return true;
    }
}
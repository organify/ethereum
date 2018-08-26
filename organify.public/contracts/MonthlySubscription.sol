pragma solidity ^0.4.24;


import "./whitelist/Whitelist.sol";
import "./Ownable.sol";
import "./SafeMath.sol";

contract MonthlySubscription is Whitelist {
    using SafeMath for uint256;
    event SubscriptionRejected(address _address);

    function subscribe(string _role) public payable{
        // user needs to send more than 0.1 eth to successfully deploys the contract and become whitelisted
        require(msg.value > 10000000000000000);
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
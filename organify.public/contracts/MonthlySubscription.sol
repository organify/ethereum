pragma solidity ^0.4.24;


import "./whitelist/Whitelist.sol";
import "./Ownable.sol";
import "./math/SafeMath.sol";

contract MonthlySubscription is Whitelist {
   using SafeMath for uint256;

    struct BigchainDbItem {
        string Name;
        string PublicKey;
        string PrivateKey;
        address PendingTransferAddress;
        bool IsActive;
    }
   mapping (string => uint256) private price;
   mapping (address => BigchainDbItem[]) private items;
   
   /**
    * @dev set item
    */
   function setItem(address _address, string _name, string _publicKey, string _privateKey, bool isActive) public 
   onlyOwner{
        BigchainDbItem memory item = BigchainDbItem(_name, _publicKey, _privateKey, _address, isActive);
        BigchainDbItem[] storage itemList = items[_address];
        itemList.push(item);
   }
   /**
    * @dev set all item active
    */
   function setAllItemActive(address _address, bool isActive) public 
   onlyOwner{
       BigchainDbItem[] storage itemList = items[_address];
       for (uint i = 0; i < itemList.length; i++) {
           itemList[i].IsActive = isActive;
       }
   }
   /**
    * @dev set ietm
    */
   function setItemActive(address _address, string publicKey, bool isActive) public 
   onlyOwner{
       BigchainDbItem[] storage itemList = items[_address];
       var keyHash = keccak256(publicKey);
       
       for (uint i = 0; i < itemList.length; i++) {
           if(keccak256(itemList[i].PublicKey) == keyHash){
               itemList[i].IsActive = isActive;
           }
           
       }
   }

   /**
    * @dev gets item list
    */
   function getItem(address _address) public view returns(string, string, string, string) {
        BigchainDbItem[] storage itemList = items[_address];
    
        string memory name = "";
        string memory publicKey = "";
        string memory privateKey = "";
        string memory isActive = "";
        for (uint i = 0; i < itemList.length; i++) {
            BigchainDbItem storage item = itemList[i];
            
            if((bytes(item.Name)).length > 0){
                name = strConcat(name, ';', item.Name);
                publicKey = strConcat(publicKey, ';', item.PublicKey);
                privateKey = strConcat(privateKey, ';', item.PrivateKey);
                isActive = strConcat(isActive, ';',item.IsActive? '1':'0');
            }
            
        }
        return(name, publicKey, privateKey, isActive);
   }

   /**
    * @dev request transfer of ownership
    */
   function requestTransferItem(address _fromAdd, address _toAdd, string publicKey) public
   {
        require(msg.sender == _fromAdd);
       
        BigchainDbItem[] storage itemList = items[_fromAdd];
        var keyHash = keccak256(publicKey);
        
        for (uint i = 0; i < itemList.length; i++) {
            if(keccak256(itemList[i].PublicKey) == keyHash){
                itemList[i].PendingTransferAddress = _toAdd;
                break;
            }
        }
       
   }
   /**
    * @dev confirm transfer of ownership
    */
   function confirmTransferItem(address _fromAdd, address _toAdd, string publicKey) public
   {
        require(msg.sender == _toAdd);
        
        BigchainDbItem[] storage itemList = items[_fromAdd];
        BigchainDbItem[] storage resultList = items[_toAdd];
        var keyHash = keccak256(publicKey);
        
        for (uint i = 0; i < itemList.length; i++) {
            if((keccak256(itemList[i].PublicKey) == keyHash) 
            && _toAdd == itemList[i].PendingTransferAddress){
                resultList.push(itemList[i]);
                delete itemList[i];
                break;
            }
        }
   }
   /**
    * @dev concat string
    */
   function strConcat(string _a, string _b, string _c) 
   internal returns (string){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        string memory abcde = new string(_ba.length + _bb.length + _bc.length);
        bytes memory babcde = bytes(abcde);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
        for (i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
        for (i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
        return string(babcde);
    }

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

}
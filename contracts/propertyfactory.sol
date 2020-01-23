pragma solidity ^0.5.11;

import "./ownable.sol";

contract PropertyFactory is Ownable {

    event newProperty(uint propertyId, string name, uint price, string addressProperty);

    struct Property {
        string name;
        uint price;
        string addressProperty;
    }

    Property[] public properties;

    mapping (uint => address) public propertyToOwner;
    mapping (address => uint) ownerPropertyCount;

    // Création d'un bien
    function createProperty(string memory _name, uint _price, string memory _addressProperty) public {
        uint id = properties.push(Property(_name, _price, _addressProperty)) - 1;
        propertyToOwner[id] = msg.sender;
        ownerPropertyCount[msg.sender]++;
        emit newProperty(id, _name, _price, _addressProperty);
    }

    modifier onlyOwnerOf(uint _propertyId) {
    require(msg.sender == propertyToOwner[_propertyId]);
    _;
  }
}

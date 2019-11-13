pragma solidity ^0.5.11;

import "./ownable.sol";

contract PropertyFactory is Ownable {

    event newProperty(uint propertyId, uint price, string addressProperty);

    struct Property {
        uint price;
        string addressProperty;
    }

    Property[] public properties;

    mapping (uint => address) public propertyToOwner;
    mapping (address => uint) ownerPropertyCount;

    // Création d'un bien
    function _createProperty(uint _price, string memory _addressProperty) internal {
        uint id = properties.push(Property(_price, _addressProperty)) - 1;
        propertyToOwner[id] = msg.sender;
        ownerPropertyCount[msg.sender]++;
        emit newProperty(id, _price, _addressProperty);
    }
}

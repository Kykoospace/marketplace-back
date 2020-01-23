pragma solidity >=0.4.25 < 0.6.0;
pragma experimental ABIEncoderV2;

import "./propertyfactory.sol";

contract PropertyHelper is PropertyFactory {

function changeName(uint _propertyId, string calldata _newName) external onlyOwnerOf(_propertyId) {
  properties[_propertyId].name = _newName;
}

function changeAddressProperty(uint _propertyId, string calldata _newAddressProperty) external onlyOwnerOf(_propertyId) {
  properties[_propertyId].addressProperty = _newAddressProperty;
}

function getPropertiesByOwner(address _owner) public view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerPropertyCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < properties.length; i++) {
      if (propertyToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

  function getAllProperties() public view returns(Property[] memory) {
      return properties;
  }
}



pragma solidity >=0.4.25 < 0.6.0;
pragma experimental ABIEncoderV2;

import "./propertyfactory.sol";

contract PropertyHelper is PropertyFactory {

// tous les biens d'un owner
function getPropertiesByOwner(address _owner) public view returns(Property[] memory) {
  uint memory size = getTotalOfPropertiesByOwner(_owner);
  Property[] memory result = new Property[](size);
  uint counter = 0;
  for(uint i = 0 ; i < properties.length; i++) {
    if(properties[i].owner == _owner) {
      result[counter] = properties[i];
      counter++;
    }
  }
  return result;
}

// le nb de biens d'un owner
function getTotalOfPropertiesByOwner(address _owner) public view returns(uint memory) {
  uint cpt = 0;
  for(uint i = 0 ; i < properties.length; i++) {
    if(properties[i].owner == _owner) {
      cpt++;
    }
  }
  return cpt;
}

// tous les biens
function getAllProperties() public view returns(Property[] memory) {
    return properties;
}

// un bien en particulier
function getProperty(uint _idProperty) public view returns(Property memory) {
  for(uint i = 0 ; i < properties.length; i++) {
    if(properties[i].idProperty == _idProperty) {
      return properties[i];
    }
  }
}

// changement de nom d'un bien
function changeName(uint _propertyId, string calldata _newName) external {
  properties[_propertyId].name = _newName;
}

// changement d'adresse d'un bien
function changeAddressProperty(uint _propertyId, string calldata _newAddressProperty) external {
  properties[_propertyId].addressProperty = _newAddressProperty;
}

}
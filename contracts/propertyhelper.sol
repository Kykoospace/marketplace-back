pragma solidity ^0.5.11;

import "./propertyfactory.sol";

contract PropertyHelper is PropertyFactory {

function getPropertiesByOwner(address _owner) external view returns(uint[]) {
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
}
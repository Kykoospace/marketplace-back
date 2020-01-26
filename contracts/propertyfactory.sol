pragma solidity >=0.4.25 < 0.6.0;
pragma experimental ABIEncoderV2;

contract PropertyFactory {

    struct Property {
        uint idProperty;
        string name;
        uint price;
        string addressProperty;
        address owner;
    }

    Property[] public properties;

    
    address saleAddress;
    address purshaseAddress;

    event buyingProperty(address _saleAddress, address _purshaseAddress, uint price);

    constructor() public {
        purshaseAddress = msg.sender;
    }

    // Création d'un bien
    function createProperty(string memory _name, uint _price, string memory _addressProperty, address _owner) public {
        uint id = properties.length + 1;
        properties.push(Property(id, _name, _price, _addressProperty, _owner));
    }

    // Achat d'un bien
    function purshaseProperty(uint _idProperty) external payable returns(bool) {
        for(uint i = 0; i < properties.length; i++) {
            if(properties[i].idProperty == _idProperty) {
                require((msg.value - properties[i].price) > 0, "Argent insuffisant, transaction impossible");
                // ACHAT
                saleAddress = properties[i].owner;
                saleAddress.transfer(msg.value);
                emit buyingProperty(saleAddress, purshaseAddress, msg.value);
                properties[i].owner = msg.sender;
                return true;
            }
        }
        return false;
    }

    // tous les biens d'un owner
    function getPropertiesByOwner(address _owner) public view returns(Property[] memory) {
      uint size = getTotalOfPropertiesByOwner(_owner);
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
    function getTotalOfPropertiesByOwner(address _owner) public view returns(uint) {
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
    function changeName(uint _propertyId, string memory _newName) public {
      properties[_propertyId].name = _newName;
    }

    // changement d'adresse d'un bien
    function changeAddressProperty(uint _propertyId, string memory _newAddressProperty) public {
      properties[_propertyId].addressProperty = _newAddressProperty;
    }
}

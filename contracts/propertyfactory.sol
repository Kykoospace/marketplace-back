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
}
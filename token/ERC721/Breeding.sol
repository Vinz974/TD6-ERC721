pragma solidity >=0.5.0;

import "./ERC721.sol";



contract Breeding is ERC721{

struct Animal{
    string species;
    uint animalId;
    string name;
    uint age;
    string color;
    uint winCount;
    uint lossCount;
}

Animal[] public animals;
mapping(uint => address) animalToOwner;
mapping(address => uint) ownerAnimalCount;

function AnimalsByOwner(address _owner) public view returns(Animal[] memory) {
    Animal[] memory Breed;
    for (uint i = 0; i < animals.length; i++) {
        if (animalToOwner[animals[i].animalId] == _owner) {
            Breed.push(animals[i]);
        }
    }
    return Breed;
}


}
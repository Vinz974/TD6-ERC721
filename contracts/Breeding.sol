pragma solidity >= 0.5.0;

import "./ERC721.sol";



contract Breeding is ERC721{

struct Animal{
    string species;
    string name;
    uint age;
    uint readyTime;
    string color;
    uint winCount;
    uint lossCount;
}

Animal[] public animals;
address[] public Owners;
string[] public colors = ["grey","red","blue","white","brown","black"];
mapping(uint => address) animalToOwner;
mapping(address => uint) ownerAnimalCount;
mapping(string => uint) ColorToId;

event NewAnimal(uint Id, string _species, string _name, uint age, uint _readyTime, string _color,uint winCount, uint lossCount);
event DeadAnimal(uint Id, string _species, string _name, uint age, uint _readyTime, string _color,uint winCount, uint lossCount);
event BreedAnimal(uint Id1, uint Id2);

function AnimalsByOwner(address _owner) public view returns(Animal[] memory) {
    Animal[] memory Breed;
    for (uint i = 0; i < animals.length; i++) {
        if (animalToOwner[animals[i].animalId] == _owner) {
            Breed.push(animals[i]);
        }
    }
    return Breed;
}
function declareAnimal(string memory _species, uint _age, string memory _name, string memory _color) public {
    Animal storage newAnimal = Animal(_species, _name,age, 1 seconds, _color, 0, 0);
    ownerAnimalCount = ownerAnimalCount.add(1);
    uint id = animals.push(newAnimal);
    animalToOwner[id] = msg.sender;
    emit NewAnimal(id, _species, _name, _age, _color, 0, 0);
}

function deadAnimal(uint _animalId) public onlyOwner {
    address _owner = AnimalToOwner[_animalId];
    ownerAnimalCount[_owner] = ownerAnimalCount[_owner].sub(1);
    delete(animals[_animalId]);
    emit DeadAnimal(id, _species, _name, _age, _color, 0, 0);
}

function randMod(uint _modulus) internal returns(uint) {
    randNonce = randNonce.add(1);
    return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
  }

/*function BreedAnimal(uint _animalId1, uint _animalId2) {
    require(animals[_animalId1].species == animals[_animalId2].species, "Not the same species");
    uint rand = randMod(2);
    string memory _color;
    if (rand == 1){
        _color = animals[_animalId1].color;
    }
    else {
        _color = animals[_animalId2].color;
    }
    declareAnimal(animals[_animalId1].species, animals[_animalId1].name[3:] + animals[_animalId1].name[3:], 1 seconds, 0, color, 0, 0);
    animals[_animalId1].species = 0;
    animals[_animalId1].readyTime = 1 seconds;
}
*/
modifier isReadyToBreed(_animalId) {
    require(animals[_animalId].age >= 2 years, "Animal too young to couple");
    require(animals[_animalId].readyTime >= 0.5 years, "Animal already coupled in the previous 6 months");
    _;
}

function registerOwner( address _owner ) public onlyOwner {
    Owners.push(_owner);
}

modifier onlyRegistered() {
    require(isOwner(),"You are not an owner");
    _;
}
function getOwner() public returns(address[] memory){
    return Owners;
}



}
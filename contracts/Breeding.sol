pragma solidity >= 0.5.0;
pragma experimental ABIEncoderV2;

import "./ERC721.sol";
import "./Ownable.sol";

contract Breeding is ERC721, Ownable {

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
uint id = 0;
address[] public Owners;
string[] public colors = ["grey","red","blue","white","brown","black"];
uint randNonce = 0;
mapping(uint => address) animalToOwner;
mapping(address => uint) ownerAnimalCount;
mapping(string => uint) ColorToId;

event NewAnimal(uint Id, string _species, string _name, uint age, uint _readyTime, string _color,uint winCount, uint lossCount);
event DeadAnimal(uint Id, string _species, string _name, uint age, uint _readyTime, string _color,uint winCount, uint lossCount);
event BreedAnimal(uint Id1, uint Id2);

/*function AnimalsByOwner(address _owner) public view returns(Animal[] memory) {
    Animal memory cat = Animal("cat", "felix", 2, 2, "red", 0, 0);
    Animal[] memory Breeds;
    Breeds.push(cat);
    for (uint32 i = 1; i < animals.length; i++) {
        if (animalToOwner[i] == _owner) {
            Breeds.push(animals[i]);
            return Breeds;
        }
    }

}*/

function declareAnimal(address _owner, string memory _species, uint _age, string memory _name, string memory _color) public {
    require(msg.sender == _owner, "You are not declaring your animal");
    Animal memory newAnimal = Animal(_species, _name, _age, 1 seconds, _color, 0, 0);
    ownerAnimalCount[msg.sender] = ownerAnimalCount[msg.sender].add(1);
    animals.push(newAnimal);
    id = id.add(1);
    animalToOwner[id] = msg.sender;
    emit NewAnimal(id, _species, _name, _age, 0, _color, 0, 0);
}

function deadAnimal(uint _animalId) public {
    address _owner = animalToOwner[_animalId];
    ownerAnimalCount[_owner] = ownerAnimalCount[_owner].sub(1);
    delete(animals[_animalId]);
    emit DeadAnimal(_animalId, animals[_animalId].species, animals[_animalId].name, animals[_animalId].age,
    animals[_animalId].readyTime, animals[_animalId].color, animals[_animalId].winCount, animals[_animalId].lossCount);
}

function randMod(uint _modulus) internal returns(uint) {
    randNonce = randNonce.add(1);
    return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
  }

function breedAnimal(uint _animalId1, uint _animalId2) public
ReadyToBreed(_animalId1) ReadyToBreed(_animalId2) OwnerOf(_animalId1) OwnerOf(_animalId2){
    uint rand = randMod(2);
    string memory _color;
    if (rand == 1){
        _color = animals[_animalId1].color;
    }
    else {
        _color = animals[_animalId2].color;
    }
    emit BreedAnimal(_animalId1, _animalId2);
    declareAnimal(animalToOwner[_animalId1], animals[_animalId1].species,1 seconds, animals[_animalId1].name, _color);
    animals[_animalId2].readyTime = 1 seconds;
    animals[_animalId1].readyTime = 1 seconds;


}

modifier ReadyToBreed(uint _animalId) {
    require(animals[_animalId].age >= 2, "Animal too young to couple");
    require(animals[_animalId].readyTime >= 1, "Animal already coupled in the previous 6 months");
    _;
}

function registerOwner( address _owner ) public {
    Owners.push(_owner);
}

modifier onlyRegistered() {
    require(isOwner(),"You are not an owner");
    _;
}

modifier OwnerOf(uint _animalId) {
    require(msg.sender == animalToOwner[_animalId],"");
    _;
  }

function getOwner() public view returns(address[] memory){
    return Owners;
}



}
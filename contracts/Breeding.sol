pragma solidity >= 0.5.0;
pragma experimental ABIEncoderV2;

import "./ERC721.sol";
import "./Ownable.sol";

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

function AnimalsByOwner(address _owner) public view returns(Animal[] memory) {
    Animal[] memory Breeds;
    for (uint32 i = 0; i < animals.length; i++) {
        if (animalToOwner[i] == _owner) {
            //Breeds.push(animals[i]);
            return Breeds;
        }
    }

}
function declareAnimal(string memory _species, uint _age, string memory _name, string memory _color) public {
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

/*function BreedAnimal(uint _animalId1, uint _animalId2) public {
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
modifier ReadyToBreed(uint _animalId) {
    require(animals[_animalId].age >= 2, "Animal too young to couple");
    require(animals[_animalId].readyTime >= 1, "Animal already coupled in the previous 6 months");
    _;
}

function registerOwner( address _owner ) public {
    Owners.push(_owner);
}

/*modifier onlyRegistered() {
    require(isOwner(),"You are not an owner");
    _;
}
*/
function getOwner() public returns(address[] memory){
    return Owners;
}



}
pragma solidity >= 0.5.0;
pragma experimental ABIEncoderV2;

import "./Breeding.sol";


contract BidAuction is Breeding {

Animal[] public bidAnimals;

event AnimalToBid(address owner, uint animalId, string species, string name, uint age,
uint readyTime, string color, uint winCount, uint lossCount);

function setAnimalToBid(uint _animalId) public ownerOf(_animalId) {

    bidAnimals.push(animals[_animalId]);

    emit AnimalToBid(animalToOwner[_animalId], _animalId, animals[_animalId].species, animals[_animalId].name,
    animals[_animalId].age, animals[_animalId].readyTime, animals[_animalId].color, animals[_animalId].winCount, animals[_animalId].lossCount);
}
}
pragma solidity >= 0.5.0;
pragma experimental ABIEncoderV2;

import "./Breeding.sol";
import "./BidAuction.sol";

contract Fighting is Breeding, BidAuction{

struct FightAnimal{
    uint animalId;
    uint readyToFight;
}

FightAnimal[] public fightAnimals;

    function Fight(uint _fightAnimalId1, uint _fightAnimalId2) public OwnerOf(_fightAnimalId1) {
        require(fightAnimals[_fightAnimalId2].readyToFight >= 2 days, "The animal you want to fight is not ready");
        uint rand = randMod(2);
        if(rand == 1){
            animals[fightAnimals[_fightAnimalId1].animalId].winCount.add(1);
            animals[fightAnimals[_fightAnimalId2].animalId].lossCount.add(1);
        }
        else {
            animals[fightAnimals[_fightAnimalId2].animalId].winCount.add(1);
            animals[fightAnimals[_fightAnimalId1].animalId].lossCount.add(1);
        }
    }
}

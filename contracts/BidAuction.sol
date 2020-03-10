pragma solidity >= 0.5.0;
pragma experimental ABIEncoderV2;

import "./Breeding.sol";


contract BidAuction is Breeding {

BidAnimal[] public bidAnimals;
Auction[] public auctions;

struct Auction{
    uint animalId;
    uint price;
    bool validate;
}

struct BidAnimal {
    Animal myAnimal;
    uint time;
    bool alreadySold;
}

uint auctionTime = 2 days;

mapping(uint => address) auctionToOwner;
mapping(uint => address) bidAnimalToOwner;
mapping (uint => uint) bidAnimalIdToAnimalId;
event AnimalSoldAuction(address from, address to, uint animalId, uint price);
event AnimalToBid(address owner, uint animalId, string species, string name, uint age,
uint readyTime, string color, uint winCount, uint lossCount);

function setAnimalToBid(uint _animalId) public OwnerOf(_animalId) {
    BidAnimal memory bid = BidAnimal(animals[_animalId], 1 seconds, false);
    bidAnimals.push(bid);
    uint id = bidAnimals.length;
    bidAnimalIdToAnimalId[id] = _animalId;

    emit AnimalToBid(animalToOwner[_animalId], _animalId, animals[_animalId].species, animals[_animalId].name,
    animals[_animalId].age, animals[_animalId].readyTime, animals[_animalId].color, animals[_animalId].winCount, animals[_animalId].lossCount);
}

function declareAuction(uint _price, uint _animalId) public payable firstAuction(_animalId) {


}

/*function updateAuction(uint _price, uint _auctionId) public payable {

}*/

function HasNoAuction(uint _animalId) internal view returns(bool) {
    bool verif = true;
    for(uint i = 0; i < auctions.length; i++){
        if(auctionToOwner[i] == msg.sender && auctions[i].animalId == _animalId){
            verif = false;
        }
    }
    return verif;
}

modifier firstAuction(uint _animalId) {
    require(HasNoAuction(_animalId),"You already have an auction, update it");
    _;
}

function claimAuction(uint _bidAnimalId, uint _auctionId) public ValidatedAuction(_auctionId) {

    _transferFrom(bidAnimalToOwner[_bidAnimalId], msg.sender, bidAnimalIdToAnimalId[_bidAnimalId]);
    emit AnimalSoldAuction(bidAnimalToOwner[_bidAnimalId], msg.sender, bidAnimalIdToAnimalId[_bidAnimalId], auctions[_auctionId].price);
}

modifier ValidatedAuction(uint _auctionId) {
    require(auctions[_auctionId].validate,"Auction not validated, it is not your Animal");
    _;
}

/*modifier CheckedAuction(Auction storage A) {
    require(A.time <= auctionTime,"Expired Auction");
    _;
}*/
}
# **RAPPORT**

## Nicolas BAIN
## Vincent MOUTEL 

## Work done
- [X] Git repository done 
- [X] ERC721 token created 
- [X] All functions in ERC721.sol corrected (because of errors) and implemented 
- [X] *registerBreeder()* implemented in Breeding.sol 
- [X] *declareAnimal()* implemented in Breeding.sol 
- [X] *deadAnimal()* implemented in Breeding.sol 
- [X] *breedAnimal()* implemented in Breeding.sol 

- [X] *declareAuction()* and auctions done in BidAuction.sol 

- [X] *fight()* implemented inf Fighting.sol 

- [ ] We tried to test the contract on Rinkeby with the address btu we couldn't solve the problems 

# General structure 

We choosed to create a structure Animal with different features: 

**species**, **name**, **age** and **color** are the characteristics of the animal to recognize it.

**readyTime** is a cooldown before each breeding.

**winCount** and **lossCount** are used for the fights.

# Breeding

There are different mapping:
- animalToOwner to have the Owner of the animal with the Id animalId.
- ownerAnimalCount to have the number of animals by Owner 

We created 3 event: 
- NewAnimal when it is declared
- DeadAnimal when an animal died 
- BreedAnimal when two animals couple

In *declareAnimal()* we put a require to prevent from attacks because would declare an animal for another one and it is not the case here. In this function, the characteristics are given in the function and we create and push the created animal in the array animals that stores all the animals. We emit the event NewAnimal at the end.

In *deadAnimal()* we deleted the animal from the array;

In *BreedAnimal()*, we created a modifier ***ReadytoBreed(_animalId)*** to see if the animal is ready to breed. In fact we check their cooldowns **readyTime**, an animal can't couple twice in 6 months. The color is randomly choosen between the color of both parents. We also put a require to see if both animals have the same species. We created a modifier ***OwnerOf(_animalId)***.

For whitelisting, we created an array Owners in the contract. The owners are registered by the function *registerOwner(address _owner)*. 

# BidAuction 

Maybe we inversed the meaning of Auction and Bid. 

We created two structures : 
- **BidAnimal** for the animals too sell by auction 
- **Auction** to give a bid for a BidAnimal 

The function *setAnimalToBid()* was created to put an animal in auction by the owner of the animal, so we put a modifier OwnerOf(). We created an array **bidanimals** to store the animals put in auction. We emit the event *AnimalToBid* at the end.

There is only one bid per address so we created a firstAuction() modifier. The bid can be updated but we can't create two bids per adress for the same Animal. 

The function *HasNoAuction()* is used for the modifier firstAuction, we verify that there isn't two bid by animal by address.

To claim an auction, we use the function *claimAuction()*, we verify if it is the good person who uses the function with the modifier **ValidatedAuction()** and we transfer the token (the animal).

Every auction can be updated with the function *updatedAuction()*, only the price can be updated. Only the owner of the auction can modify it, we did that with the modifier *onlyAuctionner()*.

# Fighting  

A structure **FightAnimal** was created with the feature readyToFight. When an animal is readyToFight, everyone can fight it. If someone wants to fight this animal, he can use the function *fight()* and every fight is 50% win for each animal. We didn't have the time to perform that.
The winCount and the lossCount will increase and it will be better to sel them in Auction for example. 


# END


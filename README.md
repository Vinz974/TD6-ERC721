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



# Fighting  




var ERC721 = artifacts.require("ERC721");
var Breeding = artifacts.require("Breeding");


module.exports = function(deployer) {
  deployer.deploy(ERC721,arg="d_value", coderType="uint256",value=2);
  deployer.link(ERC721,Breeding);
  deployer.deploy(Breeding,arg="d_value", coderType="uint256",value=2);

};

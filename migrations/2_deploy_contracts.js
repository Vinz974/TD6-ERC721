var ERC721 = artifacts.require("ERC721");
var Breeding = artifacts.require("Breeding");
var BidAuction = artifacts.require("BidAuction");

module.exports = function(deployer) {
  deployer.deploy(ERC721);
  deployer.link(ERC721,Breeding);
  deployer.deploy(Breeding);
  deployer.deploy(BidAuction);

};

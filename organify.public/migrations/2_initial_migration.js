var Whitelist = artifacts.require("../contracts/whitelist/Whitelist.sol");

module.exports = function(deployer) {
  deployer.deploy(Whitelist);
};

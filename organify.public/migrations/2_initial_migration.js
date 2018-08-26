var Migrations = artifacts.require("../contracts/whitelist/Whitelist.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};

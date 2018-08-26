var Migrations = artifacts.require("./Migrations.sol");
var contract = artifacts.require("./MonthlySubscription.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(contract);
};

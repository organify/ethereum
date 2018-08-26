<<<<<<< HEAD
var Migrations = artifacts.require("../contracts/Migrations.sol");
=======
var Migrations = artifacts.require("./Migrations.sol");
var contract = artifacts.require("./MonthlySubscription.sol");
>>>>>>> 1a844eb62387631ee315a549dd1ebbb9e89a3858

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(contract);
};


var LevioCoin = artifacts.require("./levioCoin.sol")
module.exports = function(deployer) {

   deployer.deploy(LevioCoin,200000,"LevioCoin","LC");
};
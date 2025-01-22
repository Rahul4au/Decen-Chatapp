var Chatapp = artifacts.require("Chatapp");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(Chatapp);
};
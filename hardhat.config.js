require("@nomiclabs/hardhat-waffle");
require('dotenv').config();
require("@nomiclabs/hardhat-etherscan");


task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

module.exports = {
  solidity: "0.8.0",
  networks: {
    mainnet:{
      url: process.env.MAIN_INFURA_KEY,
      accounts: [process.env.PRIVATE_KEY],
    },
    rinkeby: {
      url: process.env.TEST_INFURA_KEY,
      accounts: [process.env.PRIVATE_KEY],
    },
  },




  etherscan: {
    apiKey: process.env.ETHERSCAN_KEY,
  }
};

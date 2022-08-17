
/** @type import('hardhat/config').HardhatUserConfig */
require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");
require("solidity-coverage");
const ALCHEMY_API_KEY="Icl_O38KLtHQI7vPpfMR31RZGG-xmr5O";
const GOERLI_PRIVATE_KEY ="887f4c88e171b054ab67669b16e99028b28b872675d6cc24cb5b7c52e9c91295";
module.exports ={
     solidity : "0.8.9",
     networks:{
      goerli:{
        url:`https://eth-goerli.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
        accounts:[`0x${GOERLI_PRIVATE_KEY}`],
     },
    },
    gasReporter:{
      enaabled:true,
    }
    };

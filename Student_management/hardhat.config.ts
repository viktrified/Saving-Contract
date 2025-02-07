import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";
dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    // for testnet
    "sepolia": {
      url: process.env.ALCHEMY_SEPOLIA_RPC_URL!,
      accounts: [process.env.ACCOUNT_PRIVATE_KEY!],
      gas: 2000000000000000,  // Adjust this as needed (2 million in this example)
      gasPrice: 1000000000,
    }
  },
  etherscan: {
    // Use "123" as a placeholder, because Blockscout doesn't need a real API key, and Hardhat will complain if this property isn't set.
    apiKey: {
      "sepolia": "PI2GX5VMYV338S6BD26R55YAKTF9TMU3J9",
    },
    customChains: [
      {
        network: "sepolia",
        chainId: 11155111,
        urls: {
          apiURL: "https://sepolia-blockscout.lisk.com/api",
          browserURL: "https://sepolia-blockscout.lisk.com/",
        },
      },
    ],
  },
};

export default config;
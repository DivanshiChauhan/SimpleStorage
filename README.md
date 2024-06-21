
# Simple Storage DApp

This project demonstrates a simple decentralized application (DApp) using a smart contract written in Solidity. The purpose of this project is to showcase the integration of a smart contract with a frontend application. The smart contract allows you to set, increment, reset, and get a stored value. The frontend is built using HTML and JavaScript and interacts with the smart contract deployed on an Ethereum blockchain.

## Description

This DApp consists of a simple contract written in Solidity and a frontend application. The Solidity contract provides basic functionalities to set, increment, reset, and get a stored value. The frontend is designed to interact with the smart contract using Web3.js, providing a user-friendly interface to interact with the blockchain.

## Getting Started

### Prerequisites

- [Remix IDE](https://remix.ethereum.org/)
- [Ganache](https://www.trufflesuite.com/ganache)
- [MetaMask](https://metamask.io/)
- [Visual Studio Code](https://code.visualstudio.com/)

### Installing

1. **Smart Contract:**

    To run the smart contract, you can use Remix, an online Solidity IDE.

    - Go to the Remix website at [Remix IDE](https://remix.ethereum.org/).
    - Create a new file by clicking on the "+" icon in the left-hand sidebar.
    - Save the file with a `.sol` extension (e.g., `SimpleStorage.sol`).
    - Copy and paste the following code into the file:

      ```solidity
      // SPDX-License-Identifier: MIT
      pragma solidity ^0.8.0;

      contract SimpleStorage {
          uint256 private storedData;

          event DataChanged(uint256 oldValue, uint256 newValue);

          function set(uint256 x) public {
              uint256 oldValue = storedData;
              storedData = x;
              emit DataChanged(oldValue, x);
          }

          function get() public view returns (uint256) {
              return storedData;
          }

          function increment() public {
              uint256 oldValue = storedData;
              storedData += 1;
              emit DataChanged(oldValue, storedData);
          }

          function reset() public {
              uint256 oldValue = storedData;
              storedData = 0;
              emit DataChanged(oldValue, storedData);
          }
      }
      ```

    - Compile the code by clicking on the "Solidity Compiler" tab in the left-hand sidebar. Ensure the "Compiler" option is set to `0.8.0` (or another compatible version), and then click on the "Compile SimpleStorage.sol" button.
    - Deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "SimpleStorage" contract from the dropdown menu, and then click on the "Deploy" button.

2. **Frontend Application:**

    - Open Visual Studio Code and create a new file named `index.html`.
    - Copy and paste the following code into the `index.html` file but change the contract ABI and Address to your contract's ABI and Address :

      ```html
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Simple Storage DApp</title>
          <script src="https://cdn.jsdelivr.net/npm/web3@1.3.5/dist/web3.min.js"></script>
          <style>
              body {
                  font-family: Arial, sans-serif;
                  margin: 0;
                  padding: 0;
                  background-color: #a5c6e2;
              }
              .container {
                  max-width: 600px;
                  margin: 50px auto;
                  padding: 20px;
                  background-color: #fff;
                  border-radius: 5px;
                  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
              }
              h1 {
                  text-align: center;
              }
              .input-container {
                  margin-bottom: 20px;
              }
              .input-container input {
                  width: calc(100% - 140px);
                  padding: 10px;
                  border: 1px solid #d2b6d2;
                  border-radius: 5px;
              }
              .input-container button {
                  width: 120px;
                  padding: 10px;
                  border: none;
                  border-radius: 5px;
                  background-color: #dcb2e5;
                  color: #110606;
                  cursor: pointer;
              }
              .output {
                  margin-top: 20px;
                  padding: 10px;
                  background-color: #f0f0f0;
                  border: 1px solid #ccc;
                  border-radius: 5px;
              }
          </style>
      </head>
      <body>
          <div class="container">
              <h1>Simple Storage DApp</h1>
              <div class="input-container">
                  <input type="number" id="dataInput" placeholder="Enter a number">
              
                  <button onclick="setData()">Set Data</button>
              </div>
              <div class="input-container">
                  <button onclick="incrementData()">Increment Data</button>
              </div>
              <div class="input-container">
                  <button onclick="resetData()">Reset Data</button>
              </div>
              <div class="input-container">
                  <button onclick="getData()">Get Data</button>
              </div>
              <p id="output"></p>
          </div>

          <script>
              const contractABI = [
                  {
                      "anonymous": false,
                      "inputs": [
                          {
                              "indexed": false,
                              "internalType": "uint256",
                              "name": "oldValue",
                              "type": "uint256"
                          },
                          {
                              "indexed": false,
                              "internalType": "uint256",
                              "name": "newValue",
                              "type": "uint256"
                          }
                      ],
                      "name": "DataChanged",
                      "type": "event"
                  },
                  {
                      "inputs": [],
                      "name": "increment",
                      "outputs": [],
                      "stateMutability": "nonpayable",
                      "type": "function"
                  },
                  {
                      "inputs": [],
                      "name": "reset",
                      "outputs": [],
                      "stateMutability": "nonpayable",
                      "type": "function"
                  },
                  {
                      "inputs": [
                          {
                              "internalType": "uint256",
                              "name": "x",
                              "type": "uint256"
                          }
                      ],
                      "name": "set",
                      "outputs": [],
                      "stateMutability": "nonpayable",
                      "type": "function"
                  },
                  {
                      "inputs": [],
                      "name": "get",
                      "outputs": [
                          {
                              "internalType": "uint256",
                              "name": "",
                              "type": "uint256"
                          }
                      ],
                      "stateMutability": "view",
                      "type": "function"
                  }
              ]

              const contractAddress = '0xe21FAD1C1e2160691C864583814d6a82D2Fe6FEE';

              async function initWeb3() {
                  // Modern dapp browsers...
                  if (window.ethereum) {
                      window.web3 = new Web3(window.ethereum);
                      try {
                          // Request account access
                          await window.ethereum.enable();
                          console.log("Ethereum enabled");
                      } catch (error) {
                          // User denied account access...
                          console.error("User denied account access");
                      }
                  }
                  // Legacy dapp browsers...
                  else if (window.web3) {
                      window.web3 = new Web3(web3.currentProvider);
                      console.log("Injected web3 detected");
                  }
                  // Fallback to localhost; use dev console port by default...
                  else {
                      console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
                      window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
                  }
              }

              // Call initWeb3 when the page loads
              window.addEventListener('load', function() {
                  initWeb3();
              });

              async function setData() {
                  const value = document.getElementById('dataInput').value;
                  try {
                      const accounts = await window.web3.eth.getAccounts();
                      const contract = new window.web3.eth.Contract(contractABI, contractAddress);
                      await contract.methods.set(value).send({ from: accounts[0] });
                      console.log('Data set successfully.');
                  } catch (error) {
                      console.error(error);
                  }
              }

              async function getData() {
                  try {
                      const contract = new window.web3.eth.Contract(contractABI, contractAddress);
                      const value = await contract.methods.get().call();
                      document.getElementById('output').innerText = 'Stored Value: ' + value;
                  } catch (error) {
                      console.error(error);
                  }
              }

              async function incrementData() {
                  try {
                      const accounts = await window.web3.eth.getAccounts();
                      const contract = new window.web3.eth.Contract(contractABI, contractAddress);
                      await contract.methods.increment().send({ from: accounts[0] });
                      console.log('Data incremented successfully.');
                  } catch (error) {
                      console.error(error);
                  }
              }

              async function resetData() {
                  try {
                      const accounts = await window.web3.eth.getAccounts();
                      const contract = new window.web3.eth.Contract(contractABI, contractAddress);
                      await contract.methods.reset().send({ from: accounts[0] });
                      console.log('Data reset successfully.');
                  } catch (error) {
                      console.error(error);
                  }
              }
          </script>
      </body>
      </html>
      ```

### Running the Frontend Application

1. Open Ganache and start a new workspace to simulate a blockchain network.
2. Make sure MetaMask is configured to connect to the Ganache network.
3. Open the `index.html` file in your browser. You can do this by simply dragging the file into the browser window or opening it through a local web server.

## Authors

Divanshi  
[DivanshiChauhan](https://github.com/DivanshiChauhan)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployBox is Script {
    function run() external returns (address) {
        address proxy = deployBox();
        return proxy;
    }

    function deployBox() public returns (address) {
        vm.startBroadcast();
        BoxV1 box = new BoxV1(); // implementation (logic contract)
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), "");
        BoxV1(address(proxy)).initialize();
        vm.stopBroadcast();
        return address(proxy);
    }
}



// make deploy ARGS="--network sepolia"
// [⠔] Compiling...
// [⠘] Compiling 1 files with 0.8.21
// [⠊] Solc 0.8.21 finished in 12.29s
// Compiler run successful!
// Traces:
//   [911941] DeployBox::run()
//     ├─ [0] VM::startBroadcast()
//     │   └─ ← ()
//     ├─ [713499] → new BoxV1@0x3F3A670eB918486Da8f066Fb511D4138Bfe22237
//     │   ├─ emit Initialized(version: 255)
//     │   └─ ← 3446 bytes of code
//     ├─ [59670] → new ERC1967Proxy@0x6D825506bdaA6524674c80BEdB2E1F4D9E4fD3bD
//     │   ├─ emit Upgraded(implementation: BoxV1: [0x3F3A670eB918486Da8f066Fb511D4138Bfe22237])
//     │   └─ ← 177 bytes of code
//     ├─ [48750] ERC1967Proxy::initialize()
//     │   ├─ [48358] BoxV1::initialize() [delegatecall]
//     │   │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: 0x404d12d289657809A152F0695c4B347690B3a442)
//     │   │   ├─ emit Initialized(version: 1)
//     │   │   └─ ← ()
//     │   └─ ← ()
//     ├─ [0] VM::stopBroadcast()
//     │   └─ ← ()
//     └─ ← ERC1967Proxy: [0x6D825506bdaA6524674c80BEdB2E1F4D9E4fD3bD]


// Script ran successfully.

// == Return ==
// 0: address 0x6D825506bdaA6524674c80BEdB2E1F4D9E4fD3bD

// ## Setting up (1) EVMs.
// ==========================
// Simulated On-chain Traces:

//   [822951] → new BoxV1@0x3F3A670eB918486Da8f066Fb511D4138Bfe22237
//     ├─ emit Initialized(version: 255)
//     └─ ← 3446 bytes of code

//   [135226] → new ERC1967Proxy@0x6D825506bdaA6524674c80BEdB2E1F4D9E4fD3bD
//     ├─ emit Upgraded(implementation: BoxV1: [0x3F3A670eB918486Da8f066Fb511D4138Bfe22237])
//     └─ ← 177 bytes of code

//   [83603] ERC1967Proxy::initialize()
//     ├─ [48358] BoxV1::initialize() [delegatecall]
//     │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: 0x404d12d289657809A152F0695c4B347690B3a442)
//     │   ├─ emit Initialized(version: 1)
//     │   └─ ← ()
//     └─ ← ()


// ==========================

// Chain 11155111

// Estimated gas price: 3.000000092 gwei

// Estimated total gas used for script: 1354312

// Estimated amount required: 0.004062936124596704 ETH

// ==========================

// ###
// Finding wallets for all the necessary addresses...
// ##
// Sending transactions [0 - 2].
// ⠙ [00:00:00] [############################################################################################################################################] 3/3 txes (0.0s)
// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/broadcast/DeployBox.s.sol/11155111/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/cache/DeployBox.s.sol/11155111/run-latest.json

// ##
// Waiting for receipts.
// ⠚ [00:00:07] [########################################################################################################################################] 3/3 receipts (0.0s)
// ##### sepolia
// ✅  [Success]Hash: 0xc0a5249e5c38595c682c4b005d47f4f43de80d2d94ede3c3b7411062de0f48b0
// Contract Address: 0x3F3A670eB918486Da8f066Fb511D4138Bfe22237
// Block: 4591795
// Paid: 0.002469555033750585 ETH (823185 gas * 3.000000041 gwei)


// ##### sepolia
// ✅  [Success]Hash: 0x78114293862e31d4e788bbae3868d4dda3bdffc67ba39fe930ca31533c501d9c
// Contract Address: 0x6D825506bdaA6524674c80BEdB2E1F4D9E4fD3bD
// Block: 4591795
// Paid: 0.000405936005547792 ETH (135312 gas * 3.000000041 gwei)


// ##### sepolia
// ✅  [Success]Hash: 0x3ec1c88350f1d04d92f15d814fca6c871977048d8e37cd6fbea8a1a5ceb4f168
// Block: 4591795
// Paid: 0.000222942003046874 ETH (74314 gas * 3.000000041 gwei)


// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/broadcast/DeployBox.s.sol/11155111/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/cache/DeployBox.s.sol/11155111/run-latest.json



// ==========================

// ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
// Total Paid: 0.003098433042345251 ETH (1032811 gas * avg 3.000000041 gwei)
// ##
// Start verification for (2) contracts
// Start verifying contract `0x3F3A670eB918486Da8f066Fb511D4138Bfe22237` deployed on sepolia

// Submitting verification for [src/BoxV1.sol:BoxV1] "0x3F3A670eB918486Da8f066Fb511D4138Bfe22237".

// Submitting verification for [src/BoxV1.sol:BoxV1] "0x3F3A670eB918486Da8f066Fb511D4138Bfe22237".

// Submitting verification for [src/BoxV1.sol:BoxV1] "0x3F3A670eB918486Da8f066Fb511D4138Bfe22237".

// Submitting verification for [src/BoxV1.sol:BoxV1] "0x3F3A670eB918486Da8f066Fb511D4138Bfe22237".

// Submitting verification for [src/BoxV1.sol:BoxV1] "0x3F3A670eB918486Da8f066Fb511D4138Bfe22237".
// Submitted contract for verification:
//         Response: `OK`
//         GUID: `xzkqw2tqhkhgunbuu32duseggcpri3axfcj5cmkpbpejyftr7j`
//         URL:
//         https://sepolia.etherscan.io/address/0x3f3a670eb918486da8f066fb511d4138bfe22237
// Contract verification status:
// Response: `NOTOK`
// Details: `Pending in queue`
// Contract verification status:
// Response: `OK`
// Details: `Pass - Verified`
// Contract successfully verified
// Start verifying contract `0x6D825506bdaA6524674c80BEdB2E1F4D9E4fD3bD` deployed on sepolia

// Contract [lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol:ERC1967Proxy] "0x6D825506bdaA6524674c80BEdB2E1F4D9E4fD3bD" is already verified. Skipping verification.
// All (2) contracts were verified!

// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/broadcast/DeployBox.s.sol/11155111/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/cache/DeployBox.s.sol/11155111/run-latest.json

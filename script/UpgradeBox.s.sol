// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {
        address mostRecentlyDeployedProxy = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        address proxy = upgradeBox(mostRecentlyDeployedProxy, address(newBox));
        return proxy;
    }

    function upgradeBox(address proxyAddress, address newBox) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(payable(proxyAddress));
        proxy.upgradeTo(address(newBox)); // proxy contract now points to this new address
        vm.stopBroadcast();
        return address(proxy);
    }
}


// make upgrade ARGS="--network sepolia"
// [⠰] Compiling...
// [⠃] Compiling 2 files with 0.8.21
// [⠊] Solc 0.8.21 finished in 8.42s
// Compiler run successful!
// 2023-10-30T04:46:52.243352Z ERROR apply:ext: evm::cheatcodes: non-empty stderr args=["bash", "/home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/lib/foundry-devops/src/get_recent_deployment.sh", "ERC1967Proxy", "11155111", "/home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23//broadcast"] stderr="/home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/lib/foundry-devops/src/get_recent_deployment.sh: line 31: jq: command not found\n/home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/lib/foundry-devops/src/get_recent_deployment.sh: line 33: jq: command not found\n/home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/lib/foundry-devops/src/get_recent_deployment.sh: line 35: ((: i<: syntax error: operand expected (error token is \"<\")\n"
// Traces:
//   [639098] → new DevOpsTools@0x22e2B88a10543eDE592166Ba873d68F60e4B1E1b
//     └─ ← 3192 bytes of code

//   [1002945] → new UpgradeBox@0x5b73C5498c1E3b4dbA84de0F1833c4a029d90519
//     └─ ← 4899 bytes of code

//   [59787] UpgradeBox::run()
//     ├─ [35769] DevOpsTools::e374cdf1(00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000aa36a7000000000000000000000000000000000000000000000000000000000000000c4552433139363750726f78790000000000000000000000000000000000000000) [delegatecall]
//     │   ├─ [0] VM::ffi([pwd])
//     │   │   └─ ← 0x2f686f6d652f736861646f772d77616c6b65722f666f756e6472792d66756c6c2d636f757273652d6632332f666f756e6472792d75706772616465732d663233
//     │   ├─ [0] VM::toString(11155111 [1.115e7]) [staticcall]
//     │   │   └─ ← 0x000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000083131313535313131000000000000000000000000000000000000000000000000
//     │   ├─ [0] VM::ffi([bash, /home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23/lib/foundry-devops/src/get_recent_deployment.sh, ERC1967Proxy, 11155111, /home/shadow-walker/foundry-full-course-f23/foundry-upgrades-f23//broadcast])
//     │   │   └─ ← 0x0000000000000000000000000000000000000000
//     │   ├─ [0] console::log(Return Data:) [staticcall]
//     │   │   └─ ← ()
//     │   ├─ [0] console::log(0x0000000000000000000000000000000000000000) [staticcall]
//     │   │   └─ ← ()
//     │   └─ ← 0x08c379a0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000144e6f20636f6e7472616374206465706c6f796564000000000000000000000000
//     └─ ← "No contract deployed"



// == Logs ==
//   Return Data:
//   0x0000000000000000000000000000000000000000
// Error:
// No contract deployed

// make: *** [Makefile:40: upgrade] Error 1

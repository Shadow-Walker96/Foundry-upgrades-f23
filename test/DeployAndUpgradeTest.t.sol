// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is StdCheats, Test {
    DeployBox public deployBox;
    UpgradeBox public upgradeBox;
    address public OWNER = address(1);

    function setUp() public {
        deployBox = new DeployBox();
        upgradeBox = new UpgradeBox();
    }

    function testBoxWorks() public {
        address proxyAddress = deployBox.deployBox();
        uint256 expectedValue = 1;
        assertEq(expectedValue, BoxV1(proxyAddress).version());
    }

    function testDeploymentIsV1() public {
        address proxyAddress = deployBox.deployBox();
        uint256 expectedValue = 7;
        vm.expectRevert();
        BoxV2(proxyAddress).setValue(expectedValue);
    }

    function testUpgradeWorks() public {
        address proxyAddress = deployBox.deployBox();

        BoxV2 box2 = new BoxV2();

        vm.prank(BoxV1(proxyAddress).owner());
        BoxV1(proxyAddress).transferOwnership(msg.sender);

        address proxy = upgradeBox.upgradeBox(proxyAddress, address(box2));

        uint256 expectedValue = 2;
        assertEq(expectedValue, BoxV2(proxy).version());

        BoxV2(proxy).setValue(expectedValue);
        assertEq(expectedValue, BoxV2(proxy).getValue());
    }
}


// forge test
// [⠢] Compiling...
// No files changed, compilation skipped

// Running 3 tests for test/DeployAndUpgradeTest.t.sol:DeployAndUpgradeTest
// [PASS] testBoxWorks() (gas: 897030)
// [PASS] testDeploymentIsV1() (gas: 897357)
// [PASS] testUpgradeWorks() (gas: 1698539)
// Test result: ok. 3 passed; 0 failed; 0 skipped; finished in 288.16ms

// Ran 1 test suites: 3 tests passed, 0 failed, 0 skipped (3 total tests)

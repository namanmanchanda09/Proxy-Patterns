// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console, Test} from "forge-std/Test.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployAndUpgradeTest is Test {
    ERC1967Proxy public proxy1967;
    BoxV1 public box;
    BoxV2 public box2;
    address proxyAddress;

    function setUp() public {
        box = new BoxV1();
        box2 = new BoxV2();
        proxy1967 = new ERC1967Proxy(address(box), "");
        proxyAddress = address(proxy1967);
    }

    function testIncrement() public {
        BoxV1(proxyAddress).incNumber();
        assertEq(BoxV1(proxyAddress).getNumber(), 1);
    }

    function testUpgrade() public {
        BoxV1(proxyAddress).incNumber();
        assertEq(BoxV1(proxyAddress).getNumber(), 1);

        BoxV1 proxy = BoxV1(proxyAddress);
        proxy.upgradeTo(address(box2));

        assertEq(BoxV2(proxyAddress).getNumber(), 1);
        BoxV2(proxyAddress).incNumber();
        assertEq(BoxV2(proxyAddress).getNumber(), 3);
    }
}



// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV1 is UUPSUpgradeable {
    uint256 internal _number;

    function getNumber() external view returns (uint256) {
        return _number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    function incNumber() external {
        _number++;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}

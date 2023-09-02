// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV2 is UUPSUpgradeable {
    uint256 internal _number;

    function setNumber(uint256 _num) external {
        _number = _num;
    }

    function getNumber() external view returns (uint256) {
        return _number;
    }

    function version() external pure returns (uint256) {
        return 2;
    }

    function incNumber() external {
        _number += 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}

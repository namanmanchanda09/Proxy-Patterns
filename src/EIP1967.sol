// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Proxy.sol";

// EIP1967 Proxy contract
contract ProxyContract is Proxy {

   // _IMPLEMENTATION_SLOT = bytes32(uint256(keccak256(abi.encodePacked("eip1967.proxy.implementation"))) - 1);
  bytes32 private constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

  function setImplementation(address newImpl) public {
    assembly {
      sstore(_IMPLEMENTATION_SLOT, newImpl)
    }
  }

  function _implementation() internal view override returns (address implementationAddress) {
    assembly {
      implementationAddress := sload(_IMPLEMENTATION_SLOT)
    }
  }

  function getFnSignature(uint8 a) public pure returns(bytes memory){
    return abi.encodeWithSignature("add(uint8)", a);
  }

  function getSlotValue(uint256 slotNumber) public view returns(uint256 ret){
    assembly {
      ret := sload(slotNumber)
    }
  }
}

// Implementation 1
contract Addition {
  uint8 public number;

  function add(uint8 a) public { 
    number += a;
  }
}

// Implementation 2 (Upgrade)
contract AdditionPlusSubtraction {
  uint8 public number;

  function add(uint8 a) public {
    number += a;
  }

  function minus(uint8 a) public {
    number -= a;
  }
}
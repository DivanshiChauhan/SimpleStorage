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

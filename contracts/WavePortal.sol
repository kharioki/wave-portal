// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves = 0;

    struct Wave {
        address owner;
        uint256 timestamp;
    }

    mapping(uint256 => Wave) internal waves;

    constructor() {
        console.log("Wassuup!");
    }

    function createWave() public {
        waves[totalWaves] = Wave({
            owner: msg.sender,
            timestamp: block.timestamp
        });
        totalWaves++;
        console.log("%s has waved", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Total waves: %s", totalWaves);
        return totalWaves;
    }

    function getWave(uint256 _index) public view returns (address, uint256) {
        Wave storage wave = waves[_index];
        console.log("Wave %s: %s", wave.owner, wave.timestamp);
        return (wave.owner, wave.timestamp);
    }
}

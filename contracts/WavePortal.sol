// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves = 0;

    /*
     * We will be using this below to help generate a random number
     */
    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address owner;
        string message;
        uint256 timestamp;
    }

    mapping(uint256 => Wave) internal waves;

    constructor() payable {
        console.log("Wassuup!");
        /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function createWave(string memory _message) public {
        waves[totalWaves] = Wave({
            owner: msg.sender,
            message: _message,
            timestamp: block.timestamp
        });
        totalWaves++;
        console.log("%s has waved", msg.sender);

        /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed < 50) {
            console.log("%s has won the prize!", msg.sender);

            uint256 prizeAmount = 0.000001 ether;
            require(
                prizeAmount <= address(this).balance,
                "You don't have enough ether to pay for the prize!"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(
                success,
                "You don't have enough ether to pay for the prize!"
            );
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Total waves: %s", totalWaves);
        return totalWaves;
    }

    function getWave(uint256 _index)
        public
        view
        returns (
            address,
            uint256,
            string memory
        )
    {
        Wave storage wave = waves[_index];
        console.log("Wave %s: %s %s", wave.owner, wave.timestamp, wave.message);
        return (wave.owner, wave.timestamp, wave.message);
    }
}

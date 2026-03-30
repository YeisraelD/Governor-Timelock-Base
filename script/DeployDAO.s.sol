// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/GovernanceToken.sol";
import "../src/TimeLock.sol";
import "../src/GovernorContract.sol";

contract DeployDAO is Script {
    uint256 public constant MIN_DELAY = 3600; // 1 hour - for testing, but in pitch it's 48h
    address[] public proposers;
    address[] public executors;
    
    function run() external {
        uint256 deployerPrivateKey = vm.envOr("PRIVATE_KEY", uint256(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80));
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy Governance Token
        GovernanceToken token = new GovernanceToken(deployer);
        
        // 2. Deploy TimeLock
        // For now, proposers and executors will be updated later
        TimeLock timelock = new TimeLock(MIN_DELAY, new address[](0), new address[](0), deployer);

        // 3. Deploy Governor
        GovernorContract governor = new GovernorContract(token, timelock);

        // 4. Setup Roles
        // Proposer role: Governor
        // Executor role: Anyone (address(0))
        // Admin role: None (renounce)
        bytes32 proposerRole = timelock.PROPOSER_ROLE();
        bytes32 executorRole = timelock.EXECUTOR_ROLE();
        bytes32 adminRole = timelock.DEFAULT_ADMIN_ROLE();

        timelock.grantRole(proposerRole, address(governor));
        timelock.grantRole(executorRole, address(0)); // Anyone can execute passed proposals
        timelock.revokeRole(adminRole, deployer);

        vm.stopBroadcast();
    }
}

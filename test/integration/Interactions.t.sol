// SPDX-License-Identifier: MIT

//uint
//integrations
//forked
//staging <- run tests on a mainnet or testnet

//fuzzing
//stateful fuzz
//stateless fuzz
//formal verification

pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployRaffle} from "script/DeployRaffle.s.sol";
import {Raffle} from "../../src/Raffle.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {CodeConstants} from "script/HelperConfig.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "script/Interactions.s.sol";

contract Interactions is CodeConstants, Test {
    Raffle public raffle;
    HelperConfig public helperConfig;

    uint256 entranceFee;
    uint256 interval;
    address vrfCoordinator;
    bytes32 gasLane;
    uint256 subscriptionId;
    uint32 callbackGasLimit;
    address account;
    address link;

    function setUp() external {
        DeployRaffle deployer = new DeployRaffle();
        (raffle, helperConfig) = deployer.deployContract();
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();
        entranceFee = config.entranceFee;
        interval = config.interval;
        vrfCoordinator = config.vrfCoordinator;
        gasLane = config.gasLane;
        subscriptionId = config.subscriptionId;
        callbackGasLimit = config.callbackGasLimit;
        account = config.account;
        link = config.link;
    }

    function testCreateSubscriptionCreatesSubscription() public {
        CreateSubscription createSubscription = new CreateSubscription();
        (subscriptionId, vrfCoordinator) = createSubscription
            .createSubscription(vrfCoordinator, account);

        assert(subscriptionId != 0);
    }
}

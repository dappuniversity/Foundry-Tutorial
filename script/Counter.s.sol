// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.13;

// import "forge-std/Script.sol";
// import { Counter } from "src/Counter.sol";

// contract CounterScript is Script {
//     function setUp() public {}

//     // run is the entry point
//     function run() public {
//         // startBroadcast and stopBraodcast will let us execute transactions anything between them
//         vm.startBroadcast();
//         // here we just need to deploy a new contract
//         new Counter(0);
//         vm.stopBroadcast();
//     }
// }
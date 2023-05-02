// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.13;

// import "forge-std/Test.sol";
// import "../src/Counter.sol";
// import "openzeppelin-contracts/interfaces/IERC20.sol";


// contract CounterTest is Test {
//     IERC20 public USDC;
//     Counter public counter;


//     // This is an optional function that runs before each tests
//     function setUp() public {
//         counter = new Counter(0);
//         USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
//     }

//     // functions that are prefixed with test are run as a test case
//     function testIncrement() public {
//         counter.increment();
//         assertEq(counter.number(), 1);
//     }
//     // This is a Fuzz test
//     function testSetNumber(uint256 x) public {
//         counter.setNumber(x);
//         assertEq(counter.number(), x);
//     }

//     // function testForkingAndSendingUSDC() public{
//     //     vm.prank(0x1B7BAa734C00298b9429b518D621753Bb0f6efF2);
//     //     USDC.transfer(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 10000);
//     //     emit log_uint(USDC.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266));
//     //     assertEq(USDC.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266), 10000);
//     // }

//     function testIncrementWithOtherAccount() public{
//         // Here we use the cheatcode expectRevert to let it know that we expect a revert in the next call with the message
//         vm.expectRevert(bytes("Ownable: caller is not the owner"));
//         // We change the transaction sender address to a zero address
//         vm.prank(address(0));
//         counter.increment();
//     }

//     function testIncrementWithLogging() public{
//         counter.increment();
//         emit log_uint(counter.number());
//         assertEq(counter.number(), 1);
//     }
// }

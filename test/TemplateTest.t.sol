// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { console } from "forge-std/console.sol";
import "src/Template.sol";
import "src/Number.sol";
import "openzeppelin-contracts/interfaces/IERC20.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

contract TemplateTest is Test {
     Template templateContract;
     Number numberContract;
     IERC20 public USDC;

    function setUp() public {
        numberContract = new Number();
        templateContract = new Template(address(numberContract));
        targetContract(address(templateContract));
        USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    }

    function testOptimized() public {
        console.log("Working in test");
        emit log_named_uint("Gas usage of optimized function: ", templateContract.optimized());
    }

    function testNotOptimized() public {
        emit log_named_uint("Gas usage of unoptimized function: ", templateContract.notOptimized());
    }
    
    function testSetNumberAndSetEth() public payable {
        address alice = 0x5653Bd451Bd6B0838982c9A07d41885aff8Fb174;
        vm.deal(alice, 1 ether);
        vm.prank(alice);
        templateContract.setNumberAndSendEth{value: 1 ether}(15);
        assertEq(numberContract.number(), 15);
        assertEq(address(numberContract).balance, 1 ether);
    }

     function testIncrementWithOtherAccount() public{
        // Here we use the cheatcode expectRevert to let it know that we expect a revert in the next call with the message
        vm.expectRevert("Ownable: caller is not the owner");
        // We change the transaction sender address to a zero address for the consecutive transactions
        vm.startPrank(address(0));
        numberContract.increment();
        // We stop the active prank, resetting msg.sender
        vm.stopPrank();
    }

    function testCallFunction() public {
        vm.deal(address(this), 300);
        templateContract.callFunction{value: 200}("Marko");
        assertEq(numberContract.name(), "Marko");
        assertEq(address(numberContract).balance, 200);
    }

    function testForkingAndSendingUSDC() public{
        vm.prank(0x6F4565c9D673DBDD379ABa0b13f8088d1AF3Bb0C);
        USDC.transfer(0x14dC79964da2C08b23698B3D3cc7Ca32193d9955, 10000);
        emit log_uint(USDC.balanceOf(0x14dC79964da2C08b23698B3D3cc7Ca32193d9955));
        assertEq(USDC.balanceOf(0x14dC79964da2C08b23698B3D3cc7Ca32193d9955), 10000);
    }

    function testIsAlwaysZeroFuzz(uint256 randomData) public {
        templateContract.isAlwaysZero(randomData);
        assert(templateContract.shouldAlwaysBeZero() == 0);
    }

     function invariant_testAlwaysReturnsZero() public {
        assert(templateContract.shouldAlwaysBeZero() == 0);
    }
}
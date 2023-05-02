// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Number.sol";
// The Test contract in Test.sol provides all the essential functionality you need to get started writing tests.
import "forge-std/Test.sol";

contract NumberTest is Test {

    Number numberContract;

    function setUp() public {
        numberContract = new Number();
    }

    function testInitialNumber() public {
        uint256 expected = 10;
        uint256 actual = numberContract.number();
        assertEq(actual, expected, "Initial number should be 10");
    }

    function testSetNumber() public {
        vm.deal(address(this), 1 ether);
        uint256 expected = 20;
        numberContract.setNumber{value: 1 ether}(expected);
        uint256 actual = numberContract.number();
        assertEq(actual, expected, "Number should be set to 20");
    }

    function testIncrement() public {
        assertEq(numberContract.owner(),address(this));
        uint256 expected = 11;
        numberContract.increment();
        uint256 actual = numberContract.number();
        assertEq(actual, expected, "Number should be incremented by 1");
    }
}

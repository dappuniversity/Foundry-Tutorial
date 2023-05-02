// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "openzeppelin-contracts/access/Ownable.sol";

contract Number is Ownable{
    
    uint256 public number = 10;
    string public name;

    function setNumber(uint256 newNumber) external payable {
        require(msg.value == 1 ether, "Not enough ether");
        number = newNumber;
    }

    function increment() public onlyOwner{
        number++;
    }

    function returnNumber10(string memory _name) external payable returns(uint) {
        name = _name;
        return 10;
    }
}
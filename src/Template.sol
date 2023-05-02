// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import { console } from "forge-std/console.sol";

interface INumber {
    function setNumber(uint256) external payable ;
}

contract Template {

    uint public c = 1;
    bytes public bytesOutput;
    INumber numberContract;

    uint256 public shouldAlwaysBeZero = 0;
    uint256 private hiddenValue = 0;

    constructor(address _numberAddress) {
        numberContract = INumber(_numberAddress);
    }

    function notOptimized() external returns(uint gasUsed) {        
        uint startGas = gasleft();
        c++;
        gasUsed = startGas - gasleft();
        console.log("Working in contract");
    }

    function optimized() external returns(uint gasUsed) {        
        uint startGas = gasleft();
        ++c;
        gasUsed = startGas - gasleft();
    }    

    function setNumberAndSendEth(uint256 _number) public payable {
        numberContract.setNumber{value: msg.value}(_number);
    }

    function callFunction(
        string memory _name
    ) external payable returns(string memory, string memory) {

        (bool success, bytes memory dataReturned) = address(numberContract).call{value: 200, gas: 100000}
        (
            abi.encodeWithSignature("returnNumber10(string)", _name)
        );
        require(success, "the call failed miserably");
        bytesOutput = dataReturned;

        return ("Hello", _name);
    }

    function isAlwaysZero(uint256 data) public {
        // if (data == 2) {
        //     shouldAlwaysBeZero = 1;
        // }
        
        // if (hiddenValue == 7) {
        //     shouldAlwaysBeZero = 1;
        // }
        hiddenValue = data;
    }

}



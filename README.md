# Foundry Tutorial

## Installation on Mac
```
curl -L https://foundry.paradigm.xyz | bash
```
then run 
```
foundryup
```
- Now you have access to `forge --help` `cast` and `anvil`
 
## Building and testing with Foundry

### 1. Initializing a new project
```
forge init folderName
```

it will create some files and folders.
The lib directory contains forge-std, a collection of helpful contracts for use with forge and foundry.
the src folder contains the contracts
test folder will be the place where we write all our tests
and scripts folder for writing deploy scripts 

### 2. Compilation - Basic commands

Compile all contracts:
```
forge build
```

Install dependencies
```
forge install OpenZeppelin/openzeppelin-contracts
```

To run all tests type:
```
forge test
```
Run specific test file:
```
forge test -vv --match-path test/Template.t.sol
```
Run specific test:
```
forge test -m testSetNumber
```
Skip specific test:
```
forge test -vv --match-path test/TemplateTest.t.sol --no-match-test testForkingAndSendingUSDC
```

Please note - You will get one test failure. Please ignore. We will be looking into it after some time

Some assertion statement that can be used in the tests are
- assertEq
- assertTrue
- assertEqDecimal
- assertGt, assertGe, assertLt, assertLe - greater than, greater than equal to, less than, less than equal to
and many more. Others can be found [here](https://book.getfoundry.sh/reference/ds-test.html#asserting)

### 3. Fuzzing and Logging

Foundry also support fuzzing. the testSetNumber() function is an example of this.

We can also log using foundry. We may use the following log, log_uint, log_address, log_string, or log_named_string. You may find a lot more [here](https://github.com/foundry-rs/foundry/blob/master/testdata/logs/DebugLogs.t.sol)

The default behavior for forge test is to only display a summary of passing and failing tests. You can control this behavior by increasing the verbosity (using the -v flag). Each level of verbosity adds more information: 

- Level 2 (-vv): Logs emitted during tests are also displayed. That includes assertion errors from tests, showing information such as expected vs actual. 
- Level 3 (-vvv): Stack traces for failing tests are also displayed. 
- Level 4 (-vvvv): Stack traces for all tests are displayed, and setup traces for failing tests are displayed. 
- Level 5 (-vvvvv): Stack traces and setup traces are always displayed. 

```
forge test -vv
```

### 4. Anvil and Deployment

Start the native Foundry local development blockchain
```
anvil
```

See all available flags to pass in
```
anvil -help
```

Deploy using --broadcast and simulate deployment without using --broadcast
Use http://localhost:8545 to deploy locally or https://eth-goerli.g.alchemy.com/v2/yourAlchemyKey to deploy on goerli

```
forge script script/Counter.s.sol:CounterScript --fork-url http://localhost:8545 --private-key INPUT_PRIVATE_KEY_HERE --broadcast
```
--broadcast will show the transaction logs on the terminal

Alternatively, You can also deploy a contract without any scripts by using ```forge create```
```
forge create --rpc-url http://localhost:8545 --private-key INPUT_PRIVATE_KEY_HERE src/Counter.sol:Counter --constructor-args 1
```

### 5. Cast - Interacting with the contract on local development blockchain

- First fork mainnet if you want to make calls there or Goerli like this

```
cast call --rpc-url=ActualGoerliURL contractAddress "decimals()(uint256)" --private-key=actualValue
```

Perform Ethereum RPC calls from the comfort of your command line.
```
cast call contractAddress "number()(uint256)"
```
This command fetches the value of number.

The following command sets a new number for the variable number
```
cast send contractAddress "setNumber(uint256)" "28" --private-key INPUT_PRIVATE_KEY_HERE
```

To send ether along with the transaction, you can use the --value .For example:-
```
cast send <ContractAddress> "donate()" --value 1ether --private-key <Prvt-key>
```
you can also include values like ```10gwei```, ```0.01ether``` etc...

### 6. A Cheatcode usecase 

There are a lot of cheatcodes that we can use and all of them can be found [here](https://book.getfoundry.sh/cheatcodes/)

In this tutorial we are using specifically 2 cheatcodes in the test file, namely expectRevert and prank
- expectRevert: This will expect a revert to happen
- prank: this command will let us change the address of the person sending the transaction

Please refer the function testIncrementWithOtherAccount() in Counter.t.sol file to find the implementation.

### 7. Forking the mainnet

To fork the mainnet, you may use the command
```
anvil --fork-url [ALCHEMY_OR_INFURA_KEY]
```

### 8. Impersonating Account

You may use the vm.prank to impersonate the account in your test.

Kindly check the testForkingAndSendingUSDC() example in the test file to see an implementation. Here we are simply sending some USDC from a whale account to an address.

Now simply running the ```forge test``` will give you an error since there is no USDC contract in our local blockchain.
So we need to fork the mainnet while running the test, to do that, just use the below command:
```
forge test --rpc-url https://eth-mainnet.g.alchemy.com/v2/<ETH_ALCHEMY> -vv
```
-vv was added just to output the logs

### 9. Using the Debugger

To run the debugger on specific functions in the test file: just run
```
forge script ./test/Counter.t.sol:CounterTest --sig "testIncrement()" --debug
```

When the debugger is run, you are presented with a terminal divided into four quadrants:

- Quadrant 1: The opcodes in the debugging session, with the current opcode highlighted. Additionally, the address of the current account, the program counter and the accumulated gas usage is also displayed
- Quadrant 2: The current stack, as well as the size of the stack
- Quadrant 3: The source program view
- Quadrant 4: The current memory of the EVM

### 10. Changing networks

To change the netoworks, simply add the --rpc-url as [ALCHEMY OR INFURA URL] of your required network when executing commands like ```forge test```, ```forge create```

## Resources

- [Foundry Docs](https://book.getfoundry.sh/)
- [Foundry Tutorial by James Bachini](https://jamesbachini.com/foundry-tutorial/)
- [Smart Contract Development with Foundry by Nader Dabit](https://www.youtube.com/watch?v%3DuelA2U9TbgM)

### 11. Verify smart contract

Add --verify upon deployment 

```
forge create --rpc-url http://localhost:8545 --private-key INPUT_PRIVATE_KEY_HERE src/Counter.sol:Counter --constructor-args 1 --verify
```
or verify already preexisting contract:
```
forge verify-contract <ADDRESS> <CONTRACT> <ETHERSCAN_KEY>
```
example:
```
forge verify-contract 0x9fd7A2eB88cd2981f252114a870BB38805b9806c src/SmartWalletFactoryV2.sol:SmartWalletFactoryV2 FQFVHWRK2PFGHCR296BENZQYW88N39REHE
```




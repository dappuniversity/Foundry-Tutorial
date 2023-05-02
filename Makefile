# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# Install the Modules
install :; 
	forge install dapphub/ds-test 
	forge install OpenZeppelin/openzeppelin-contracts
	forge install transmissions11/solmate
	forge install foundry-rs/forge-std

deploy:
	forge create StakeContract --private-key ${PRIVATE_KEY} # --rpc-url 

# Update Dependencies
update:; forge update

# Install proper solc version.
solc:; nix-env -f https://github.com/dapphub/dapptools/archive/master.tar.gz -iA solc-static-versions.solc_0_8_10

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

# Builds
build  :; forge clean && forge build --optimize --optimize-runs 1000000

setup-yarn:
	yarn 

local-node: setup-yarn 
	yarn hardhat node 

all: clean remove install update solc build 
	
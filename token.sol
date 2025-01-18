// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

// smart contract for creation of a sub coin
contract Coin {
    
    // create variables
    address public minter;
    mapping(address minter =>uint) public balances;

   // rremember to add emit at the end 
    event Sent(address from, address to, uint amount);

    // a constructor that only runs when the contract is deployed
    constructor() {
        minter = msg.sender;
    }

    // mint new coins and send to an address(only owner can)
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;

    }

    error insufficientFund(uint requested, uint available);

    // create a send function to be able to send any amount to any wallet
    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender])
        revert insufficientFund({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
    
}

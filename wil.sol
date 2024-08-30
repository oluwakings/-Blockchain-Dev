// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract will {
    address owner;
    uint fortune;
    bool deceased;
    string name;
    
    constructor() payable {
        owner = msg.sender; //messenger sender shows the account sending the message or the ether
        fortune = msg.value; // messenge value is the amount or quantity of item being sent
        deceased = false;   
    }

    // create modifffier so the only person that can call the contract is the owner
       modifier onlyOwner {
        require(msg.sender == owner );
        _;
    }
    // modiffier so funds are allocated only when friends dad is deceased
       modifier mustBeDeceased {
        require(deceased == true);
        _;
    }

    // create an array for address of the family members
    address payable[] familyWallets;

    // to make us know the allocation that was sent into all this wallets, we use  mapping
       mapping(address owner => uint fortune ) inheritance;


    // we add a string to show name along with the address recieving inheritance and create array
       string [] nameOfMembers;
       mapping(string _name => uint fortune) private theNames; 
       

    //to set inheritance for each address
    function setInheritance(address payable wallet, uint amount, string memory _name) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
        theNames[_name] = amount;

    }

    // pay family members based on wallet
    function payout() private mustBeDeceased {
        for(uint i=0; i<familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);

        }
    }

    // imagine the man is dead(sadly), we create a function for to make the pay
    function HasDeceased () public onlyOwner {
        deceased = true;
        payout();
    }



}

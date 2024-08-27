// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19; // this is the solididty version

contract VotingApp {
    struct Voter{
        uint weight; // weight is accumulated by delegation 
        bool voted; // if true, that person already voted 
        address delegate; // person delegated to
        uint vote; // index of the voted proposal

    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }
    address public chairPerson;

    mapping(address => Voter) public voters;

    Proposal [] public proposals;
    // create new ballot to choose one of proposalNames.

    constructor(bytes32 [] memory proposalNames) {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 1;

        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // next is to give a voter right to vote on this ballot
    function giveRightToVote(address voter) external {
        require( msg.sender == chairPerson, "only chairperson can give right to vote.");
        require(!voters[voter].voted, "The voter already voted");
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;

    }
    // to delegate your vote to the voter 
    function delegate(address to) external {
        // to assign reference

        Voter storage sender = voters[msg.sender];
        require(sender.weight !=0, "you have no right to vote");
        require(!sender.voted, "you already voted");

        require(to != msg.sender, "self-delegation is disallowed");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;
            require(to != msg.sender, "Found loop in delegation.");
        }

        Voter storage delegate_ = voters[to];

        require(delegate_.weight >= 1);

        sender.voted = true;
        sender.delegate = to;

        if (delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;

        }
        else {
            delegate_.weight += sender.weight;
        }
    }

    // to cast votes including delegated votes
    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight !=0, "Has no right to vote");
        require(!sender.voted, "Already voted");
        sender.voted = true;
        sender.vote = proposal; 
        proposals[proposal].voteCount += sender.weight;

    }  

    // compute winnig proposal
    function winningProposal() public view returns (uint winningProposal_) {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    // to call the winner
    function winnerName () external view returns (bytes32 winnerName_) {
        winnerName_ = proposals[winningProposal()].name;

    }

}

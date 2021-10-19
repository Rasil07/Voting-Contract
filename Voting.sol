// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

contract Voting{
    
  event ProposalCreated(address indexed proposedBy);
  event Voted(address indexed voter);
  
  //TODOS
  // 1. Write a fuction that shows total number of voters for a given Proposal.
  // 2. Write a fuction that shows total number of Proposals.
  //3. Implement Modifiers in voteProposal function.
    
    
    struct Voter {
        bool agreed;
        bool voted;
    }
    
    struct Proposal {
        string title;
        address proposedBy;
        uint256 voteCountPos;
        uint256 voteCountNeg;
        mapping(address=>Voter) voters;
        address[] voterAddress;
    }
    
    Proposal[] proposals;
    
    
    //Change this to modifier
    function hasVoted(uint256 proposalId, address votersAddress)
        public
        view
        returns (bool)
    {
        Proposal storage p = proposals[proposalId];
        return p.voters[votersAddress].voted;
    }
    
    
    function createProposal(string memory title) public{
        uint256 proposalIndex = proposals.length;
        proposals.push();
        Proposal storage newProposal= proposals[proposalIndex];
        newProposal.title = title;
        newProposal.proposedBy = msg.sender;
        emit ProposalCreated(msg.sender);
    }
    
    
    function getProposalByIndex(uint256 proposalIndex) public view
        returns (
            uint256 Index,
            string memory ProposalTitle,
            address Proposer,
            uint256 Upvotes,
            uint256 Downvotes
        ){
            if(proposals.length>0){
                Proposal storage proposal = proposals[proposalIndex];
                
                return(
                    proposalIndex,
                    proposal.title,
                    proposal.proposedBy,
                      proposal.voteCountPos,
                proposal.voteCountNeg
                    );
            }
        }
        
        
        
    function voteProposal(uint256 proposalIndex, bool agreed) public{
        Proposal storage proposal = proposals[proposalIndex];
        //Implement modifier instead
        require(
            !hasVoted(proposalIndex, msg.sender),
            "You have already voted for this proposal"
        );
        if (agreed) {
            proposal.voteCountPos += 1;
        } else {
            proposal.voteCountNeg += 1;
        }
        proposal.voters[msg.sender].agreed = agreed;
        proposal.voters[msg.sender].voted = true;
        proposal.voterAddress.push(msg.sender);

        emit Voted(msg.sender);
        }
    
    
    
}


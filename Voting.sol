// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

contract Voting{
    
    
    //emits here;
    event ProposalCreated(address indexed propoesedBy);
    event Voted(address indexed voter); 
    
    
    //Todos
    //1. Write a function to show total numbers of Proposals in the contract
    //2. Write a function to show total number of voters fot the given proposal
    //3. Implement function Modifier in voteProposal Function instead of hasVoted function;
    
    
    struct Voter{
        bool agreed;
        bool voted;
    }
    
    struct Proposal{
        string title;
        address proposedBy;
        uint256 voteCountPos;
        uint256 voteCountNeg;
        mapping(address=>Voter) voters;
        address[] voterAddress;
    }
    
    uint256 counter;
    mapping(uint256=>Proposal) proposals;
    
  
    
    
    function hasVoted(uint256 proposalIndex, address votersAddress)  public view  returns (bool){
            Proposal storage p = proposals[proposalIndex];
            return p.voters[votersAddress].voted;
    }
    
    function createProposal(string memory title) public{
        Proposal storage newProposal = proposals[counter];
        newProposal.title = title;
        newProposal.proposedBy = msg.sender;
        counter++;
        emit ProposalCreated(msg.sender);
    }
    
    function getProposalByIndex(uint256 proposalIndex) public view returns(
        uint256 Index,
        string memory ProposalTitle,
        address Proposer,
        uint256 Upvotes,
        uint256 Downvotes
        ){
            
            if(counter>0){
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
    
    function voteProposal(uint256 proposalIndex, bool agreed) public {
        Proposal storage proposal = proposals[proposalIndex];
        
        require(!hasVoted(proposalIndex,msg.sender),"Already voted!!!");
        
        if(agreed){
            proposal.voteCountPos += 1;
            
        }else{
            proposal.voteCountNeg += 1;
        }
        
        proposal.voters[msg.sender].agreed = agreed;
        proposal.voters[msg.sender].voted = true;
        proposal.voterAddress.push(msg.sender);
        
        emit Voted(msg.sender);
        
        
    }
    
    
    
    
    
}
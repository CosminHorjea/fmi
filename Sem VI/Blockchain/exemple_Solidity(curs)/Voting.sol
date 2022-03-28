// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Voting{
    
    modifier onlyChairperson() {
        require(msg.sender == chairperson, 'You must be the chairperson');
        _;
    }

    modifier voteOnce() {
        require(voted[msg.sender] == false, 'You must vote only once!');
        _;
    }


    struct Proposal {
        string name;     // short name (up to 32 bytes)
        uint8 voteCount; // number of accumulated votes
    }
    
    mapping(address => bool) public voted;
    
    Proposal[] public proposals;
    
    address public chairperson;
    
    event LogVote(address indexed voterAddress, string name, uint8 votes);
    
    
    constructor()  {
        chairperson = msg.sender;
    }
    
      
    function addProposal (string memory proposalName) public onlyChairperson{
       
        proposals.push(Proposal({
                name: proposalName,
                voteCount: 0
            })
            );
    }
    
    function vote(uint proposal) public voteOnce{
        address voter = msg.sender;
        voted[voter] = true;
        proposals[proposal].voteCount++;
        
        emit LogVote(voter, proposals[proposal].name, proposals[proposal].voteCount);
    }

}





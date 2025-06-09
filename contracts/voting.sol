// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting_Admin {
    struct Candidate {
        address candidateAddress;
        uint voteCount;
    }

    mapping(address => bool) private candidateExists;
    Candidate[] public candidates;
    
    mapping(address => bool) public registeredVoters;  // Admin-controlled voter registration
    mapping(address => bool) public hasVoted;  // Track who has voted
    address[] public voterList;
    
    address public admin;  // Admin address

    constructor() {
        admin = msg.sender;  // Set deployer as the admin
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function addCandidate(address _candidate) public onlyAdmin {
        require(!candidateExists[_candidate], "Candidate already exists.");
        candidates.push(Candidate(_candidate, 0));
        candidateExists[_candidate] = true;
    }

    function registerVoter(address _voter) public onlyAdmin {
        require(!registeredVoters[_voter], "Voter already registered.");
        registeredVoters[_voter] = true;
        voterList.push(_voter);
    }

    function vote(address _candidate) public {
        require(registeredVoters[msg.sender], "You are not a registered voter.");
        require(!hasVoted[msg.sender], "You have already voted.");
        require(candidateExists[_candidate], "Candidate does not exist.");

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].candidateAddress == _candidate) {
                candidates[i].voteCount++;
                hasVoted[msg.sender] = true;
                break;
            }
        }
    }

    function getVoter(uint index) public view returns (address) {
        require(index < voterList.length, "Index out of bounds.");
        return voterList[index];
    }

    function getTotalVoters() public view returns (uint) {
        return voterList.length;
    }

    function getCandidate(uint index) public view returns (address, uint) {
        require(index < candidates.length, "Candidate index out of bounds.");
        return (candidates[index].candidateAddress, candidates[index].voteCount);
    }
}

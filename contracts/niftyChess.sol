// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.3;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.0.0/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.0.0/contracts/utils/Counters.sol";

contract niftyChess is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address owner;
    address minter;
    uint256 price;
    

    constructor() public ERC721("gameBoard", "CHESS") {
        owner = msg.sender;
        minter = owner;
        price = 0;
    }
    
    function updateMinter(address newMinter) public {
        require(msg.sender == owner, "Only the owner can do that.");
        minter = newMinter;
    }
    
    function updateOwner(address newOwner) public {
        require(msg.sender == owner, "Only the owner can do that.");
        owner = newOwner;
    }
    
    function updatePrice(uint256 newPrice) public{
        require(msg.sender == owner, "Only the owner can do that.");
        price = newPrice;
    }
    

    function awardBoard(address player, string memory tokenURI)
        public payable
        returns (uint256)
    {
        require(msg.value >= price);
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}

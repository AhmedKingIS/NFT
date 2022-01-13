// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ScarletKnights is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    
    address private creator;
    uint256 private requiredFee;

    constructor() ERC721("ScarletKnights", "SK") {
        creator = msg.sender;
        requiredFee = .1 ether;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://raw.githubusercontent.com/AhmedKingIS/NFT/main/metadata/";
    }

    function mint(address to)
        public returns (uint256)
    {
        require(_tokenIdCounter.current() < 4); 
        require(balanceOf(to) == 0);
        
        _tokenIdCounter.increment();
        _safeMint(to, _tokenIdCounter.current());

        return _tokenIdCounter.current();
    }

    function getBalance() public view returns (uint256){
        return address(this).balance;
    }


    function royaltyTransfer(address from, address to, uint256 tokenId)
        payable public 
    {
        require(msg.value == requiredFee);
        transferFrom(from, to, tokenId);
    }

}
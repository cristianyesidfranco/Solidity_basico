// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Educateth is ERC721, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("Educateth", "EDH")
        Ownable(initialOwner)
    {}
    function _baseURI() internal pure override returns (string memory) 
    {        
        return "https://gateway.lighthouse.storage/ipfs/bafkreid3hikkqyldlalnugugh7svolal3br2e6z2lnndromx62rrfclvkm";   
    } 
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }
}

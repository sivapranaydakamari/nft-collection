// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NftCollection is ERC721URIStorage, Ownable, Pausable {
    using Counters for Counters.Counter;

    uint256 public immutable maxSupply;
    Counters.Counter private _mintedCounter; // counts total minted tokens
    uint256 private _totalSupply;

    mapping(uint256 => bool) private _existsMap;

    event Minted(address indexed to, uint256 indexed tokenId, string uri);
    event Burned(address indexed owner, uint256 indexed tokenId);

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 maxSupply_
    ) ERC721(name_, symbol_) {
        require(maxSupply_ > 0, "maxSupply must be > 0");
        maxSupply = maxSupply_;
        _totalSupply = 0;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function mintedCount() external view returns (uint256) {
        return _mintedCounter.current();
    }

    function safeMint(address to, uint256 tokenId, string memory uri) external onlyOwner whenNotPaused {
        require(to != address(0), "mint to zero address");
        require(!_existsMap[tokenId], "tokenId already minted");
        require(_mintedCounter.current() < maxSupply, "max supply reached");

        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        _existsMap[tokenId] = true;
        _mintedCounter.increment();
        _totalSupply += 1;

        emit Minted(to, tokenId, uri);
    }

    function burn(uint256 tokenId) external {
        address owner = ownerOf(tokenId);
        require(_isApprovedOrOwner(_msgSender(), tokenId), "caller not owner nor approved");
        _burn(tokenId);
        _existsMap[tokenId] = false;
        _totalSupply -= 1;

        emit Burned(owner, tokenId);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
        require(!paused(), "token transfer while paused");
    }


    function _burn(uint256 tokenId) internal override(ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

}

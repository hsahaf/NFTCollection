// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract basicNFT is ERC721Enumerable, Ownable {
    using Strings for uint256;

    string _baseTokenURI;

    // _paused is used to pause the contract in case of an emergency
    bool public _paused;

    // max number of NFT's
    uint256 public maxTokenIds = 5;

    // total number of tokenIds minted
    uint256 public tokenIds;

    modifier onlyWhenNotPaused {
        require(!_paused, "Contract currently paused");
        _;
    }

    constructor (string memory baseURI) ERC721("Artifactum", "AFM") Ownable(msg.sender) {
        _baseTokenURI = baseURI;
    }

    // mint allows an user to mint 1 NFT per transaction. No cost involved.
    function mint() public onlyWhenNotPaused {
        require(tokenIds < maxTokenIds, "Exceed maximum token supply");
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    //baseURI overrides the ERC721 default implementation because there is now metadata to point to.
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    // tokenURI overrides the ERC721 implementation for tokenURI function which returned
    // the URI from where we can extract the metadata for a given tokenId
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(ownerOf(tokenId) != address(0), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        // Here it checks if the length of the baseURI is greater than 0, if it is return the baseURI and attach
        // the tokenId and `.json` to it so that it knows the location of the metadata json file for a given
        // tokenId stored on IPFS
        // If baseURI is empty return an empty string
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    // withdraw sends all the ether in the contract to the owner of the contract
    function withdraw() public onlyOwner  {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) =  _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}

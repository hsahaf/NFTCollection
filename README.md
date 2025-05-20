

# Artifactum - Free NFT Minting Contract
Artifactum is a smart contract for minting free ERC-721 Non-Fungible Tokens (NFTs) on the Ethereum blockchain. The contract allows users to mint a limited number of unique tokens (max 5) without any associated cost (free minting). Each token is linked to metadata stored on IPFS, and users can retrieve token details using the tokenURI function.

## Features:
Free Minting: No Ether required to mint tokens.

Max Token Supply: A total of 5 NFTs can be minted, with a check to prevent exceeding this limit.

Metadata on IPFS: Each NFT is linked to a metadata file on IPFS, containing attributes like image, description, and more.

Pause Mechanism: The contract can be paused by the owner to prevent minting in case of emergencies or updates.

Owner Withdraw: The contract owner can withdraw any Ether (if applicable) in the contract.

## Contract Functions:
mint(): Allows users to mint 1 NFT per transaction. (Free, no cost involved)

tokenURI(uint256 tokenId): Returns the URI for the token metadata, pointing to the IPFS location.

setPaused(bool val): Allows the owner to pause or unpause the contract.

withdraw(): Allows the owner to withdraw any Ether from the contract.

### Notes:
ERC-721: Standard for creating NFTs on the Ethereum blockchain.

IPFS Integration: Metadata and media files (e.g., images) are stored and referenced using IPFS for decentralized storage.

Verification Link: https://sepolia.etherscan.io/address/0xa6D0BDF1A827515DdA8F5D221dBE9e9A0dADD006#code


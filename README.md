# NFT Collection Smart Contract

## Overview

This project implements an **ERC-721–compatible NFT smart contract** with features like:

- Minting unique tokens (`safeMint`)
- Ownership tracking (`ownerOf`, `balanceOf`)
- Transfers (including safe transfers)
- Approvals and operator mechanics
- Token metadata support (`tokenURI`)
- Max supply limit enforcement
- Pausing/unpausing minting
- Optional token burn functionality
- Fully tested and Dockerized for reproducible testing

The project uses **Solidity 0.8.19**, **Hardhat**, and **OpenZeppelin contracts**.

---

## Project Structure

project-root/
├─ contracts/
│ └─ NftCollection.sol # Main ERC-721 NFT smart contract
├─ test/
│ └─ NftCollection.test.js # Automated test suite for the NFT contract
├─ package.json # Node.js dependencies and scripts
├─ hardhat.config.js # Hardhat configuration
├─ Dockerfile # Dockerfile for containerized build & testing
└─ .dockerignore # Optional Docker ignore file

---

## Requirements

- Node.js v18+ (Docker uses Node 18-alpine)
- npm
- Docker (for containerized testing)

---

## Setup Instructions (Local)

1. Clone the repository:

```bash
git clone <repository-url>
cd nft-collection
```

2. Install Dependencies:

```bash
npm install
```

3. Compile contracts:

```bash
npx hardhat compile
```

4. Run tests locally:
```bash
npx hardhat test
```
---

## Docker Setup
The project is fully Dockerized for reproducible builds and testing.

### Build Docker Image
From the project root:
```bash
docker build -t nft-collection .
```

### docker build -t nft-collection .
Run Tests in Docker
```bash
docker run --rm nft-collection
```

---
## Features
- Admin-only minting: Only the contract owner can mint new tokens.
- Max supply enforcement: Cannot mint beyond the configured maximum supply.
- ERC-721 standards: Supports ownership, transfers, approvals, and operator mechanics.
- Token metadata: tokenURI provides a per-token metadata URL.
- Pause/unpause minting: Admin can pause minting if needed.
- Burn support: Optional token burn updates balances and total supply consistently.
- Comprehensive tests: Include happy paths and edge cases for minting, transfers, approvals, and max supply enforcement.
- Gas awareness: Normal mint + transfer flow is reasonably optimized for gas usage.

---

## Testing
The test suite covers:
- Initial configuration (name, symbol, maxSupply, totalSupply)
- Owner-only minting
- Unauthorized minting rejection
- Max supply enforcement
- ERC-721 functionality (transfers, approvals, operators)

---

## Conclusion

This project delivers a fully functional ERC-721 NFT smart contract with minting, transfers, approvals, and metadata support.  

All features are thoroughly tested locally and via Docker, ensuring reliability and reproducibility. The contract is ready for evaluation or deployment.

---

const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NftCollection", function () {
    let NftCollection, nft, owner, addr1, addr2;
    const NAME = "MyTestNFT";
    const SYMBOL = "MTN";
    const MAX_SUPPLY = 5;

    beforeEach(async function () {
        [owner, addr1, addr2] = await ethers.getSigners();
        const NftCollectionFactory = await ethers.getContractFactory("NftCollection");
        nft = await NftCollectionFactory.deploy(NAME, SYMBOL, MAX_SUPPLY);
    });

    it("initial config is set", async function () {
        expect(await nft.name()).to.equal(NAME);
        expect(await nft.symbol()).to.equal(SYMBOL);
        expect(await nft.maxSupply()).to.equal(MAX_SUPPLY);
        expect(await nft.totalSupply()).to.equal(0);
    });

    it("owner can mint", async function () {
        await nft.safeMint(addr1.address, 1, "ipfs://token1");
        expect(await nft.totalSupply()).to.equal(1);
        expect(await nft.ownerOf(1)).to.equal(addr1.address);
    });

    it("non-owner cannot mint", async function () {
        await expect(nft.connect(addr1).safeMint(addr1.address, 2, "ipfs://t2"))
            .to.be.revertedWith("Ownable: caller is not the owner");
    });

    it("cannot mint beyond max supply", async function () {
        for (let i = 1; i <= MAX_SUPPLY; i++) {
            await nft.safeMint(addr1.address, i, `ipfs://t${i}`);
        }
        await expect(nft.safeMint(addr1.address, MAX_SUPPLY + 1, "ipfs://overflow"))
            .to.be.revertedWith("max supply reached");
    });
});

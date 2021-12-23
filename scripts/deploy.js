  const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('EpicTrioNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    // Call the function.
    let txn = await nftContract.BuildAnEpicTrio()
    // Wait for it to be mined.
    await txn.wait()
    console.log("Minted Trio-NFT #1")

    txn = await nftContract.BuildAnEpicTrio()
    // Only minting
    await txn.wait()
    console.log("Minted NFT #2")

    txn = await nftContract.BuildAnEpicTrio()
    // Only minting once.
    await txn.wait()
    console.log("Minted NFT #3")

    txn = await nftContract.BuildAnEpicTrio()
    // Only minting once.
    await txn.wait()
    console.log("Minted NFT #4")

    txn = await nftContract.BuildAnEpicTrio()
    // Only minting once.
    await txn.wait()
    console.log("Minted NFT #5")
  };

  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };

    runMain();

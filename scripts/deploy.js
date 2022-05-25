const main = async () => {
  try {
    const NftContractFactory = await hre.ethers.getContractFactory("NftBattles");
    const nftContract = await NftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

main();

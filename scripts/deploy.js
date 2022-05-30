const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log(`Deployer: ${deployer.address}`);
  console.log(`Deployer balance: ${accountBalance.toString()}`);

  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();

  console.log(`Deployed WavePortal at ${waveContract.address}`);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0); // exit node without error
  } catch (error) {
    console.error(error);
    process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
  }
}

runMain();

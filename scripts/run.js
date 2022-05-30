const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();

  console.log(`Deployed WavePortal at ${waveContract.address}`);
  console.log(`Owner: ${owner.address}`);

  let waveCount;
  let wave;
  waveCount = await waveContract.getTotalWaves();

  let waveTxn = await waveContract.createWave();
  await waveTxn.wait();

  waveCount = await waveContract.getTotalWaves();

  waveTxn = await waveContract.connect(randomPerson).createWave();
  await waveTxn.wait();

  waveCount = await waveContract.getTotalWaves();

  wave = await waveContract.getWave(0);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0); // exit node without error
  } catch (error) {
    console.error(error);
    process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
  }
};

runMain();

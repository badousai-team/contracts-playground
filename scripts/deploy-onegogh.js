// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require('hardhat')

async function main() {
  const [deployer] = await ethers.getSigners()
  console.log("Deploying contracts with the account:", deployer.address)

  const deployerBalance = (await deployer.getBalance()).toString()
  console.log("Account balance:", deployerBalance)

  if (deployerBalance === '0') return // deployment will fail

  const OneGogh = await ethers.getContractFactory('OneGogh')
  const token = await OneGogh.deploy()
  await token.deployed()

  console.log('Test OneGogh deployed to:', token.address)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})

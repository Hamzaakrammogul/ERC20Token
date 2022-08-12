async function main() {
    const [deployer] = await ethers.getSigners();
  
    const Token = await ethers.getContractFactory("Token");// Creating instance
    const token = await Token.deploy(); //Deploying contract
    console.log("Token address:", token.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
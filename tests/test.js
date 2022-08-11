const{expect}= require("chai");
describe ("Token Contract Testing", function(){
       
        it ("Check the Owner", async function(){
            const [admin]= await ethers.getSigners();
            const  Token= await ethers.getContractFactory("Token");
            const hardhatToken= await Token.deploy();
            expect(await hardhatToken.admin()).to.equal(admin.address);

        });      
        it("Checking the Balance of Account", async function(){
            const [admin]= await ethers.getSigners();
            const  Token= await ethers.getContractFactory("Token");
            const hardhatToken= await Token.deploy();
            const ownerBalance= await hardhatToken.balanceOf(admin.address);
            expect(await hardhatToen.totalSupply()).to.equal(ownerBalance);
        });
    });

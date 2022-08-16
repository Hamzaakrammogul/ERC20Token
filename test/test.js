const{expect}= require("chai");
const {BigNumber}= require("@ethersproject/bignumber");

describe ("Token Contract Testing", function(){
    let admin;
    let addr1;
    let addr2;
    let name = 'My Token';
    let symbol = 'HAT';
    let decimals= 18; 

    beforeEach(async function(){
         [admin, addr1, addr2]= await ethers.getSigners();
         Token= await ethers.getContractFactory("Token");
         hardhatToken= await Token.deploy();
    });
        it('has a name', async function () {
            expect(await hardhatToken.name()).to.equal(name);
        });
        it('has a symbol', async function () {
            expect(await hardhatToken.symbol()).to.equal(symbol);
        });
        it('has 18 decimals', async function () {
            expect(await hardhatToken.decimals()).to.be.equal(decimals);
        }); 
    describe("Deployment", function(){
        it ("Check the Owner", async function(){        
            expect(await hardhatToken.admin()).to.equal(admin.address);
        });      
        it("Checking the Balance of Account", async function(){
            const adminBalance= await hardhatToken.balanceOf(admin.address);
            expect(ethers.utils.formatEther(adminBalance)).to.equal("1000000.0");     
                });
    });
    describe("Transactional",function(){
        it("Transfer", async function(){
            await hardhatToken.transfer(addr1.address, ethers.utils.parseEther("1000000"));
            const addr1Balance= await hardhatToken.balanceOf(addr1.address);
            expect (addr1Balance).to.equal(ethers.utils.parseEther("1000000"));
        });
        it("Transfer Between Accounts", async function (){
            await hardhatToken.transfer(addr1.address, ethers.utils.parseEther("2000"));
            await hardhatToken.connect(addr1).transfer(addr2.address, ethers.utils.parseEther("1000"));
            const addr2Balance= await hardhatToken.balanceOf(addr2.address);
            expect(addr2Balance).to.equal(ethers.utils.parseEther("1000"));
            expect(await hardhatToken.balanceOf(addr1.address)).to.equal(ethers.utils.parseEther("1000"));
        })
        it("Transfer From", async function(){
            await hardhatToken.connect(addr1).approve(admin.address, ethers.utils.parseEther("100"));
            await hardhatToken.transfer(addr1.address, ethers.utils.parseEther("100"));
            const addr1Balance= await hardhatToken.balanceOf(addr1.address);
            expect(addr1Balance).to.equal(ethers.utils.parseEther("100"));
            await hardhatToken.transferFrom(addr1.address, addr2.address, ethers.utils.parseEther("100"));
            expect(await hardhatToken.balanceOf(addr2.address)).to.equal(ethers.utils.parseEther("100"));
        });
    });
    describe("Burnable", function(){
        it("This should burn the extra tokens", async function(){
            await hardhatToken.burn(ethers.utils.parseEther("500000"));
            const adminBalanceburn= await hardhatToken.balanceOf(admin.address);
            expect(ethers.utils.formatEther(adminBalanceburn)).to.equal("500000.0");
        });
    });
});
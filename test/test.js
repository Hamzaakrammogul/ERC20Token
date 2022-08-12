const{expect}= require("chai");
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
            const ownerBalance= await hardhatToken.balanceOf(admin.address);
            expect(ownerBalance).to.equal(10000);
            expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
                });
    });
    describe("Transactional",function(){
        it("Transfer", async function(){
            await hardhatToken.transfer(addr1.address, 10);
            const addr1Balance= await hardhatToken.balanceOf(addr1.address);
            expect (addr1Balance).to.equal(10);
        });
        it("Transfer Between Accounts", async function (){
            await hardhatToken.transfer(addr1.address, 20);
            await hardhatToken.connect(addr1).transfer(addr2.address, 10);
            const addr2Balance= await hardhatToken.balanceOf(addr2.address);
            expect(addr2Balance).to.equal(10);
            expect(await hardhatToken.balanceOf(addr1.address)).to.equal(10);
        })
        it("Transfer From", async function(){
            await hardhatToken.transfer(addr1.address, 100);
            const addr1balance = await hardhatToken.balanceOf(addr1.address);
            expect(addr1balance).to.equal(100);
            let adminBalanceBeforeTransfer = await hardhatToken.balanceOf(admin.address);
            let addr2BalanceBeforeTransfer = await hardhatToken.balanceOf(addr2.address);
            await hardhatToken.allowance(admin.address, addr1.address);
            await hardhatToken.increaseAllowance(addr1.address, 100);
            await hardhatToken.approve(addr1.address, 100);
            await hardhatToken.transferFrom(addr1.address, addr2.address, 100,);

            let adminBalanceAfterTransfer = await hardhatToken.balanceOf(admin.address);
            let addr2BalanceAfterTransfer = await hardhatToken.balanceOf(addr2.address);

            expect(adminBalanceAfterTransfer).to.equal((adminBalanceBeforeTransfer.sub(100)));
            expect(addr2BalanceAfterTransfer).to.equal(addr2BalanceBeforeTransfer.add(100));
        });
    });
});

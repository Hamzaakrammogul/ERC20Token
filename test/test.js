const{expect}= require("chai");
describe ("Token Contract Testing", function(){
    let admin;
    let addr1;
    let addr2;
       
    beforeEach(async function(){
         [admin, addr1, addr2]= await ethers.getSigners();
         Token= await ethers.getContractFactory("Token");
         hardhatToken= await Token.deploy();
    });
    describe("Deployment", function(){
        it ("Check the Owner", async function(){        
            expect(await hardhatToken.admin()).to.equal(admin.address);
        });      
        it("Checking the Balance of Account", async function(){
            const ownerBalance= await hardhatToken.balanceOf(admin.address);
            expect(await hardhatToken.totalSupply()).to.equal(ownerBalance); 
        
        });
    });
    describe("Transactional",function(){
        it("Transfer", async function(){
            await hardhatToken.transfer(addr1.address, 10);
            const addr1Balance= await hardhatToken.balanceOf(addr1.address);
            expect (addr1Balance).to.equal(10);
        });
        it("Transfer From", async function(){
            await hardhatToken.transfer(addr1.address, 10);
            await hardhatToken.connect(addr1).transferFrom(addr1.address, addr2.address, 5)
            const addr2Blance= await hardhatToken.balanceOf(addr2.address);
            expect(addr2Blance).to.equal(5);   });

    });
    });

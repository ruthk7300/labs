pragma solidity ^0.8.20;

import "@hack/gabaim.sol";
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract GabaimTest is Test {
    Gabaim public gabaim;

    // Setup the testing environment.
    function setUp() public {
        gabaim = new Gabaim();
        payable(address(gabaim)).transfer(1000);
     
    }
    
   function testDeposit() public {
        uint initialBalance = address(gabaim).balance;
        uint amount = 100 wei;
address adr2= address(123456);
vm.prank(adr2);
 vm.deal(address(adr2), amount);
        // Send Ether to the Gabaim contract
        payable(address(gabaim)).transfer(amount);

        // Check if the balance has increased
        assertEq(address(gabaim).balance, initialBalance + amount, "Balance should increase after deposit");
   vm.stopPrank();
    }
   
    function testWithdraw() public payable {
    uint initialBalance = gabaim.getBalance();
    address adr1= address(1234);
    vm.prank(adr1);
    console.log("initialBalance",initialBalance);
    uint amount = 100 wei;
    gabaim.withdraw{value: amount}(amount);
    assertEq(gabaim.getBalance(), initialBalance - amount, "Balance should decrease after withdrawal");
    vm.stopPrank();
}

    function testWithdrawNotMoney() external {
       uint sum = 2000;
      
        address adr1= address(1234);
        vm.prank(adr1);
        uint before = address(gabaim).balance;
        
        if (before >= sum) {
        gabaim.withdraw(sum);
        uint afterwithdraw = address(gabaim).balance;
        assertEq(afterwithdraw, before - sum);
        }
        vm.stopPrank();
       
    }
      function testNotOwnerWithdraw() public {
        payable(address(gabaim)).transfer(100);
       
        gabaim.withdraw(100);
    }
}

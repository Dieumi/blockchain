pragma solidity ^0.5.16;

// ----------------------------------------------------------------------------
// Contrat de Lottery
// ----------------------------------------------------------------------------
contract  Lottery {
    
    // Owner of the contract
    address public owner;
    // Exact price to enter raffle
    uint public price;
    // Sum of the current total up for grabs
    uint public lotteryTotal;
    // winningNumber;
    uint256 public winningNumber;
    
    
    // winning address
    address public winningAddress;
    // tableau des tickets contenant leur address 
    // (Index = # de ticket)
    // (address = addresse à envoyer si gagnant)
    address payable [] public tickets;
    
    uint256 public testNumber;
    event received(string msg);
    event test(uint256 test);

    constructor(uint priceByTicket) public{
        // set owner as the address of the one who created the contract
        owner = msg.sender;
        // set the price to 2 ether
        price = priceByTicket * 1 ether;
        //set lottery lotteryTotal to 0
        lotteryTotal = 0;
      
    }

    function accept() payable public {
        // Error out if anything other than 2 ether is sent
        require(msg.value == price);

        // Track that calling account deposited ether
        // Give him a ticket
        tickets.push(msg.sender);

        // add half of the ether to the amount up for grabs
        lotteryTotal += msg.value / 2;
        
        // log that a bet was received
        emit received("Bet received");
        emit test(tickets.length);
      

    }
    
    function draw() public {
        require(msg.sender==owner);
        emit received("Bet DRAW");
        // gets a random winningNumber between 0 and 1 for now
        winningNumber = random();
        
        //send half of the ether to the winner. 
        distributeFunds();
        
        //reset the current lottery amount
        lotteryTotal = 0;
        
        //reset array of tickets
        delete tickets;
    }
    
    function distributeFunds() private {
        // Calculate amount to distribute
        uint256 balanceToDistribute = lotteryTotal;
        // send amount to winner
        tickets[winningNumber].transfer(balanceToDistribute);
        winningAddress = tickets[winningNumber];
      
    }
    //Test function for remixIDE
    function getTicket() public view returns (uint256) {
        return testNumber;
    }
    //Test function for remixIDE
    function setTicket(uint256 nb) public {
        testNumber=nb;
    }
    function random() public view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)))%tickets.length;
    }
    
    function contractCapital() public view returns (uint256) {
        return address(this).balance;
    }

}
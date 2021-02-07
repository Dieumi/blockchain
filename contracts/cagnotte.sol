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
    uint8 public winningNumber;
    // winning address
    address public winningAddress;

    bool public open;
    // tableau des tickets contenant leur address 
    // (Index = # de ticket)
    // (address = addresse à envoyer si gagnant)
    address payable[] public tickets;
    
    event received(string msg);

    constructor() public{
        // set owner as the address of the one who created the contract
        owner = msg.sender;
        // set the price to 2 ether
        price = 2 ether;
        //set lottery lotteryTotal to 0
        lotteryTotal = 0;
        open=true;
    }

    function accept() payable public{
     
    

        // Track that calling account deposited ether
        // Give him a ticket
        tickets.push(msg.sender);
        
        // add half of the ether to the amount up for grabs
        lotteryTotal += msg.value / 2;
        
        // log that a bet was received
        emit received("Bet received");
        
        if(tickets.length == 5){
            // Select random winner
            draw();
        }
    }
    
    function draw() private {
        
        // gets a random winningNumber between 0 and 1 for now
        winningNumber = random();
        
        //send half of the ether to the winner. 
        distributeFunds();
        
        //reset the current lottery amount
        lotteryTotal = 0;
        //close contract
        open = false;
        //reset array of tickets
        delete tickets;
    }
    
    function distributeFunds() private  {
        // Calculate amount to distribute
        uint256 balanceToDistribute = lotteryTotal;
        // send amount to winner
        tickets[winningNumber].transfer(balanceToDistribute);
        winningAddress = tickets[winningNumber];
       
    }
    
    function random() private view returns (uint8) {
        return uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)))%4);
    }
    
  
}
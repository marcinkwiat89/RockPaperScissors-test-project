//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract RockPaperScissors {
    
    address payable public player1; 
    address payable public player2;
    uint public pool;
    
    struct possibleChoices {
        bool Rock;
        bool Paper;
        bool Scissors;
    }
    
    mapping(address => uint) public poolBalance;
    mapping(address => possibleChoices) public structChoice;
    
    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function depositEth() public payable {
        assert(poolBalance[msg.sender] + msg.value >= poolBalance[msg.sender]);
        poolBalance[msg.sender] += msg.value;
    }
    
    function withdrawEth(address payable _to, uint _amount) public {
        require(_amount <= poolBalance[msg.sender], "Not enough funds.");
        assert(poolBalance[msg.sender] >= poolBalance[msg.sender] - _amount);
        poolBalance[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
    function getPlayer1(bool _rock, bool _paper, bool _scissors, uint _bet) public {
        player1 = payable(msg.sender);
        require(_bet > 0, "Bet must be > 0.");
        require(_bet <= poolBalance[player1], "Not enough funds for this bet.");
        require((_rock == true && _paper == false && _scissors == false) || 
                (_rock == false && _paper == true && _scissors == false) || 
                (_rock == false && _paper == false && _scissors == true), "Choose only one.");
        structChoice[msg.sender].Rock = _rock;
        structChoice[msg.sender].Paper = _paper;
        structChoice[msg.sender].Scissors = _scissors;
        
        assert(pool + _bet > pool);
        poolBalance[msg.sender] -= _bet;
        pool += _bet;
   }
   
   function getPlayer2(bool _rock, bool _paper, bool _scissors, uint _bet) public {
        player2 = payable(msg.sender);
        require(_bet > 0, "Bet must be > 0.");
        require(_bet <= poolBalance[player2], "Not enough funds for this bet.");
        require((_rock == true && _paper == false && _scissors == false) || 
                (_rock == false && _paper == true && _scissors == false) || 
                (_rock == false && _paper == false && _scissors == true), "Choose only one.");
        structChoice[msg.sender].Rock = _rock;
        structChoice[msg.sender].Paper = _paper;
        structChoice[msg.sender].Scissors = _scissors;
        
        
        assert(pool + _bet > pool);
        poolBalance[msg.sender] -= _bet;
        pool += _bet;
   }
   
   function getResult() public returns(address) {
       uint _tempPool = 0;
       _tempPool = pool;
       
       if(structChoice[player1].Rock == true) {
           if(structChoice[player2].Scissors == true) {
               pool=0;
               player1.transfer(_tempPool);
               return player1;
           }
           if(structChoice[player2].Paper == true) {
               pool=0;
               player2.transfer(_tempPool);
               return player2;
           }
       } else if(structChoice[player1].Paper == true) {
           if(structChoice[player2].Rock == true) {
               pool=0;
               player1.transfer(_tempPool);
               return player1;
           }
           if(structChoice[player2].Scissors == true) {
               pool=0;
               player2.transfer(_tempPool);
               return player2;
           }
       } else if(structChoice[player1].Scissors == true) {
           if(structChoice[player2].Paper == true) {
               pool=0;
               player1.transfer(_tempPool);
               return player1;
           }
           if(structChoice[player2].Rock == true) {
               pool=0;
               player2.transfer(_tempPool);
               return player2;
           }
       } 
       return 0x0000000000000000000000000000000000000000;
   }
}

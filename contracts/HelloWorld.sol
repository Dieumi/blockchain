pragma solidity ^0.5.0;
contract HelloWorld {
    string public message;
    constructor() public{
        message = "Hello World!";
    }
    function getMessage() public view returns(string memory){
        return message;
    }
    function getTest() public view returns(string memory) {
        return "patate";
    }
}
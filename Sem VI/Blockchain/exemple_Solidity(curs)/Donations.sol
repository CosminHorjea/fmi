// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract Caller {


    function sendEther(address payable _addr) public payable {
		(bool sent, bytes memory data) = _addr.call{value: msg.value}("");
		require(sent, "Failed to send Ether");
    }


	function gatValueFromAddress(address _addr) public view returns (uint){
        Callee callee = Callee(_addr);
        return callee.getVal2();
    }

	function setValueFromAddress(address _addr) public{
        Callee callee = Callee(_addr);
        callee.setVal2();
    }

	function setIfValueFromAddress(address _addr) public{
        Callee callee = Callee(_addr);
        callee.setIfVal2();
    }

}

contract Callee {
    uint val1;
	uint val2;


    constructor(uint _val) {
        val1 = _val ;
		val2 = 0;
    }

	function getVal1() public view returns (uint) {
        return val1;
    }

	function getIfVal1() public view returns (uint) {
        if (val1 < 1000)
			return val1;
		else 
			return 1000;	
    }


	function setVal2(uint _val) public payable{
		val2 = _val;	
    }

	function setVal2() public {
		val2 = getVal1();	
    }

	function setIfVal2() public {
		val2 = getIfVal1();
    }

    function getVal2() public view returns (uint) {
        return val2;
    }

}

contract Donations {
   
    mapping (address => string) names;
    mapping (address => uint) ids;  
	mapping (address => uint) donated;
	address payable public owner;
	uint public total;
	

    constructor(string memory _name, uint _id) {
        names[msg.sender] = _name;
        ids[msg.sender] = _id;
        owner = payable(address(msg.sender)) ;
    }

    
    receive() external payable{
        donated[msg.sender] += msg.value;
        total += msg.value;
    }

    
    function Withdraw(uint256 amount)  public{
        owner.transfer(amount);
    }
    
    
    function setSender(string memory _name, uint _id) public {
        names[msg.sender] = _name;
        ids[msg.sender] = _id;
        donated[msg.sender] = 0;
    }
    
    function getSender(address _address) public view returns (string memory, uint, uint) {
        return (names[_address], ids[_address], donated[_address]);
    }
    
    function getDonated(address _address) public view returns(uint) {
		return donated[_address];
	}
    
    function getContractBalance() public view returns (uint256){
        return (address(this).balance);
    }
    

	function setValueFromAddress(address _addr, uint _val) public payable{
        Callee callee = Callee(_addr);
        callee.setVal2{value: 100000, gas: 300000}(_val);
    }
}



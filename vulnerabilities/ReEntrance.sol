pragma solidity ^0.4.4;

contract ReEntrance {
    mapping(address => uint) balances;

    function contribute() payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawAll() public {
        uint amountToWithdraw = balances[msg.sender];
        // Re-entry through the following line
        require(msg.sender.call.value(amountToWithdraw()));
        balances[msg.sender] = 0;
    }

    function safeWithdrawAll() public {
        // Check
        uint amountToWithdraw = balances[msg.sender];
        // Effect
        balances[msg.sender] = 0;
        // Interaction
        require(msg.sender.call.value(amountToWithdraw()));
    }
}
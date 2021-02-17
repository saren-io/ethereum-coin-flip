pragma solidity ^0.4.4;

import "./Library.sol";

contract Parity {
    mapping(address => uint) balances;
    address libAddress;
    Library lib = Library(libAddress);


    function contribute() payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawAll() public {
        if (lib.isNotPositive(balances[msg.sender])) {
            throw;
        }
        // Check
        uint amountToWithdraw = balances[msg.sender];
        // Effect
        balances[msg.sender] = 0;
        // Interaction
        require(msg.sender.call.value(amountToWithdraw()));
    }
}
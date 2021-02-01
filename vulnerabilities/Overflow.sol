pragma solidity ^0.4.4;

import "../utils/SafeMath.sol";

contract Overflow {
    mapping(address => uint) balance;

    function contribute() payable {
        // 1 wei = 1 token
        balances[msg.sender] += msg.value;
    }
    // Constant does not spend gas
    function getBalance() constant returns (uint){
        return balances[msg.sender];
    }

    function batchTransfer(address[] _receivers, uint _value) {
        // Overflow vulnerability
        uint total = _receivers.length * _value;
        require(balances[msg.sender] >= total);

        // Subtract from sender
        balances[msg.sender] = balances[msg.sender] - total;

        for (uint i = 0; i < _receivers.length; i++) {
            balances[_receivers[i]] += _value;
        }
    }

    // Fixed overflow vulnerability
    function secureBatchTransfer(address[] _receivers, uint _value) {
        uint total = SafeMath.mul(_receivers.length, _value);
        require(balances[msg.sender] >= total);

        // Subtract from sender
        balances[msg.sender] = SafeMath.sub(balances[msg.sender], total);

        for (uint i = 0; i < _receivers.length; i++) {
            balances[_receivers[i]] = SafeMath.add(balances[_receivers[i]], _value);
        }
    }
}
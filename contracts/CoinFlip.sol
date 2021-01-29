pragma solidity 0.7.5;

contract CoinFlip {

    function random() public view returns (uint){
        return now % 2;
    }
}
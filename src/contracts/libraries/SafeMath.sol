// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint x, uint y) internal pure returns(uint) {
        uint r = x + y;
        require(r >= x, "SafeMath: Addition Overflow");
        return r;
    }

    function sub(uint x, uint y) internal pure returns(uint) {
        uint r = x - y;
        require(y <= x, "SafeMath: Subtraction Overflow");
        return r;
    }

    function mult(uint x, uint y) internal pure returns(uint) {
        if(x == 0) {
            return 0;
        }
        uint r = x * y;
        require(r /x ==y, "SafeMath: Multiplication Overflow");
        return r;
    }
    function divide(uint x, uint y) internal pure returns(uint) {
        require(y > 0, "SafeMath: Division by 0");
        uint r = x / y;
        return r;
    }
    function mod(uint x, uint y) internal pure returns(uint) {
        require(y != 0, "SafeMath: Modulo by 0");
        uint r = x % y;
        return r;
    }
}
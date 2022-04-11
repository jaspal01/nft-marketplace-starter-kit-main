//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import './SafeMath.sol';

library Counters {
    using SafeMath for uint;
    struct Counter {
        uint _value;
    }
    function current(Counter storage counter) internal view returns(uint) {
        return counter._value;
    }
    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
    function increment(Counter storage counter) internal {
        counter._value = counter._value += 1;
    }

}
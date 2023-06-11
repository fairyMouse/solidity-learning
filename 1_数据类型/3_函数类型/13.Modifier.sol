// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Modifier {
    /**
     * modifier
     * 可以用来轻易的改变一个函数的行为，控制函数的逻辑，比如用于在函数执行前检查某种前置条件
     * 是一种合约属性，可以被继承，同时还可被派生的合约重写
     */
    uint256 public a;
    modifier countModifier() {
        a++; // 函数执行前
        _; // 函数执行位置
        a--; // 函数执行后
    }

    function runCount() public countModifier returns (uint256) {
        uint256 b = a;
        return b;
    }

    address public owner;
    constructor() public {
        owner = msg.sender;
    }

    modifier ownerOnly(address addr) {
        require(addr == owner); // 必须是当前用户才能调用某个函数
        _;
    }

    function useSuperPowers() public ownerOnly(msg.sender) countModifier {
        a = 10;
    }
}

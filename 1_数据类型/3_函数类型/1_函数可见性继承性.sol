// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Function {
    uint256 public num = 0;
    string public str = "hhh";

    // 获取多个返回值
    function getVlaue() public view returns (uint256, string memory) {
        return (num, str);
    }

    /**
     * 设置值
     * - 非值类型需要加memory修饰符（否则报错）
     * - 可以按顺序设置：setValue(111, "testSet1");
     * - 也可以以json形式传入： setValue({_num: 222, _str: "testSet2"});
     *  - 方便为指定参数赋值，但参数不能少传也不能多传（会报错）
     */
    function setValue(uint256 _num, string memory _str) internal {
        num = _num;
        str = _str;
    }

    function testSet1(string memory _str) external {
        setValue(111, _str);
    }

    function testSet2() private {
        setValue({_num: 222, _str: "testSet2"});
    }

    function testSet3(string memory _str) public  {
        setValue(333, _str);
    }

    /**
    * 函数调用
    */
    function callFunc() public {
        // internal函数：只能在内部调用，不能在外部调用
        setValue(999, "callFunc");

        // external函数：一般只在外部调用
        // testSet1(); // 这样会报错
        // this.testSet1(); // 在内部只能这样调用external函数

        // testSet2();
        testSet3("qwe");

    }

    // virtual表示可以被子合约函数重写
    function callInternalFunc() public virtual {
        setValue(444, "parent callInternalFunc");
    }
}

contract ChildFunction is Function {
    // override表示重写父合约函数
    function callInternalFunc() public virtual override {
       setValue(555, "child callInternalFunc");
    }
}

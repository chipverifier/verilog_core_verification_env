// 1位半加器（Half Adder）：无进位输入，仅计算两个1位二进制数的和与进位
module half_adder (
    input  wire A,    // 输入1：1位二进制数
    input  wire B,    // 输入2：1位二进制数
    output wire S,    // 输出：和（Sum）
    output wire Cout  // 输出：进位（Carry Out）
);

// 组合逻辑实现：无需always块，直接用assign描述
assign S    = A ^ B;  // 和 = A异或B（不同为1，相同为0）
assign Cout = A & B;  // 进位 = A与B（均为1时进位1）

endmodule


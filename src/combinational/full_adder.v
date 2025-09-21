// 1位全加器（Full Adder）
// 功能：计算A + B + Cin，输出和S与进位Cout
module full_adder (
    input  wire A,    // 1位加数
    input  wire B,    // 1位加数
    input  wire Cin,  // 进位输入（区别于半加器的关键）
    output wire S,    // 和输出
    output wire Cout  // 进位输出
);

// 中间信号：连接两个半加器的临时结果
wire s_temp;  // 第一个半加器的"和"输出（A⊕B）
wire c1;      // 第一个半加器的进位输出（A&B）
wire c2;      // 第二个半加器的进位输出（(A⊕B)&Cin）

// 第1个半加器：计算A + B，得到临时和s_temp与进位c1
half_adder ha1 (
    .A(A),
    .B(B),
    .S(s_temp),  // 输出A⊕B
    .Cout(c1)    // 输出A&B
);

// 第2个半加器：计算s_temp + Cin，得到最终和S
half_adder ha2 (
    .A(s_temp),  // 输入为第一个半加器的"和"
    .B(Cin),
    .S(S),       // 最终和：A⊕B⊕Cin
    .Cout(c2)    // 输出(A⊕B)&Cin
);

// 或门：合并两个进位，得到最终进位输出Cout
assign Cout = c1 | c2;  // 等价于(A&B) | ((A⊕B)&Cin)

endmodule


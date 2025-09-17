/*
 * 测试文件：tb_and_gate
 * 功能：验证AndGate模块的所有输入场景
 * 测试点：a=0&b=0、a=0&b=1、a=1&b=0、a=1&b=1
 */
module tb_AndGate;

// 1. 定义测试信号（对接DUT接口）
reg  a;
reg  b;
wire y;

// 2. 例化待测试模块（DUT：Design Under Test）
AndGate u_AndGate(
    .a(a),
    .b(b),
    .y(y)
);

// 3. 生成激励（覆盖所有测试点）
initial begin
    // 初始化输入
    a = 1'b0;
    b = 1'b0;
    #10;  // 等待10个时间单位

    a = 1'b0;
    b = 1'b1;
    #10;

    a = 1'b1;
    b = 1'b0;
    #10;

    a = 1'b1;
    b = 1'b1;
    #10;

    // 结束仿真
    $finish;
end

// 4. Dump波形（生成.vcd文件，用波形工具查看）
initial begin
    $dumpfile("waves/tb_and_gate.vcd");  // 波形文件路径（对应sim/waves目录）
    $dumpvars(0, tb_AndGate);  // Dump所有层级信号
end

endmodule

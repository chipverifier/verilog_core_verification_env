// 半加器测试文件（SystemVerilog）：覆盖所有输入组合，加入自动验证
module tb_half_adder;
    // SystemVerilog推荐用logic类型（自动推断reg/wire）
    logic A, B;       // 输入激励（测试端）
    logic S, Cout;    // 输出观测（连接DUT）

    // 实例化被测模块（DUT：Design Under Test）
    half_adder dut (
        .A(A),
        .B(B),
        .S(S),
        .Cout(Cout)
    );

    // 1. 波形生成配置（复用与门项目的路径逻辑）
    initial begin
        $dumpfile("./waves/tb_half_adder.vcd");  // 输出波形文件
        $dumpvars(0, tb_half_adder);             // dump所有层级信号
    end

    // 2. 测试激励与自动验证（SystemVerilog增强部分）
    initial begin
        $display("=== 开始半加器测试 ===");
        $display("A | B | 预期S | 实际S | 预期Cout | 实际Cout | 结果");
        $display("------------------------------------------");

        // 测试用例1：A=0, B=0 → 预期S=0, Cout=0
        A = 0; B = 0; #10;
        check_result(0, 0);

        // 测试用例2：A=0, B=1 → 预期S=1, Cout=0
        A = 0; B = 1; #10;
        check_result(1, 0);

        // 测试用例3：A=1, B=0 → 预期S=1, Cout=0
        A = 1; B = 0; #10;
        check_result(1, 0);

        // 测试用例4：A=1, B=1 → 预期S=0, Cout=1
        A = 1; B = 1; #10;
        check_result(0, 1);

        $display("=== 测试结束 ===");
        $finish;  // 终止仿真
    end

    // 3. 封装验证函数（SystemVerilog函数特性）
    function void check_result(logic exp_S, logic exp_Cout);
        // 打印当前输入与输出
        $write("%0d | %0d |   %0d    |   %0d    |    %0d     |    %0d     | ",
               A, B, exp_S, S, exp_Cout, Cout);
        
        // 自动判断结果（通过/失败）
        if (S == exp_S && Cout == exp_Cout) begin
            $display("PASS");
        end else begin
            $display("FAIL");  // 失败时终端会高亮显示
        end
    endfunction

endmodule


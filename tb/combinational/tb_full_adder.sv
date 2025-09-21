// 全加器测试文件（SystemVerilog）
// 测试目标：验证所有8种输入组合下的S和Cout是否正确
module tb_full_adder;
    // 输入信号（用logic类型，自动推断为reg）
    logic A, B, Cin;
    // 输出信号（观测DUT的输出）
    logic S, Cout;

    // 实例化被测模块（DUT）
    full_adder dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    // 1. 波形生成配置（复用项目路径）
    initial begin
        $dumpfile("./waves/tb_full_adder.vcd");  // 波形文件路径
        $dumpvars(0, tb_full_adder);             // 记录所有层级信号
    end

    // 2. 测试激励与自动验证
    initial begin
        $display("=== 全加器测试开始 ===");
        $display("A | B | Cin | 预期S | 实际S | 预期Cout | 实际Cout | 结果");
        $display("--------------------------------------------------------");

        // 用循环遍历所有8种输入组合（3位二进制数0~7）
        for (int i = 0; i < 8; i++) begin
            // 拆分i为3位：A=最高位，B=中间位，Cin=最低位
            {A, B, Cin} = i;  // 例如i=3 → 二进制11 → A=0,B=1,Cin=1（因3位不足，高位补0）
            #10;  // 等待10ns，让信号稳定

            // 调用验证函数，传入预期结果
            check_result(
                A ^ B ^ Cin,                // 预期S = A⊕B⊕Cin
                (A & B) | (Cin & (A ^ B))   // 预期Cout = (A&B)|(Cin&(A⊕B))
            );
        end

        $display("=== 全加器测试结束 ===");
        $finish;  // 终止仿真
    end

    // 3. 验证结果的函数（封装判断逻辑）
    function void check_result(logic exp_S, logic exp_Cout);
        $write("%0d | %0d |  %0d  |   %0d    |   %0d    |    %0d     |    %0d     | ",
               A, B, Cin, exp_S, S, exp_Cout, Cout);
        
        // 自动判断并打印PASS/FAIL
        if (S == exp_S && Cout == exp_Cout) begin
            $display("PASS");
        end else begin
            $display("FAIL");  // 失败时一目了然
        end
    endfunction

endmodule


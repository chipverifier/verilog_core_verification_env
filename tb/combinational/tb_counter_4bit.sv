module tb_counter_4bit;
    // 激励信号（reg类型）
    reg clk;
    reg rst_n;
    reg en;
    // 响应信号（wire类型）
    wire [3:0] cnt;
    wire cout;

    // 1. 实例化被测模块（DUT）
    counter_4bit dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .cnt(cnt),
        .cout(cout)
    );

    // 2. 生成时钟（50MHz，周期20ns）
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;  // 每10ns翻转一次，周期20ns
    end

    // 3. 编写测试用例（激励序列）
    initial begin
        // 初始化：复位
        rst_n = 1'b0;
        en = 1'b0;
        #20;  // 等2个时钟周期（让复位生效）

        // 场景1：复位释放，不使能（计数应保持0）
        rst_n = 1'b1;
        en = 1'b0;
        #40;  // 等2个时钟周期
        if (cnt != 4'd0) $error("场景1失败：不使能时计数应保持0");

        // 场景2：使能计数（从0计到15，共16个时钟周期）
	@(posedge clk);
        en = 1'b1;
        #300;  // 16个周期 × 20ns = 320ns
        if (cnt != 4'd15) $error("场景2失败：计数未到15");

        // 场景3：继续计数，触发溢出（15→0，同时cout置1）
        #20;  // 再等1个时钟周期
        if (cnt != 4'd0 || cout != 1'b1) $error("场景3失败：溢出时未清零或无cout");

        // 场景4：溢出后继续计数（0→1，cout置0）
        #20;
        if (cnt != 4'd1 || cout != 1'b0) $error("场景4失败：溢出后计数未加1或cout未置0");

        // 结束仿真
        $display("所有测试场景执行完成！");
        $finish;
    end

    // 4. 加SVA断言（检查时序正确性：只有clk上升沿，cnt才会变）
    assert property (@(posedge clk) $stable(cnt) || en) 
    else $error("断言失败：非使能时cnt被修改");

    // 5.  dump波形（供GTKWave查看）
    initial begin
        $dumpfile("waves/tb_counter_4bit.vcd");
        $dumpvars(0, tb_counter_4bit);
    end

endmodule

`timescale 1ns/1ps

module tb_sync_fifo();

// 参数定义（与FIFO保持一致）
parameter DATA_WIDTH = 8;
parameter DEPTH      = 16;

// 信号定义
reg                  clk;
reg                  rst_n;
reg                  wr_en;
reg                  rd_en;
reg  [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
wire                 full;
wire                 empty;

// 实例化FIFO
sync_fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH)
) u_sync_fifo (
    .clk      (clk),
    .rst_n    (rst_n),
    .wr_en    (wr_en),
    .rd_en    (rd_en),
    .data_in  (data_in),
    .data_out (data_out),
    .full     (full),
    .empty    (empty)
);

// 生成时钟（50MHz，周期20ns）
initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;  // 每10ns翻转一次
end

// 激励序列
initial begin
    // 初始化
    rst_n   = 1'b0;  // 复位
    wr_en   = 1'b0;
    rd_en   = 1'b0;
    data_in = 8'd0;
    #20;  // 等待20ns

    // 释放复位（验证初始空状态）
    rst_n = 1'b1;
    #20;
    $display("=== 复位后状态检查 ===");
    $display("empty=%b, full=%b（预期：empty=1, full=0）", empty, full);

    // 阶段1：连续写入数据，直到FIFO满
    $display("\n=== 开始写入数据，直到FIFO满 ===");
    wr_en = 1'b1;  // 使能写
    rd_en = 1'b0;  // 禁止读
    for (int i=0; i<DEPTH+1; i=i+1) begin  // 多写1个验证满状态保护
        data_in = i;  // 写入数据：0,1,2,...,15,16
        #20;  // 等待一个时钟周期
        $display("写入数据：%d, full=%b（第%d次写）", data_in, full, i+1);
    end
    wr_en = 1'b0;  // 停止写
    #20;

    // 阶段2：连续读出数据，直到FIFO空
    $display("\n=== 开始读出数据，直到FIFO空 ===");
    rd_en = 1'b1;  // 使能读
    wr_en = 1'b0;  // 禁止写
    for (int i=0; i<DEPTH+1; i=i+1) begin  // 多读1个验证空状态保护
        #20;  // 等待一个时钟周期（数据在下一拍输出）
        $display("读出数据：%d, empty=%b（第%d次读）", data_out, empty, i+1);
    end
    rd_en = 1'b0;  // 停止读
    #20;

    // 阶段3：边写边读（同时读写）
    $display("\n=== 边写边读测试 ===");
    wr_en = 1'b1;
    rd_en = 1'b1;
    for (int i=100; i<100+8; i=i+1) begin  // 写入8个新数据：100~107
        data_in = i;
        #20;
        $display("写入：%d, 读出：%d, full=%b, empty=%b", data_in, data_out, full, empty);
    end
    wr_en = 1'b0;
    rd_en = 1'b1;  // 读完剩余数据
    #200;  // 等待足够时间读完

    $display("\n=== 所有测试完成 ===");
    $finish;  // 结束仿真
end

endmodule


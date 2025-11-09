`timescale 1ns / 1ps

module pcie_endpoint_tb;

reg         clk;
reg         rst_n;
reg [31:0]  tlp_data;
reg         tlp_valid;
wire [31:0] rsp_data;
wire        rsp_valid;

// 实例化DUT
pcie_endpoint uut (
    .clk(clk),
    .rst_n(rst_n),
    .tlp_data(tlp_data),
    .tlp_valid(tlp_valid),
    .rsp_data(rsp_data),
    .rsp_valid(rsp_valid)
);

// 时钟生成（100MHz）
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// 生成波形文件
initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, pcie_endpoint_tb);
end

// 测试序列（带PASS/FAIL判断）
initial begin
    tlp_data = 32'h00000000;
    tlp_valid = 1'b0;
    rst_n = 1'b0;
    
    // 复位
    #10;
    rst_n = 1'b1;
    #10;
    
    // 测试1: 读配置ID（预期0x12345678）
    $display("\n=== 测试1: 读配置ID ===");
    send_tlp(1'b1, 1'b0, 8'h00, 16'h0000);
    check_rsp(32'h12345678);  // 传入预期值
    
    // 测试2: 写BAR0（预期响应0x00000001）
    $display("\n=== 测试2: 写BAR0 ===");
    send_tlp(1'b1, 1'b1, 8'h10, 16'h1234);
    check_rsp(32'h00000001);
    
    // 测试3: 读BAR0（预期0x00001234）
    $display("\n=== 测试3: 读BAR0 ===");
    send_tlp(1'b1, 1'b0, 8'h10, 16'h0000);
    check_rsp(32'h00001234);
    
    // 测试4: 写存储器（预期响应0x00000001）
    $display("\n=== 测试4: 写存储器 ===");
    send_tlp(1'b0, 1'b1, 8'h02, 16'h5678);
    check_rsp(32'h00000001);
    
    // 测试5: 读存储器（预期0x00005678）
    $display("\n=== 测试5: 读存储器 ===");
    send_tlp(1'b0, 1'b0, 8'h02, 16'h0000);
    check_rsp(32'h00005678);
    
    #20;
    $display("\n===== 所有测试结束 =====");
    $finish;
end

// 发送TLP任务（保持不变）
task send_tlp;
    input        is_config;
    input        is_write;
    input [7:0]  addr;
    input [15:0] wdata;
begin
    @(posedge clk);
    tlp_data = {is_config, is_write, 6'h00, addr, wdata};
    tlp_valid = 1'b1;
    $display("发送TLP: 0x%h", tlp_data);
    @(posedge clk);
    tlp_valid = 1'b0;
end
endtask

// 新增：带预期值检查的响应判断任务
task check_rsp(input [31:0] expected);
begin
    while (!rsp_valid) @(posedge clk);  // 等待响应
    
    // 比较实际值与预期值
    if (rsp_data === expected) begin
        $display("响应检查: PASS (实际: 0x%h, 预期: 0x%h)", rsp_data, expected);
    end else begin
        $display("响应检查: FAIL (实际: 0x%h, 预期: 0x%h)", rsp_data, expected);
    end
end
endtask

endmodule
    

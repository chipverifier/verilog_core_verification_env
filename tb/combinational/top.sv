`include "driver.sv"
`include "proxy.sv"
`include "dut.sv"

module top;
  reg clk = 0;
  always #5 clk = ~clk; // 生成100MHz时钟

  // 信号定义：连接各模块
  reg [7:0] drv_data;
  reg [1:0] drv_channel;
  reg       drv_valid;
  wire      px_ready;
  reg [7:0] port1_data, port2_data, port3_data;
  reg       port1_valid, port2_valid, port3_valid;

  // 例化模块
  driver drv (
    .data(drv_data),
    .channel_id(drv_channel),
    .valid(drv_valid),
    .clk(clk),
    .ready(px_ready)
  );

  proxy px (
    .data(drv_data),
    .channel_id(drv_channel),
    .valid(drv_valid),
    .ready(px_ready),
    .port1_data(port1_data),
    .port1_valid(port1_valid),
    .port2_data(port2_data),
    .port2_valid(port2_valid),
    .port3_data(port3_data),
    .port3_valid(port3_valid),
    .clk(clk)
  );

  dut my_dut (
    .port1_data(port1_data),
    .port1_valid(port1_valid),
    .port2_data(port2_data),
    .port2_valid(port2_valid),
    .port3_data(port3_data),
    .port3_valid(port3_valid),
    .clk(clk)
  );

  // 测试逻辑：发送带不同通道ID的数据
  initial begin
    $display("[TB] 开始测试：发送带不同通道ID的数据");
    
    drv.send_trans(8'd10, 2'd0); // 通道0 → DUT接口1
    drv.send_trans(8'd20, 2'd1); // 通道1 → DUT接口2
    drv.send_trans(8'd30, 2'd2); // 通道2 → DUT接口3
    drv.send_trans(8'd40, 2'd3); // 无效通道ID
    
    #200;
    $display("[TB] 测试结束");
    $finish;
  end
endmodule

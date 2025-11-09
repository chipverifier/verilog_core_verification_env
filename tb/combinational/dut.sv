module dut (
    input [7:0] port1_data,
    input       port1_valid,
    input [7:0] port2_data,
    input       port2_valid,
    input [7:0] port3_data,
    input       port3_valid,
    input       clk
);

  // 各接口数据接收逻辑
  always @(posedge clk) begin
    if (port1_valid) $display("[DUT接口1] 接收数据: %0d", port1_data);
    if (port2_valid) $display("[DUT接口2] 接收数据: %0d", port2_data);
    if (port3_valid) $display("[DUT接口3] 接收数据: %0d", port3_data);
  end

endmodule

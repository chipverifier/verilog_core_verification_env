// dut.v：Verilog格式的加法器DUT
module adder (
  input  wire [7:0] a,    // 输入a（Verilog用wire）
  input  wire [7:0] b,    // 输入b
  output wire [8:0] sum   // 输出sum（a+b）
);
  assign sum = a + b;  // 组合逻辑实现加法
endmodule

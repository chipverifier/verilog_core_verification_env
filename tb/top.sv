`include "../env/env.sv"

module top;
  // 声明连接信号（与DUT端口匹配）
  logic [7:0] a, b;
  logic [8:0] sum;

  // 实例化DUT（.v文件）
  adder dut (
    .a(a),
    .b(b),
    .sum(sum)
  );

  // 实例化验证环境
  add_env env;

  initial begin
    env = new("env", null);
    // 将driver的信号与DUT连接
    env.drv.a = a;
    env.drv.b = b;
    env.drv.sum = sum;
    // 启动仿真
    env.run_phase();
    #100;
    $finish;
  end
endmodule

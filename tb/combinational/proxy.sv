module proxy (
    input [7:0] data,            // 输入数据
    input [1:0] channel_id,      // 输入通道ID
    input       valid,           // 数据有效信号
    output reg  ready,           // 握手就绪信号
    // 输出到DUT的3个接口
    output reg [7:0] port1_data,
    output reg       port1_valid,
    output reg [7:0] port2_data,
    output reg       port2_valid,
    output reg [7:0] port3_data,
    output reg       port3_valid,
    input            clk         // 时钟
);

  always @(posedge clk) begin
    ready = !valid; // 就绪信号与有效信号互斥
    if (valid) begin
      $display("[PROXY] 接收数据: %0d, 通道ID: %0d", data, channel_id);
      // 根据通道ID路由到对应DUT接口
      case(channel_id)
        2'd0: begin // 路由到接口1
          port1_data = data;
          port1_valid = 1'b1;
          $display("[PROXY] 路由到DUT接口1");
        end
        2'd1: begin // 路由到接口2
          port2_data = data;
          port2_valid = 1'b1;
          $display("[PROXY] 路由到DUT接口2");
        end
        2'd2: begin // 路由到接口3
          port3_data = data;
          port3_valid = 1'b1;
          $display("[PROXY] 路由到DUT接口3");
        end
        default: $error("[PROXY] 无效通道ID: %0d", channel_id);
      endcase
    end else begin
      // 拉低所有接口的有效信号
      port1_valid = 1'b0;
      port2_valid = 1'b0;
      port3_valid = 1'b0;
    end
  end

endmodule

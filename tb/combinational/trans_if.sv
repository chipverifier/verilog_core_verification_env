// 事务结构：封装数据和通道ID
typedef struct {
  bit [7:0] data;
  bit [1:0] channel_id;
} trans_t;

// 通信接口：传递事务（用寄存器模拟邮箱）
module trans_if (
    output reg [7:0] data,
    output reg [1:0] channel_id,
    output reg       valid,
    input            ready
);
  // 初始化为无效状态
  initial begin
    valid = 1'b0;
    data = 8'd0;
    channel_id = 2'd0;
  end
endmodule

module driver (
    output reg [7:0] data,       // 输出数据
    output reg [1:0] channel_id, // 输出通道ID
    output reg       valid,      // 数据有效信号
    input            clk,        // 时钟
    input            ready       // 握手就绪信号
);

  // 发送事务任务：驱动数据和通道ID
  task send_trans(input bit [7:0] d, input bit [1:0] ch);
    @(posedge clk);
    data = d;
    channel_id = ch;
    valid = 1'b1;
    $display("[DRIVER] 发送数据: %0d, 通道ID: %0d", d, ch);
    wait(ready); // 等待Proxy就绪
    @(posedge clk);
    valid = 1'b0;
    $display("[DRIVER] 数据发送完成");
  endtask

endmodule

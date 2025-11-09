// 纯Verilog模块：driver到proxy的数据转发
module driver_proxy (
    input  [7:0] driver_data,  // driver输入数据
    input        driver_valid, // driver数据有效信号
    output reg [7:0] proxy_data,  // proxy输出数据
    output reg       proxy_valid   // proxy数据有效信号
);

// 数据转发逻辑（iverilog完全兼容）
always @(*) begin
    if (driver_valid) begin
        proxy_data  = driver_data;
        proxy_valid = 1'b1;
        $display("[PROXY] 接收数据: %0d (valid=1)", proxy_data);
    end else begin
        proxy_data  = 8'd0;
        proxy_valid = 1'b0;
        // 简单判断：仅当valid从1变0时打印
        if (driver_valid) begin
            $display("[PROXY] 数据转发完成 (valid=0)");
        end
    end
end

endmodule

module counter_4bit (
    input        clk,      // 时钟（上升沿触发）
    input        rst_n,    // 同步复位（低电平有效）
    input        en,       // 计数使能（高电平有效）
    output reg [3:0] cnt,  // 4位计数值
    output reg   cout      // 溢出标志（高电平1个时钟周期）
);

// 同步计数逻辑
always @(posedge clk) begin
    if (!rst_n) begin  // 复位：计数清零，溢出标志置0
        cnt <= 4'd0;
        cout <= 1'b0;
    end else if (en) begin  // 使能时计数
        if (cnt == 4'd15) begin  // 计数到最大值，溢出
            cnt <= 4'd0;
            cout <= 1'b1;
        end else begin  // 未到最大值，正常计数
            cnt <= cnt + 4'd1;
            cout <= 1'b0;
        end
    end else begin  // 未使能，保持当前值
        cnt <= cnt;
        cout <= 1'b0;
    end
end

endmodule

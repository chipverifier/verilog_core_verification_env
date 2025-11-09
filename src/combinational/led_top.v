module led_top (
    input wire clk,
    input wire reset,  // 新增复位输入
    output reg led
);
    reg [31:0] counter;  // 移除声明时的初始值 = 0

    always @(posedge clk) begin
        if (reset) begin  // 复位时，counter和led置0
            counter <= 0;
            led <= 0;
        end else begin
            if (counter >= 10) begin
                counter <= 0;
                led <= ~led;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule

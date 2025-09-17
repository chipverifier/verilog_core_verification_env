/*
 * 模块名：AndGate
 * 功能：2输入与门（组合逻辑）
 * 接口：
 * - input  wire a：输入信号1（高电平1，低电平0）
 * - input  wire b：输入信号2（高电平1，低电平0）
 * - output reg  y：输出信号（y = a & b）
 */
module AndGate(
    input  wire a,
    input  wire b,
    output reg  y
);

// 组合逻辑：无时钟，输入变化直接影响输出
always @(*) begin
    y = a & b;  // 与门核心逻辑
end

endmodule

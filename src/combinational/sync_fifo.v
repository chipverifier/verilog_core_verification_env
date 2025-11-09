module sync_fifo #(
    parameter DATA_WIDTH = 8,    // 数据宽度
    parameter DEPTH      = 16    // FIFO深度（需为2的整数次幂）
)(
    input                       clk,      // 时钟信号（读写共用）
    input                       rst_n,    // 异步复位（低有效）
    input                       wr_en,    // 写使能
    input                       rd_en,    // 读使能
    input  [DATA_WIDTH-1:0]     data_in,  // 输入数据
    output reg [DATA_WIDTH-1:0] data_out, // 输出数据
    output reg                  full,     // 满状态标志
    output reg                  empty     // 空状态标志
);

// 计算地址位宽（例如：DEPTH=16时，ADDR_WIDTH=4）
localparam ADDR_WIDTH = $clog2(DEPTH);

// 内部信号定义
reg [ADDR_WIDTH:0] wr_ptr;  // 写指针（扩展1位用于满判断）
reg [ADDR_WIDTH:0] rd_ptr;  // 读指针（扩展1位用于满判断）
reg [DATA_WIDTH-1:0] fifo_mem [DEPTH-1:0];  // 存储阵列

// 复位逻辑：指针归零，空满标志初始化
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        wr_ptr  <= {ADDR_WIDTH+1{1'b0}};
        rd_ptr  <= {ADDR_WIDTH+1{1'b0}};
        data_out <= {DATA_WIDTH{1'b0}};
        full    <= 1'b0;
        empty   <= 1'b1;  // 初始为空
    end else begin
        // 写操作：当FIFO未满且写使能有效时
        if (wr_en && !full) begin
            fifo_mem[wr_ptr[ADDR_WIDTH-1:0]] <= data_in;  // 写入数据
            wr_ptr <= wr_ptr + 1'b1;  // 写指针自增
        end

        // 读操作：当FIFO非空且读使能有效时
        if (rd_en && !empty) begin
            data_out <= fifo_mem[rd_ptr[ADDR_WIDTH-1:0]];  // 读出数据
            rd_ptr <= rd_ptr + 1'b1;  // 读指针自增
        end

        // 空状态判断：读写指针完全相等时为空
        empty <= (wr_ptr == rd_ptr) ? 1'b1 : 1'b0;

        // 满状态判断：低N位相等，最高位不同时为满
        full  <= ({~wr_ptr[ADDR_WIDTH], wr_ptr[ADDR_WIDTH-1:0]} == rd_ptr) ? 1'b1 : 1'b0;
    end
end

endmodule


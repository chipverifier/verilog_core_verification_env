`timescale 1ns / 1ps

module pcie_endpoint(
    input         clk,
    input         rst_n,
    input [31:0]  tlp_data,
    input         tlp_valid,
    output reg [31:0] rsp_data,
    output reg       rsp_valid
);

// 配置空间寄存器
reg [15:0] vendor_id;
reg [15:0] device_id;
reg [15:0] bar0;

// 存储器（8个16位单元）
reg [15:0] mem [0:7];

// TLP字段解析
wire is_config = tlp_data[31];
wire is_write  = tlp_data[30];
wire [7:0] addr = tlp_data[23:16];
wire [15:0] wdata = tlp_data[15:0];

// 初始化
initial begin
    vendor_id = 16'h1234;
    device_id = 16'h5678;
    bar0 = 16'h0000;
    // 初始化存储器
    for(int i=0; i<8; i=i+1) begin
        mem[i] = 16'h0000;
    end
end

// 主逻辑
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        rsp_data <= 32'h00000000;
        rsp_valid <= 1'b0;
    end else begin
        rsp_valid <= 1'b0;
        
        if(tlp_valid) begin
            if(is_config) begin
                // 配置空间访问
                if(is_write) begin
                    // 配置写
                    if(addr == 8'h10) begin
                        bar0 <= wdata;
                    end
                    rsp_data <= 32'h00000001; // 成功标志
                    rsp_valid <= 1'b1;
                end else begin
                    // 配置读
                    case(addr)
                        8'h00: rsp_data <= {vendor_id, device_id};
                        8'h10: rsp_data <= {16'h0000, bar0};
                        default: rsp_data <= 32'h00000000;
                    endcase
                    rsp_valid <= 1'b1;
                end
            end else begin
                // 存储器访问
                if(addr < 8) begin
                    if(is_write) begin
                        mem[addr] <= wdata;
                        rsp_data <= 32'h00000001;
                        rsp_valid <= 1'b1;
                    end else begin
                        rsp_data <= {16'h0000, mem[addr]};
                        rsp_valid <= 1'b1;
                    end
                end else begin
                    rsp_data <= 32'hDEADDEAD; // 地址错误
                    rsp_valid <= 1'b1;
                end
            end
        end
    end
end

endmodule
    

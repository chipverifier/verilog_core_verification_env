// iface.sv：抽象driver与proxy的通信接口
interface driver_proxy_if;
  logic [7:0] driver_data;  // driver输出数据
  logic       driver_valid; // driver数据有效信号
  logic [7:0] proxy_data;   // proxy输出数据
  logic       proxy_valid;  // proxy数据有效信号
endinterface

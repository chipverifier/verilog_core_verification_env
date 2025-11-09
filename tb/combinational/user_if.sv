// 虚拟接口：包含数据、有效信号、通道标识（区分不同Driver）
interface user_if;
  logic [7:0] data;        // 数据
  logic       valid;       // 数据有效
  logic [1:0] channel_id;  // 通道标识（0=A, 1=B, 2=C）
endinterface

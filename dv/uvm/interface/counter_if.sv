interface counter_if (input clk, input rst_n);
    // DUT输入信号（UVM → DUT）
    logic en;
    logic up_down;
    // DUT输出信号（DUT → UVM）
    logic [3:0] cnt;
    logic overflow;

    // 驱动时钟块：Driver用它同步发激励（避免时序竞争）
    clocking drv_clk @(posedge clk);
        default input #1 output #1; // 输入/输出延迟1ns
        output en, up_down;
    endclocking

    // 监控时钟块：Monitor用它同步采数据
    clocking mon_clk @(posedge clk);
        default input #1;
        input en, up_down, cnt, overflow;
    endclocking
endinterface

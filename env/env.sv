`include "../env/uvm_stub.sv"

// 1. 事务类型：与之前相同（含a、b、预期结果）
class add_txn extends uvm_transaction;
  logic [7:0] a, b;
  logic [8:0] exp_sum;
  function new(logic [7:0] a=0, logic [7:0] b=0);
    this.a = a;
    this.b = b;
    this.exp_sum = a + b;
  endfunction
endclass

// 2. Sequence：生成随机请求（不变）
class add_seq extends uvm_sequence #(add_txn);
  task body();
    add_txn txn;
    repeat(5) begin
      txn = new($urandom, $urandom);
      $display("[SEQ] 生成请求: a=%0d, b=%0d, 预期sum=%0d", txn.a, txn.b, txn.exp_sum);
      start_item(txn);
      finish_item(txn);
      #10;
    end
  endtask
endclass

// 3. Sequencer：不变
class add_sqr extends uvm_sequencer #(add_txn);
  function new(string name, uvm_component parent); super.new(name, parent); endfunction
endclass

// 4. Driver：通过顶层信号驱动DUT（去掉interface，用信号直接连接）
class add_driver extends uvm_driver #(add_txn);
  // 声明与DUT连接的信号（在顶层模块中绑定）
  output logic [7:0] a;  // 驱动DUT的a
  output logic [7:0] b;  // 驱动DUT的b
  input  logic [8:0] sum; // 从DUT读取sum

  task run_phase();
    add_txn txn;
    forever begin
      sqr.get_next_item(txn);
      $display("[DRIVER] 驱动DUT: a=%0d, b=%0d", txn.a, txn.b);
      // 驱动DUT输入（Verilog中信号赋值需用非阻塞）
      a <= txn.a;
      b <= txn.b;
      // 等待DUT输出稳定（组合逻辑延迟）
      #5;
      // 检查结果
      if (sum == txn.exp_sum) begin
        $display("[DRIVER] 结果正确: 实际sum=%0d, 预期sum=%0d", sum, txn.exp_sum);
      end else begin
        $error("[DRIVER] 结果错误! 实际sum=%0d, 预期sum=%0d", sum, txn.exp_sum);
      end
      sqr.item_done();
    end
  endtask
endclass

// 5. 环境顶层：组装组件（无需interface，直接关联信号）
class add_env extends uvm_component;
  add_sqr sqr;
  add_driver drv;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    sqr = new("sqr", this);
    drv = new("drv", this);
    drv.sqr = sqr; // 绑定sequencer
  endfunction

  task run_phase();
    add_seq seq = new();
    fork
      drv.run_phase();
      seq.start(sqr);
    join
  endtask
endclass

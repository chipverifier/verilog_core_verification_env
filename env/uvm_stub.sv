// uvm_stub.sv：适配Icarus Verilog的极简UVM核心
virtual class uvm_object;
  function new(string name=""); endfunction
endclass

class uvm_transaction extends uvm_object;
  function new(string name=""); super.new(name); endfunction
endclass

virtual class uvm_component extends uvm_object;
  string name;
  function new(string name, uvm_component parent=null);
    super.new(name);
    this.name = name;
  endfunction
endclass

class uvm_sequencer #(type REQ=uvm_transaction) extends uvm_component;
  mailbox req_mb = new(); // 修正：去掉#(REQ)，Icarus对参数化mailbox支持有限
  function new(string name, uvm_component parent); super.new(name, parent); endfunction
  task get_next_item(output REQ req); req_mb.get(req); endtask
  function void item_done(); endfunction
endclass

virtual class uvm_driver #(type REQ=uvm_transaction) extends uvm_component;
  uvm_sequencer #(REQ) sqr;
  function new(string name, uvm_component parent); super.new(name, parent); endfunction
  virtual task run_phase(); endtask
endclass

class uvm_sequence #(type REQ=uvm_transaction) extends uvm_object;
  uvm_sequencer #(REQ) sqr;
  function new(string name=""); super.new(name); endfunction
  task start(uvm_sequencer #(REQ) s);
    sqr = s;
    body();
  endtask
  virtual task body(); endtask
  task start_item(REQ req); endtask
  task finish_item(REQ req); sqr.req_mb.put(req); endtask
endclass

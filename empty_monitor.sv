//  Class: empty_monitor
//
class empty_monitor extends uvm_monitor;
  `uvm_component_utils(empty_monitor)

  //  Group: Components
  virtual empty_if vif;

  //  Group: Variables
  protected uvm_active_passive_enum is_active = UVM_ACTIVE;
  uvm_analysis_port #(empty_tx) mon_analysis_port;

  //  Group: Functions
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("START_PHASE", $sformatf("Starting build_phase for %s", 
              get_full_name()), UVM_NONE)
    
    uvm_config_db#(uvm_active_passive_enum)::get(this,"","is_active",is_active);

   assert(uvm_config_db#(virtual empty_if)::get(this, "", "vif", vif))
   else
     `uvm_fatal("MON_IF", $sformatf("Error to get vif for %s", get_full_name()))
      
    mon_analysis_port = new("mon_analysis_port", this);

    `uvm_info("END_PHASE", $sformatf("Finishing build_phase for %s", 
             get_full_name()), UVM_NONE)    
  endfunction: build_phase
  
  
    task run_phase(uvm_phase phase);
    //empty_tx item;
    super.run_phase(phase);
    `uvm_info("START_PHASE", $sformatf("Starting run_phase for %s", 
              get_full_name()), UVM_NONE)

    if (is_active == UVM_ACTIVE)
      active_mon();
    else
      passive_mon();
    
    //forever begin
    //  @ (posedge vif.clk);
    //  item = new();
    //  item.var0     = vif.var0;

    //  mon_analysis_port.write(item);
    //end

    `uvm_info("END_PHASE", $sformatf("Finishing run_phase for %s", 
              get_full_name()), UVM_NONE)
  endtask: run_phase
  
  task active_mon();
    empty_tx item;
    forever begin
      @(posedge vif.clk);
      if(vif.valid_ip == 1'b1) begin
        item = new();
        item.data_ip_1 <= vif.data_ip_1;
        item.data_ip_2 <= vif.data_ip_2;
        $cast (item.sel_ip, vif.sel_ip);
        mon_analysis_port.write(item);
      end
    end
  endtask : active_mon
  
  task passive_mon();
    empty_tx item;
    forever begin
      @(posedge vif.clk);
      if (vif.valid_op == 1'b1) begin
        item = new();
        item.data_op <= vif.data_op;
        mon_analysis_port.write(item);
      end
    end
  endtask : passive_mon
        



  //  Constructor: new
  function new(string name = "empty_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction: new

endclass: empty_monitor





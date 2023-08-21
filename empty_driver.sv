//  Class: empty_driver
//
class empty_driver extends uvm_driver #(empty_tx);
  `uvm_component_utils(empty_driver)

  //  Group: Components
  virtual empty_if vif;

  //  Group: Variables
  protected uvm_active_passive_enum is_active = UVM_ACTIVE;

  //  Group: Functions
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("START_PHASE", $sformatf("Starting build_phase for %s", 
              get_full_name()), UVM_NONE)  

    assert(uvm_config_db#(virtual empty_if)::get(this, "", "vif", vif))
    uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active);
    
    //else
    //  `uvm_fatal("DRV_IF", $sformatf("Error to get vif for %s", get_full_name)) 

    `uvm_info("END_PHASE", $sformatf("Finishing build_phase for %s", 
              get_full_name()), UVM_NONE)    
  endfunction: build_phase
      
 task initial_rst();
 	vif.rst <= 1'b1;
    vif.data_ip_1 <= 'b0;
    vif.data_ip_2 <= 'b0;
    vif.sel_ip <= 'b0;
    vif.valid_ip <= 'b0;
    @ (posedge vif.clk);
    vif.rst <=1'b0;
 endtask : initial_rst
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("START_PHASE", $sformatf("Starting run_phase for %s", 
              get_full_name()), UVM_NONE)

    if (is_active == UVM_ACTIVE) begin
      initial_rst();
    	forever begin
      		empty_tx m_item;
      		seq_item_port.get_next_item(m_item);
	        drive_item_active(m_item);
			seq_item_port.item_done();
        end
      end else begin
        forever begin
          drive_item_passive();
        end
      end
    `uvm_info("END_PHASE", $sformatf("Finishing run_phase for %s", 
              get_full_name()), UVM_NONE)
  endtask: run_phase

  task drive_item_active(empty_tx m_item);
    @ (posedge vif.clk);
    vif.data_ip_1 <= m_item.data_ip_1;
    vif.data_ip_2 <= m_item.data_ip_2;
    vif.sel_ip <= m_item.sel_ip;
    vif.valid_ip <= 1'b1;
    
    while(vif.ready_op == 1'b0)
      @(posedge vif.clk);
    
    @(posedge vif.clk);
    vif.valid_ip <= 1'b0;
  endtask : drive_item_active
      
   task drive_item_passive();
      @(posedge vif.clk);
      vif.ready_ip <= 1'b0;
        
      while (vif.valid_op == 0)
        @(posedge vif.clk);
        
        vif.ready_ip <= 1'b1;
      endtask : drive_item_passive

  //  Constructor: new
  function new(string name = "empty_driver", uvm_component parent);
    super.new(name, parent);
  endfunction: new

endclass: empty_driver





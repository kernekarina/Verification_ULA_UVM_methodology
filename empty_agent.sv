//  Class: empty_agent
//
class empty_agent extends uvm_agent;
  `uvm_component_utils(empty_agent)

  //  Group: Components
  empty_sequencer   m_seqr;  
  empty_driver      m_drv;
  empty_monitor     m_mon;  

  //  Group: Variables
  
  protected uvm_active_passive_enum is_active = UVM_ACTIVE;

  //  Group: Functions
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("START_PHASE", $sformatf("Starting build_phase for %s", 
              get_full_name()), UVM_NONE)
    
    uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active",       is_active);
    
    if (is_active == UVM_ACTIVE)
	    m_seqr  = empty_sequencer ::type_id::create("m_seqr", this);
    	m_drv   = empty_driver    ::type_id::create("m_drv" , this);
    	m_mon   = empty_monitor   ::type_id::create("m_mon" , this);
    
    uvm_config_db#(uvm_active_passive_enum)::set(this,"m_drv", "is_active", is_active);
    uvm_config_db#(uvm_active_passive_enum)::set(this,"m_mon", "is_active", is_active);
    

    `uvm_info("END_PHASE", $sformatf("Finishing build_phase for %s", 
              get_full_name()), UVM_NONE)
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("START_PHASE", $sformatf("Starting connect_phase for %s", 
              get_full_name()), UVM_NONE)
    
    if(is_active == UVM_ACTIVE)
      m_drv.seq_item_port.connect(m_seqr.seq_item_export);
    
    `uvm_info("END_PHASE", $sformatf("Finishing connect_phase for %s", 
              get_full_name()), UVM_NONE)
  endfunction: connect_phase

  //  Constructor: new
  function new(string name = "empty_agent", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
endclass: empty_agent




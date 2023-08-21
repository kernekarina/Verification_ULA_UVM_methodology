//  Class: empty_env
//
class empty_env extends uvm_env;
  `uvm_component_utils(empty_env)

  //  Group: Components
  empty_agent alu_agt_inputs;
  empty_agent alu_agt_outputs;

  //  Group: Variables

  //  Group: Functions
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("START_PHASE", $sformatf("Starting build_phase for %s", 
              get_full_name()), UVM_NONE)  
    alu_agt_inputs = empty_agent::type_id::create("alu_agt_inputs", this);
    alu_agt_outputs = empty_agent::type_id::create("alu_agt_outputs", this);
    
    //Set active/passive to agents
    uvm_config_db#(uvm_active_passive_enum)::set(this,"alu_agt_inputs","is_active", UVM_ACTIVE);
    uvm_config_db#(uvm_active_passive_enum)::set(this,"alu_agt_outputs","is_active", UVM_PASSIVE);

    `uvm_info("END_PHASE", $sformatf("Finishing build_phase for %s", 
              get_full_name()), UVM_NONE)        
  endfunction: build_phase
  
  //  Constructor: new
  function new(string name = "empty_env", uvm_component parent);
    super.new(name, parent);
  endfunction: new

  
endclass: empty_env




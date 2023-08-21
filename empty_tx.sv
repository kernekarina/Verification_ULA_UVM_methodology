//declaração do tipo sel_t

typedef enum bit [(`SEL_WIDTH -1) :0]{
	ALU_ADD = 'b000,
  	ALU_SUB = 'b001,
  	ALU_MULT = 'b010,
  	ALU_LSH = 'b011,
  	ALU_RSH = 'b100,
  	ALU_INCR = 'b101,
  	ALU_DECR = 'b110
  
} sel_t;

//  Class: empty_tx
//
class empty_tx extends uvm_sequence_item;

  //  Group: Variables
  //rand bit [7:0] var0;
  
  //Inputs
  rand bit [(`DATA_WIDTH - 1): 0] data_ip_1;
  rand bit [(`DATA_WIDTH -1): 0] data_ip_2;
  rand sel_t					sel_ip;
  
  //Outputs
	bit [(`DATA_WIDTH*2 -1): 0] data_op;

  //  Group: Constraints
  
  `uvm_object_utils_begin(empty_tx)
    `uvm_field_int    (       data_ip_1  , UVM_DEFAULT|UVM_DEC  )
  	`uvm_field_int    (       data_ip_2  , UVM_DEFAULT|UVM_DEC  )
  	`uvm_field_enum   (sel_t, sel_ip     , UVM_DEFAULT			)
  	`uvm_field_int    (       data_op  	 , UVM_DEFAULT|UVM_DEC  )
  `uvm_object_utils_end
  
  //constraint c_var1 {
  //  var0 inside {[3 : 5]};
  //}
  
  constraint c_data_1{
    data_ip_1 inside {[0:(2**`DATA_WIDTH)-1]};
  }
  
  constraint c_data_2{
    data_ip_2 inside {[0:(2**`DATA_WIDTH)-1]};
  
  //Constrain SUB
    if (sel_ip == ALU_SUB)
    data_ip_2 <= data_ip_1;
  
  //Constrains SHFT
    if (sel_ip == ALU_RSH | sel_ip == ALU_LSH)
    data_ip_2 <= `DATA_WIDTH;
  
  //Constrains DEC/INC
    if (sel_ip == ALU_INCR | sel_ip == ALU_DECR)
    data_ip_2 inside {0,1};
  }
    

  //  Group: Functions
  function void print_2;
    `uvm_info("PRINT_ITEM", $sformatf("%p", this), UVM_LOW)
  endfunction : print_2

  //  Constructor: new
  function new(string name = "empty_tx");
    super.new(name);
  endfunction: new
  
endclass: empty_tx


//  Package: empty_pkg
//
package empty_pkg;
  `include "uvm_macros.svh"
  import uvm_pkg::*;

   `define DATA_WIDTH 8
   `define SEL_WIDTH 3

  //`include "empty_if.sv"

  `include "empty_tx.sv"
  `include "empty_seq.sv"
  `include "empty_sequencer.sv"
  `include "empty_driver.sv"
  `include "empty_monitor.sv"
  `include "empty_agent.sv"
  `include "empty_env.sv"
  `include "empty_test.sv"

endpackage : empty_pkg

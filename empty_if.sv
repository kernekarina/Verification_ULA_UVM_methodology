`ifndef empty_if__sv
`define empty_if__sv

interface empty_if #(
	parameter DATA_WIDTH = 8,
  	parameter SEL_WIDTH =3
)(
  input clk
);
  logic         				rst;
  logic 						valid_ip, ready_ip;
  logic [(DATA_WIDTH-1):0]		data_ip_1, data_ip_2;
  logic [(SEL_WIDTH-1):0]		sel_ip;
  logic							valid_op, ready_op;
  logic [((DATA_WIDTH*2)-1):0]	data_op;
  
  
endinterface : empty_if

`endif




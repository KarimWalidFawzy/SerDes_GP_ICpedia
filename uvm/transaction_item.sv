package seq_item ;
import uvm_pkg::*;
`include "uvm_macros.svh"
import enums::*;
class transaction extends uvm_sequence_item ;
          

  rand data_symbol input_data;
  rand bit tx_data_k;
  bit rx_data_k;
  bit [9:0] encoded_data;
data_symbol output_data;

`uvm_object_utils (transaction)


    
function new (string name = "transaction");
    super.new(name);
  endfunction : new
  // Constraints go here
  constraint tx_data_k_const{ 
 tx_data_k dist {1:=10 ,0:=90};
   
  }

  // Constructor - required syntax for UVM automation and utilities


endclass
endpackage
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------

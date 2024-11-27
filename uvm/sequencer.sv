package sequencer;
import uvm_pkg::*;
`include "uvm_macros.svh"
import seq_item ::*;
class enc_dec_sequencer extends uvm_sequencer #(transaction);
    `uvm_component_utils(enc_dec_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass 
endpackage
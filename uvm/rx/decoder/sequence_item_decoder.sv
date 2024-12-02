package sequence_item_decoder;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import enums::*;
    
    class sequence_item_decoder extends uvm_sequence_item ;
        `uvm_object_utils (sequence_item_decoder)
         rand bit [9:0]RxParallel_10  ;
         bit [7:0] RxParallel_8 ;
        bit RxDataK;

        
        function new (string name = "sequence_item_decoder");
            super.new(name);
        endfunction : new


    endclass
endpackage
package sequence_item_encoder;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import enums::*;
    
    class sequence_item_encoder extends uvm_sequence_item ;
        `uvm_object_utils (sequence_item_encoder)
        rand data_symbol input_data;
        rand bit TxDataK;
        bit output_data [7:0];




        //***************************//
        // TODO: Define Signals Here //
        //***************************//

        function new (string name = "sequence_item_encoder");
            super.new(name);
        endfunction : new
  constraint tx_data_k_const {
    TxDataK dist {1:=15 ,0:=85};
        }
   

        //*******************************//
        // TODO: Define Constraints Here //
        //*******************************//

        //*******************************//
        // TODO: Define Covergroups Here //
        //*******************************//

    endclass
endpackage
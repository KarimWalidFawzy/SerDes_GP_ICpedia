package sequence_item_encoder;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import enums::*;
    
    class sequence_item_encoder extends uvm_sequence_item ;
        `uvm_object_utils (sequence_item_encoder)
        rand data_symbol input_data;
        rand bit TxDataK;
        bit[9:0] output_data ;




        //***************************//
        // TODO: Define Signals Here //
        //***************************//

        function new (string name = "sequence_item_encoder");
            super.new(name);
        endfunction : new
  constraint tx_data_k_const {
    TxDataK dist {1:=15 ,0:=85};
        }
        //add constraint for control data with tx data k
        constraint input_data_temp_constraint {
            input_data inside {S_0_0,S_0_1,S_0_2,S_1_3,S_2_3,S_1_0,S_3_3};  
        }
   

        //*******************************//
        // TODO: Define Constraints Here //
        //*******************************//

        //*******************************//
        // TODO: Define Covergroups Here //
        //*******************************//

    endclass
endpackage
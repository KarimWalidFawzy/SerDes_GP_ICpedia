package sequence_item_sipo;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import enums::*;
    
    class sequence_item_sipo extends uvm_sequence_item ;
        `uvm_object_utils (sequence_item_sipo)

        rand bit [5:0] upper_6;
        rand bit [3:0] lower_4;
        bit [9:0] serial_in;
        bit [9:0] parallel_out;

        function new (string name = "sequence_item_sipo");
            super.new(name);
        endfunction : new

        constraint running_zeros_ones {
            upper_6 inside {5, 6, 7, 9, 10, 11, 12, 13, 14, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 49, 50, 51, 52, 53, 54, 56, 57, 58};
            if (upper_6 == 11 || upper_6 == 19 || upper_6 == 35 || upper_6 == 52 || upper_6 == 44 || upper_6 == 28)
                lower_4 inside {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};
            else
                lower_4 inside {1, 2, 3, 4, 5, 6, 9, 10, 11, 12, 13, 14};
        }

        function void post_randomize();
            serial_in = {upper_6, lower_4};
        endfunction

        //*******************************//
        // TODO: Define Covergroups Here //
        //*******************************//

    endclass
endpackage
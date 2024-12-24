package sequence_item_decoder;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import enums::*;
    
    class sequence_item_decoder extends uvm_sequence_item ;
        `uvm_object_utils (sequence_item_decoder)
        bit[7:0] RxParallel_8;
        rand bit [5:0] RxParallel_6 ;
        rand bit [3:0]  RxParallel_4 ;
        bit[9:0] RxParallel_10;
        
        bit RxDataK;
        /*constraint include_ {
            RxParallel_6  inside {3, 5, 6, 7, 9, 10, 11, 12, 13, 14, 17, 18, 19,
                                  20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 33,
                                  34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45,
                                  46, 49, 50, 51, 52, 53, 54, 56, 57, 58, 60}; 
        
            if (RxParallel_6 == 23 || RxParallel_6 == 27 || RxParallel_6 == 29 || RxParallel_6 == 30)
                !(RxParallel_4 inside{0,14,15}); // D.23, K.23, D.27, K.27, D.29, K.29, D.30, K.30 (+1 disparity)
            else if (RxParallel_6 == 40 || RxParallel_6 == 36 || RxParallel_6 == 34 || RxParallel_6 == 33)
                !(RxParallel_4 inside{0,1,15}); // D.23, K.23, D.27, K.27, D.29, K.29, D.30, K.30 (-1 disparity)
            else if (RxParallel_6 == 11 || RxParallel_6 == 13 || RxParallel_6 == 14 || RxParallel_6 == 49 || RxParallel_6 == 50 || RxParallel_6 == 52)
                !(RxParallel_4 inside{0,7,8,15}); // D.X.A7
            else if (RxParallel_6 == 3)
                !(RxParallel_4 inside{0,1,2,4,7,8,12,15}); // K.28.y (+1 disparity)
            else if (RxParallel_6 == 60)
                !(RxParallel_4 inside{0,3,7,8,11,13,14,15}); // K.28.y (-1 disparity)
            else
                !(RxParallel_4 inside{0,1,14,15}); // D.X
        };*/

        function void  post_randomize ();
            RxParallel_10={RxParallel_4,RxParallel_6};
        endfunction
        
        function new (string name = "sequence_item_decoder");
            super.new(name);
        endfunction : new

    endclass
endpackage
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
  constraint include_ {
    RxParallel_6  inside {3, 5, 6, 7, 9, 10, 11, 12, 13, 14, 17, 18, 19,
     20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 33, 34, 35, 36, 37, 38, 39, 40, 
     41, 42, 43, 44, 45, 46, 49, 50, 51, 52, 53, 54, 56, 57, 58, 60}; 
      ! ( RxParallel_4  inside{0,15}) ;
      if (RxParallel_6 == 11 || RxParallel_6 == 13 || RxParallel_6 == 14 || RxParallel_6 == 49 || RxParallel_6 == 50 ||RxParallel_6==52 )
      ! ( RxParallel_4  inside{7,8}) ;
      if (RxParallel_6 !=6'b110001  && RxParallel_6!=6'b110010 && RxParallel_6!=6'b110100 &&RxParallel_6 [5:0]!=6'b001011  && RxParallel_6 [5:0]!=6'b001101 && RxParallel_6[5:0] !=6'b001110) begin //should add k.28 k.27 k23 k.29 l.30 and should make it inside instead of if
        ! ( RxParallel_4  inside{4'b1110,4'b0001}) ;
      end
    
     
  };

 function void  post_randomize ();
    RxParallel_10={RxParallel_4,RxParallel_6};
 endfunction
        
        function new (string name = "sequence_item_decoder");
            super.new(name);
        endfunction : new


    endclass
endpackage
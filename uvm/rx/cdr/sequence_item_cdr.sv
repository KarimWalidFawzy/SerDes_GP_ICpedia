package sequence_item_cdr;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    // import enums::*;
    
    class sequence_item_cdr extends uvm_sequence_item ;
        `uvm_object_utils (sequence_item_cdr)

        //***************************//
        // TODO: Define Signals Here //
        //***************************//
         
        rand bit Reset;           
        rand bit Dn_1,Pn,Dn; 
        
        bit [8:0] phase_shift; 

        function new (string name = "sequence_item_cdr");
            super.new(name);
        endfunction : new

        //*******************************//
        // TODO: Define Constraints Here //
        //*******************************//
        constraint reset_inactive_mostly {
            Reset dist {0 := 2, 1 := 98}; 
        }

        constraint valid_input_range {
            !(Dn_1 == 1 && Pn == 0 && Dn == 1); 
            !(Dn_1 == 0 && Pn == 1 && Dn == 0); 
        }
        //*******************************//
        // TODO: Define Covergroups Here //
        //*******************************//
        covergroup cg_CDR ;

            coverpoint Reset {
                bins active = {1}; 
                bins inactive = {0}; 
            }

            coverpoint Dn_1 {
                bins high_ = {1}; 
                bins low_ = {0}; 
            }
            
            coverpoint Pn {
                bins high_ = {1}; 
                bins low_  = {0}; 
            }

            coverpoint Dn {
                bins high_ = {1}; 
                bins low_  = {0};            
            }

            cross Dn_1,Pn,Dn;
            
        endgroup

        function string convert2string();
            return $sformatf("Dn_1 = 0b%0b, Pn = 0b%0b, Dn = 0b%0b,phase_shift=0b%08b, Reset = 0b%0b",
                Dn_1,Pn,Dn,phase_shift, Reset);
        endfunction

        function string convert2string_stimulus();
            return $sformatf("Dn_1 = 0b%0b, Pn = 0b%0b, Dn = 0b%0b, Reset = 0b%0b", Dn_1,Pn,Dn, Reset);
        endfunction 
    endclass
endpackage
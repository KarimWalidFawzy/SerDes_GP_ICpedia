package sequence_item_cdr;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    // import enums::*;
    
    class sequence_item_cdr extends uvm_sequence_item ;
        `uvm_object_utils (sequence_item_cdr)

        //***************************//
        // TODO: Define Signals Here //
        //***************************//
         
        // Inputs 
        rand bit Reset;          
        rand bit Serial;         
        rand bit data_clock;     
        rand bit phase_clock;   
        rand bit recovered_clock; 

        // Outputs 
        bit [8:0] phase_shift;  

        // Internal
        bit Dn_1;                
        bit Dn;                 
        bit Pn;
        bit [1:0] decision;    
        bit [1:0] gainsel;                  

        // function new(string name = "sequence_item_CDR");
        //     super.new(name);
        // endfunction : new
        //*******************************//
        // TODO: Define Constraints Here //
        //*******************************//
        constraint Reset_c {
            Reset dist {0 := 98, 1 := 2};
            } 
        constraint Serial_c { 
            Serial dist {0 := 50, 1 := 50}; 
            } 
        constraint Clocks_c { 
            data_clock != phase_clock; 
            } 
        constraint decision_c { 
            decision inside {2'b00, 2'b01, 2'b11}; 
            }
        constraint gainsel_c { 
            gainsel inside {2'b00, 2'b01, 2'b10, 2'b11}; 
            } 
        //*******************************//
        // Define Covergroups Here       //
        //*******************************//

        // Covergroup for phase shift output
        covergroup phase_shift_cg;
            option.per_instance = 1;
            coverpoint phase_shift {
                bins low = {[0:127]};
                bins mid = {[128:383]};
                bins high = {[384:511]};
            }
        endgroup

        // Covergroup for input signals
        covergroup input_signals_cg;
            option.per_instance = 1;
            coverpoint Reset;
            coverpoint Serial;
            coverpoint data_clock;
            coverpoint phase_clock;
            coverpoint recovered_clock;
        endgroup

        covergroup internal_signals_cg;
            option.per_instance = 1;
            coverpoint decision {
                bins aligned = {2'b00}; 
                bins late    = {2'b01};
                bins early   = {2'b11};
            }
            coverpoint gainsel {
                bins gain_00 = {2'b00};
                bins gain_01 = {2'b01}; 
                bins gain_10 = {2'b10}; 
                bins gain_11 = {2'b11}; 
            }
        endgroup

        
        function new(string name = "sequence_item_CDR");
            super.new(name);
            phase_shift_cg = new();
            input_signals_cg = new();
            internal_signals_cg = new();
        endfunction 

        
        function void sample();
            phase_shift_cg.sample();
            input_signals_cg.sample();
            internal_signals_cg.sample();
        endfunction 

        //*******************************//
        // Utility Functions             //
        //*******************************//

        // Convert object to string for logging (includes all signals)
        function string convert2string();
            return $sformatf(
                "Reset = 0b%0b, Serial = 0b%0b, data_clock = 0b%0b, phase_clock = 0b%0b, recovered_clock = 0b%0b, " +
                "Dn_1 = 0b%0b, Pn = 0b%0b, Dn = 0b%0b, decision = 0b%0b, gainsel = 0b%0b, phase_shift = 0b%08b",
                Reset, Serial, data_clock, phase_clock, recovered_clock,
                Dn_1, Pn, Dn, decision, gainsel, phase_shift
            );
        endfunction

        // Convert stimulus to string for logging (includes all input signals)
        function string convert2string_stimulus();
            return $sformatf(
                "Reset = 0b%0b, Serial = 0b%0b, data_clock = 0b%0b, phase_clock = 0b%0b, recovered_clock = 0b%0b, " +
                "Dn_1 = 0b%0b, Pn = 0b%0b, Dn = 0b%0b, decision = 0b%0b, gainsel = 0b%0b",
                Reset, Serial, data_clock, phase_clock, recovered_clock,
                Dn_1, Pn, Dn, decision, gainsel
            );
        endfunction
    endclass
endpackage
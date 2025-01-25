interface CDR_if ();
    // Inputs 
    logic Reset;               
    logic Serial;              
    logic data_clock;          
    logic phase_clock;          
    logic recovered_clock;     
    
    // Outputs
    logic [8:0] phase_shift;    
    logic [1:0] decision1 ;// Expose decision signal
    // Modport
    modport DUT (
        input Reset, Serial, data_clock, phase_clock, recovered_clock, 
        output phase_shift                                             
    );
endinterface
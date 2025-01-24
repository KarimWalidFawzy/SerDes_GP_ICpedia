interface cdr_if (BitCLK);
    input BitCLK;
    bit Reset;
    logic Dn_1;
    logic Pn;
    logic Dn;

    //logic decision;
    logic signed [8:0] phase_shift;
    
    modport DUT (
        input BitCLK, Reset, Dn_1,Pn,Dn,
        output phase_shift
        //, decision
    );

endinterface
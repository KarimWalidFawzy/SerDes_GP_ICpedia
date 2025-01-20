module sampler_tb ();

    // Inputs to the DUT (Device Under Test)
    reg Serial;
    reg data_clock, phase_clock;
    reg Reset;
    
    // Outputs from the DUT
    wire Dn_1, Pn, Dn;
    
    // Instantiate the DUT
    sampler dut (
        .Reset(Reset),
        .data_clock(data_clock),
        .phase_clock(phase_clock),
        .Serial(Serial),
        .Dn_1(Dn_1),
        .Pn(Pn),
        .Dn(Dn)
    );
    
    always #10 data_clock = ~data_clock;

    initial begin
        data_clock = 0;
        phase_clock = 0;
        #5
        forever #10 phase_clock = ~phase_clock;
    end

    initial begin
        Reset = 0;
        #10
        Reset = 1;
        Serial = 0;
        #5 Serial = 1;  // Set Serial to 1 after 10ns
        #20 Serial = 0;  // Set Serial to 0 after 20ns
        #30 Serial = 1;  // Set Serial to 1 after 30ns
        #40 Serial = 0;  // Set Serial to 0 after 40ns
        #50 Serial = 1;  // Set Serial to 1 after 50ns
        #60 Serial = 0;  // Set Serial to 0 after 60ns
        #70 Serial = 1;  // Set Serial to 1 after 70ns
        $stop();
    end
endmodule
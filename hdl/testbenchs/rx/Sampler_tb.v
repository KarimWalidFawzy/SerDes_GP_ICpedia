module Sampler_tb ();
  // Inputs to the DUT (Device Under Test)
  reg Serial;
  reg clk1, clk2, clk3, clk4;
  
  // Outputs from the DUT
  wire Dn_1, Pn, Dn;
  
  // Instantiate the DUT
  Sampler dut (
      .Serial(Serial),
      .clk1(clk1),
      .clk2(clk2),
      .clk3(clk3),
      .clk4(clk4),
      .Dn_1(Dn_1),
      .Pn(Pn),
      .Dn(Dn)
  );
  always #5 clk1 = ~clk1 ;
  always #5 clk2 = ~clk2 ;
  always #5 clk3 = ~clk3 ;
  always #5 clk4 = ~clk4 ;
  initial begin
    clk1 = 0;
    #5
    clk3 = 0;
    #5
    clk2 = 0;
    clk4 = 0;
  end
  initial begin
    Serial = 0;
    #10 Serial = 1;  // Set Serial to 1 after 10ns
    #20 Serial = 0;  // Set Serial to 0 after 20ns
    #30 Serial = 1;  // Set Serial to 1 after 30ns
    #40 Serial = 0;  // Set Serial to 0 after 40ns
    #50 Serial = 1;  // Set Serial to 1 after 50ns
    #60 Serial = 0;  // Set Serial to 0 after 60ns
    #70 Serial = 1;  // Set Serial to 1 after 70ns
    $stop();
  end
endmodule
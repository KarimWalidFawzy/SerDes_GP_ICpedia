module phase_detector_tb();
reg Dn_1;
reg Pn;
reg Dn;
wire[1:0] decision;

BBPD dut(
	.Dn_1(Dn_1),
	.Pn(Pn),
	.Dn(Dn),
	.decision(decision)
	);
initial begin
  // early
	Dn_1 = 0; Pn = 0; Dn = 1; #10;
  Dn_1 = 1; Pn = 1; Dn = 0; #10;
  //late
  Dn_1 = 0; Pn = 1; Dn = 1; #10;
  Dn_1 = 1; Pn = 0; Dn = 0; #10;
  //no decision
  Dn_1 = 0; Pn = 0; Dn = 0; #10;
  Dn_1 = 0; Pn = 1; Dn = 0; #10;
  Dn_1 = 1; Pn = 0; Dn = 1; #10;
  Dn_1 = 1; Pn = 1; Dn = 1; #10;
	$stop();
end
endmodule
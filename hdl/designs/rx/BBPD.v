module BBPD (
    input wire Dn_1,          // Previous data sample
    input wire Pn,            // Phase sample
    input wire Dn,            // Current data sample
    output reg [1:0] decision // Decision output: 2 bits to represent {early, late}
	);
wire early , late ;
assign early = Dn ^ Pn; 
assign late = Pn ^ Dn_1; 
// represent the output in 2 bits   
always @(*) begin
	if (early && !late) begin
		decision = 2'b11;               
	end
	else if (late && !early) begin
		decision = 2'b01;
	end
	else begin
		decision = 2'b00;
	end
end
endmodule
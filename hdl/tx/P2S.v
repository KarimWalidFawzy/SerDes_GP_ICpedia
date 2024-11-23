module PISO(
    input wire[9:0] parallel_in,
    input wire clk,
    input wire reset_n,
    output reg serial_out
    );
reg[9:0] temp_reg;
reg [3:0] bit_count;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)begin
        temp_reg<=10'b0;
        serial_out<=0;
        bit_count<=0;
    end 
    else begin
        if (bit_count == 0) begin
        temp_reg<=parallel_in; 
        bit_count<=9;  
        end
        else begin
        serial_out<=temp_reg[9];
        temp_reg<={temp_reg[8:0],0};
        bit_count<=bit_count-1;
        end
    end
end

endmodule
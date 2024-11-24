module PISO(
  input wire[9:0] TxParallel_10,
  input wire BitCLK,
  input wire Reset,
  output reg Serial
  );
reg[9:0] temp_reg;  //temp_reg to hold the input parallel data
reg [3:0] bit_count; 
//shifting the input bits to serialize them 
always @(posedge BitCLK or negedge Reset) begin
  if(!Reset)begin
      temp_reg<=10'b0;
      Serial<=0;
  end 
  else begin
      if (bit_count == 0) begin
      temp_reg<=TxParallel_10; 
      Serial<=TxParallel_10[0]; //this done to not stop a clk cycle loading the inputs as we need to load and transit at the same cycle (this done for the first bit (LSB))
      end
      else begin
        Serial<=temp_reg[1]; // this is done because we took the first bit (LSB) in the previous clk cycle
      temp_reg<=temp_reg>>1;
      end
  end
end
//couter to keep track the number of input bits
always @(posedge BitCLK or negedge Reset) begin
  if(!Reset)begin
      bit_count<=0;
  end 
  else begin
      if (bit_count == 0) begin
      bit_count<=9;  
      end
      else begin
      bit_count<=bit_count-1;
      end
  end
end

endmodule
module loop_filter(
    input signed [1:0]  input_signal,
    input clk,
    input reset,
    input [1:0] gainsel,
    output reg signed [8:0]  output_signal);
    wire signed [14:0]   FIIP;
    reg signed [5:0]  temp ;
    assign temp=input_signal;
    assign FIIP = (gainsel==2'b00)? (input_signal):
                  (gainsel==2'b01)? (input_signal<<1):
                  (gainsel==2'b10)? (input_signal<<2):(input_signal) ;
    reg signed [14:0] FIREGS;
    reg signed [14:0] PIREGS;

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            PIREGS<=0;
            FIREGS<=0;
        end
      else begin FIREGS<=FIREGS+FIIP;        
        PIREGS<=FIREGS[14:6]+PIREGS+(temp<<3); end
    end
    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            output_signal <= 0;
        end
        else output_signal <= PIREGS[14:6];
    end
   
endmodule
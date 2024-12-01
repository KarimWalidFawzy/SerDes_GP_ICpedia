module SIPO(
    input BitCLK,
    input Reset,
    output reg [9:0] RxParallel_10,
    input Serial
);
    reg [9:0] shift_reg; // 10-bit shift register
    reg [3:0] count; // 4-bit counter
    wire comma;
     
    assign comma = (shift_reg == 124) || (shift_reg == 380) || (shift_reg == 387) || (shift_reg == 636) || (shift_reg == 643) || (shift_reg == 899);

    always @(posedge BitCLK or negedge Reset) begin
        if (!Reset) begin
            shift_reg <= 10'b0; // Reset the shift register
        end else begin
            shift_reg <= {Serial, shift_reg[9:1]};
        end
    end

    always @(posedge BitCLK, negedge Reset) begin
        if (!Reset) begin
            count <= 0; // Reset the counter
        end else begin
            if (comma) begin
                count <= 4'b0001;                
            end else if (count == 4'b1001) begin
                count <= 4'b0000; // Reset the counter after reaching 9
            end else begin
                count <= count + 1; // Increment the counter
            end
        end
    end

    always @(posedge BitCLK, negedge Reset) begin
        if (!Reset) begin
            RxParallel_10 <= 0;
        end else begin
            if (count == 0) begin
                RxParallel_10 <= shift_reg;
            end
        end
    end

endmodule

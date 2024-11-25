module decoder (
    input BitCLK_10,
    input Reset,
    input [9:0] TxParallel_10,
    input TxDataK,
    output [7:0] TxParallel_8
);

reg disparity;
reg [4:0] TxParallel_5;
reg [2:0] TxParallel_3;

assign TxParallel_8 = {TxParallel_3, TxParallel_5};

always @(posedge BitCLK_10, negedge Reset) begin
    if (!Reset) begin
        TxParallel_5 = 0;
    end else begin
        TxParallel_5 = 0;
        case (TxParallel_10[9:4])
            6'h5: TxParallel_5 = 5'h17;
            6'h6: TxParallel_5 = 5'h8;
            6'h7: TxParallel_5 = 5'h7;
            6'h9: TxParallel_5 = 5'h1B;
            6'hA: TxParallel_5 = 5'h4;
            6'hB: TxParallel_5 = 5'h14;
            6'hC: TxParallel_5 = 5'h18;
            6'hD: TxParallel_5 = 5'hC;
            6'hE: TxParallel_5 = 5'h1C;
            6'hF: TxParallel_5 = 5'h1C;
            6'h11: TxParallel_5 = 5'h1D;
            6'h12: TxParallel_5 = 5'h2;
            6'h13: TxParallel_5 = 5'h12;
            6'h14: TxParallel_5 = 5'h1F;
            6'h15: TxParallel_5 = 5'hA;
            6'h16: TxParallel_5 = 5'h1A;
            6'h17: TxParallel_5 = 5'hF;
            6'h18: TxParallel_5 = 5'h0;
            6'h19: TxParallel_5 = 5'h6;
            6'h1A: TxParallel_5 = 5'h16;
            6'h1B: TxParallel_5 = 5'h10;
            6'h1C: TxParallel_5 = 5'hE;
            6'h1D: TxParallel_5 = 5'h1;
            6'h1E: TxParallel_5 = 5'h1E;
            6'h21: TxParallel_5 = 5'h1E;
            6'h22: TxParallel_5 = 5'h1;
            6'h23: TxParallel_5 = 5'h11;
            6'h24: TxParallel_5 = 5'h10;
            6'h25: TxParallel_5 = 5'h9;
            6'h26: TxParallel_5 = 5'h19;
            6'h27: TxParallel_5 = 5'h0;
            6'h28: TxParallel_5 = 5'hF;
            6'h29: TxParallel_5 = 5'h5;
            6'h2A: TxParallel_5 = 5'h15;
            6'h2B: TxParallel_5 = 5'h1F;
            6'h2C: TxParallel_5 = 5'hD;
            6'h2D: TxParallel_5 = 5'h2;
            6'h2E: TxParallel_5 = 5'h1D;
            6'h30: TxParallel_5 = 5'h1C;
            6'h31: TxParallel_5 = 5'h3;
            6'h32: TxParallel_5 = 5'h13;
            6'h33: TxParallel_5 = 5'h18;
            6'h34: TxParallel_5 = 5'hB;
            6'h35: TxParallel_5 = 5'h4;
            6'h36: TxParallel_5 = 5'h1B;
            6'h38: TxParallel_5 = 5'h7;
            6'h39: TxParallel_5 = 5'h8;
            6'h3A: TxParallel_5 = 5'h17;
            default: TxParallel_5 = 0;
        endcase
    end
end

always @(posedge BitCLK_10, negedge Reset) begin
    if (!Reset) begin
        TxParallel_3 = 0;
    end else begin
        TxParallel_3 = 0;
        case (TxParallel_10[3:0])
            4'h1: TxParallel_3 = 3'h7;
            4'h2: TxParallel_3 = 3'h4;
            4'h3: TxParallel_3 = 3'h3;
            4'h4: TxParallel_3 = 3'h0;
            4'h5: TxParallel_3 = 3'h2;
            4'h6: TxParallel_3 = 3'h6;
            4'h7: TxParallel_3 = 3'h7;
            4'h8: TxParallel_3 = 3'h7;
            4'h9: TxParallel_3 = 3'h1;
            4'hA: TxParallel_3 = 3'h5;
            4'hB: TxParallel_3 = 3'h0;
            4'hC: TxParallel_3 = 3'h3;
            4'hD: TxParallel_3 = 3'h4;
            4'hE: TxParallel_3 = 3'h7;
            default: TxParallel_3 = 0;
        endcase
    end
end

endmodule
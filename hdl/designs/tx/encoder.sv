module encoder (
    input BitCLK_10,
    input Reset,
    input TxDataK,
    input [7:0] TxParallel_8,
    output reg [9:0] TxParallel_10
);

reg disparity;
reg [5:0] TxParallel_6;
reg [3:0] TxParallel_4;

always @(posedge BitCLK_10 or negedge Reset) begin
    if(!Reset) begin
        TxParallel_10 <= 0;
    end else begin
        TxParallel_10 <= {TxParallel_4, TxParallel_6};
    end
end

always @(*) begin
    TxParallel_6 = 0;
    if (disparity) begin
        case (TxParallel_8[4:0])
            5'h00: TxParallel_6 = 6'h06;
            5'h01: TxParallel_6 = 6'h11;
            5'h02: TxParallel_6 = 6'h12;
            5'h03: TxParallel_6 = 6'h23;
            5'h04: TxParallel_6 = 6'h14;
            5'h05: TxParallel_6 = 6'h25;
            5'h06: TxParallel_6 = 6'h26;
            5'h07: TxParallel_6 = 6'h38;
            5'h08: TxParallel_6 = 6'h18;
            5'h09: TxParallel_6 = 6'h29;
            5'h0A: TxParallel_6 = 6'h2A;
            5'h0B: TxParallel_6 = 6'h0B;
            5'h0C: TxParallel_6 = 6'h2C;
            5'h0D: TxParallel_6 = 6'h0D;
            5'h0E: TxParallel_6 = 6'h0E;
            5'h0F: TxParallel_6 = 6'h05;
            5'h10: TxParallel_6 = 6'h09;
            5'h11: TxParallel_6 = 6'h31;
            5'h12: TxParallel_6 = 6'h32;
            5'h13: TxParallel_6 = 6'h13;
            5'h14: TxParallel_6 = 6'h34;
            5'h15: TxParallel_6 = 6'h15;
            5'h16: TxParallel_6 = 6'h16;
            5'h17: TxParallel_6 = 6'h28;
            5'h18: TxParallel_6 = 6'h0C;
            5'h19: TxParallel_6 = 6'h19;
            5'h1A: TxParallel_6 = 6'h1A;
            5'h1B: TxParallel_6 = 6'h24;
            5'h1C: begin
                if (TxDataK)
                    TxParallel_6 = 6'h03;
                else
                    TxParallel_6 = 6'h1C;
            end
            5'h1D: TxParallel_6 = 6'h22;
            5'h1E: TxParallel_6 = 6'h21;
            5'h1F: TxParallel_6 = 6'h0A;
            default: TxParallel_6 = 0;
        endcase
    end else begin
        case (TxParallel_8[4:0])
            5'h00: TxParallel_6 = 6'h39;
            5'h01: TxParallel_6 = 6'h2E;
            5'h02: TxParallel_6 = 6'h2D;
            5'h03: TxParallel_6 = 6'h23;
            5'h04: TxParallel_6 = 6'h2B;
            5'h05: TxParallel_6 = 6'h25;
            5'h06: TxParallel_6 = 6'h26;
            5'h07: TxParallel_6 = 6'h07;
            5'h08: TxParallel_6 = 6'h27;
            5'h09: TxParallel_6 = 6'h29;
            5'h0A: TxParallel_6 = 6'h2A;
            5'h0B: TxParallel_6 = 6'h0B;
            5'h0C: TxParallel_6 = 6'h2C;
            5'h0D: TxParallel_6 = 6'h0D;
            5'h0E: TxParallel_6 = 6'h0E;
            5'h0F: TxParallel_6 = 6'h3A;
            5'h10: TxParallel_6 = 6'h36;
            5'h11: TxParallel_6 = 6'h31;
            5'h12: TxParallel_6 = 6'h32;
            5'h13: TxParallel_6 = 6'h13;
            5'h14: TxParallel_6 = 6'h34;
            5'h15: TxParallel_6 = 6'h15;
            5'h16: TxParallel_6 = 6'h16;
            5'h17: TxParallel_6 = 6'h17;
            5'h18: TxParallel_6 = 6'h33;
            5'h19: TxParallel_6 = 6'h19;
            5'h1A: TxParallel_6 = 6'h1A;
            5'h1B: TxParallel_6 = 6'h1B;
            5'h1C: begin
                if (TxDataK)
                    TxParallel_6 = 6'h3C;
                else
                    TxParallel_6 = 6'h1C;
            end
            5'h1D: TxParallel_6 = 6'h1D;
            5'h1E: TxParallel_6 = 6'h1E;
            5'h1F: TxParallel_6 = 6'h35;
            default: TxParallel_6 = 0;
        endcase
    end
end

always @(*) begin
    TxParallel_4 = 0;
    if (TxDataK) begin
        if (disparity) begin
            case (TxParallel_8[7:5])
                3'h0: TxParallel_4 = 4'hD;
                3'h1: TxParallel_4 = 4'h6;
                3'h2: TxParallel_4 = 4'h5;
                3'h3: TxParallel_4 = 4'h3;
                3'h4: TxParallel_4 = 4'hB;
                3'h5: TxParallel_4 = 4'hA;
                3'h6: TxParallel_4 = 4'h9;
                3'h7: TxParallel_4 = 4'hE;
                default: TxParallel_4 = 0;
            endcase
        end else begin
            case (TxParallel_8[7:5])
                3'h0: TxParallel_4 = 4'h2;
                3'h1: TxParallel_4 = 4'h9;
                3'h2: TxParallel_4 = 4'hA;
                3'h3: TxParallel_4 = 4'hC;
                3'h4: TxParallel_4 = 4'h4;
                3'h5: TxParallel_4 = 4'h5;
                3'h6: TxParallel_4 = 4'h6;
                3'h7: TxParallel_4 = 4'h1;
                default: TxParallel_4 = 0;
            endcase
        end
    end else begin
        if ((^TxParallel_6) ^ disparity) begin
            case (TxParallel_8[7:5])
                3'h0: TxParallel_4 = 4'hD;
                3'h1: TxParallel_4 = 4'h9;
                3'h2: TxParallel_4 = 4'hA;
                3'h3: TxParallel_4 = 4'h3;
                3'h4: TxParallel_4 = 4'hB;
                3'h5: TxParallel_4 = 4'h5;
                3'h6: TxParallel_4 = 4'h6;
                3'h7: begin
                    if (TxParallel_8[4:0] == 17 || TxParallel_8[4:0] == 18 || TxParallel_8[4:0] == 20)
                        TxParallel_4 = 4'hE;
                    else
                        TxParallel_4 = 4'h7;
                end
                default: TxParallel_4 = 0;
            endcase
        end else begin
            case (TxParallel_8[7:5])
                3'h0: TxParallel_4 = 4'h2;
                3'h1: TxParallel_4 = 4'h9;
                3'h2: TxParallel_4 = 4'hA;
                3'h3: TxParallel_4 = 4'hC;
                3'h4: TxParallel_4 = 4'h4;
                3'h5: TxParallel_4 = 4'h5;
                3'h6: TxParallel_4 = 4'h6;
                3'h7: begin
                    if (TxParallel_8[4:0] == 11 || TxParallel_8[4:0] == 13 || TxParallel_8[4:0] == 14)
                        TxParallel_4 = 4'h1; 
                    else
                        TxParallel_4 = 4'h8;
                end
                default: TxParallel_4 = 0;
            endcase
        end
    end
end
    
always @(posedge BitCLK_10, negedge Reset) begin
    if (!Reset) begin
        disparity <= 0;
    end else begin
        if (!((^TxParallel_6) ^ (^TxParallel_4))) begin
            disparity <= disparity + 1;
        end
    end

end

endmodule
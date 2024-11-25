module decoder_tb ();
    
    reg BitCLK_10, Reset, TxDataK;
    reg [9:0] TxParallel_10;
    wire [7:0] TxParallel_8;

    decoder decoder(.BitCLK_10(BitCLK_10), .Reset(Reset), .TxDataK(TxDataK), .TxParallel_8(TxParallel_8), .TxParallel_10(TxParallel_10));

    always #5 BitCLK_10 = ~BitCLK_10;

    initial begin
        BitCLK_10 = 0;
        Reset = 0;
        TxParallel_10 = 0;
        TxDataK = 0;
        #20
        Reset = 1;
        #10
        TxParallel_10 = 10'b0001100010; //D.8.4
        #10
        TxParallel_10 = 10'b1110000101; //D.7.2
        #10
        TxParallel_10 = 10'b1011001000; //D.13.7
        #10
        TxParallel_10 = 10'b0010110111; //D.20.7
        #10
        TxParallel_10 = 10'b0100011000; //K.29.7
        #10

        $stop();
    end

endmodule
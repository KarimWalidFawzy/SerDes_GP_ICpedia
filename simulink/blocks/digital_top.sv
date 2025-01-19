module digital_top (
    input BitCLK,
    input BitCLK_10,
    input Reset,
    input TxDataK_in,
    input [7:0] TxParallel_8_in,
    input [9:0] TxParallel_10_in, RxParallel_10_in,
    input Serial_in,
    output Serial_out,
    output [9:0] TxParallel_10_out, RxParallel_10_out,
    output RxDataK_out,
    output [7:0] RxParallel_8_out
);
    
    encoder encoder(.BitCLK_10(BitCLK_10), .Reset(Reset), .TxParallel_8(TxParallel_8_in), .TxDataK(TxDataK_in), .TxParallel_10(TxParallel_10_out));
    PISO PISO(.BitCLK(BitCLK), .Reset(Reset), .Serial(Serial_out), .TxParallel_10(TxParallel_10_in));
    SIPO SIPO(.BitCLK(BitCLK), .Reset(Reset), .Serial(Serial_in), .RxParallel_10(RxParallel_10_out));
    decoder decoder(.BitCLK_10(BitCLK_10), .Reset(Reset), .RxParallel_10(RxParallel_10_in), .RxDataK(RxDataK_out), .RxParallel_8(RxParallel_8_out));

endmodule

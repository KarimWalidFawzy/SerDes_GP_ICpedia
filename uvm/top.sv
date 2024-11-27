import uvm_pkg::*;
`include "uvm_macros.svh"
import test::*;
module top();

    bit BitCLK_10_Tx, BitCLK_10_Rx, BitCLK;

    initial begin
        BitCLK_10_Rx = 0;
        #3;
        forever begin
            #10 BitCLK_10_Rx = ~BitCLK_10_Rx;
        end
    end
    initial begin
        forever begin
            #10 BitCLK_10_Tx = ~BitCLK_10_Tx;
        end
    end
    initial begin
        forever begin
            #1 BitCLK = ~BitCLK;
        end
    end

    // reg [7:0] TxParallel_8_i, RxParallel_8_i;

    top_if top_if (BitCLK, BitCLK_10_Tx, BitCLK_10_Rx);

    // assign TxParallel_8_i = top_if.TxParallel_8;
    // assign top_if.RxParallel_8 = RxParallel_8_i;
    // initial begin
        // $cast(TxParallel_8_i, top_if.TxParallel_8);
        // $cast(top_if.RxParallel_8, RxParallel_8_i);
        // TxParallel_8_i = top_if.TxParallel_8;
        // top_if.RxParallel_8 = RxParallel_8_i;
    // end
    
    top_module top_module (
        .BitCLK(BitCLK),
        .BitCLK_10_Tx(BitCLK_10_Tx),
        .BitCLK_10_Rx(BitCLK_10_Rx),
        .Reset(top_if.Reset),
        .TxDataK(top_if.TxDataK),
        .TxParallel_8(top_if.TxParallel_8[7:0]),
        .RxDataK(top_if.RxDataK),
        .RxParallel_8(top_if.RxParallel_8[7:0])
    );

    initial begin
        uvm_config_db #(virtual top_if)::set(null, "*", "TOP_IF", top_if);
        run_test("enc_dec_test");
    end

endmodule
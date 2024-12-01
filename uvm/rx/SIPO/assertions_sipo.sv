module assertions_sipo (sipo_if.DUT _if);
    
    bit [9:0] serial_in;

    initial begin
        forever begin
            @(posedge _if.BitCLK)
            serial_in = {_if.Serial, serial_in[9:1]};            
        end
    end

    sequence comma_detect;
        (serial_in == 124 || serial_in == 380 || serial_in == 387 || serial_in == 636 || serial_in == 643 || serial_in == 899);
    endsequence

    sequence output_aligned;
        $past(_if.RxParallel_10) != _if.RxParallel_10;
    endsequence

    comma_check_assert: assert property(@(posedge _if.BitCLK) comma_detect |-> ##11 output_aligned);

    comma_check_cover: cover property(@(posedge _if.BitCLK) comma_detect |-> ##11 output_aligned);

endmodule
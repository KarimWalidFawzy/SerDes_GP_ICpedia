module loop_filter_tb;

    // Inputs
    reg [5:0] input_signal;
    reg clk;
    reg reset;
    reg [1:0] gainsel;

    // Outputs
    wire [8:0] output_signal;

    // Instantiate the loop_filter module
    loop_filter uut (
        .input_signal(input_signal),
        .clk(clk),
        .reset(reset),
        .gainsel(gainsel),
        .output_signal(output_signal)
    );

    // Clock generation (50 MHz clock)
    always begin
        #10 clk = ~clk; // 50 MHz clock (20 ns period)
    end

    // Test stimulus
    initial begin
        // Initialize signals
        reset=0;
        clk = 0;
        input_signal = 2'b01; // input_signal = 1 (binary representation for +1)
        gainsel = 2'b01; // constant gainsel = 01
         #2; reset=1;
        // Monitor the output
        $monitor("Time = %0t, input_signal = %d, output_signal = %d", $time, input_signal, output_signal);

        // Apply stimulus: input_signal is 1 for a long time
        #1000 input_signal = 2'b11; // input_signal = -1 (binary representation for -1 in signed)

        // Finish the simulation after a period
        #1000 $finish;
    end

endmodule

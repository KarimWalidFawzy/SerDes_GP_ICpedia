module Sampler (
    input wire Serial,        // Input serial data
    input wire clk1,          // Clock for data sampling (stage 1, earlier clk)
    input wire clk2,          // Clock for data sampling (stage 2, late clk)
    input wire clk3,          // Clock for phase sampling (stage 1 ,earlier clk)
    input wire clk4,          // Clock for phase sampling (stage 2, late clk)
    output wire Dn_1,          // previous data sample
    output wire Dn,            // current data sample
    output wire Pn             // current phase sample
);

    // Internal signals
    reg data_sample1, data_sample2;
    reg phase_sample1, phase_sample2;

    // Data sampling
    always @(posedge clk1) begin
        data_sample1 <= Serial;
    end

    always @(posedge clk2) begin
        data_sample2 <= Serial;
    end

    // Phase sampling
    always @(posedge clk3) begin
        phase_sample1 <= Serial;
    end

    always @(posedge clk4) begin
        phase_sample2 <= Serial;
    end

    assign Dn_1 = data_sample1;
    assign Dn = data_sample2;
    assign Pn = phase_sample2;
endmodule

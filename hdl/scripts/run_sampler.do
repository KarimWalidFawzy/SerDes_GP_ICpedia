vlib work
vlog designs/rx/cdr/sampler.sv testbenchs/rx/cdr/sampler_tb.sv
vsim -voptargs=+acc work.sampler_tb
add wave *
run -all

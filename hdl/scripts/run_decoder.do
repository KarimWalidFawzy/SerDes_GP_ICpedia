vlib work
vlog designs/rx/decoder.sv testbenchs/rx/decoder_tb.sv
vsim -voptargs=+acc work.decoder_tb
add wave *
run -all

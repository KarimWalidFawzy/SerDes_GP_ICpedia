vlib work
vlog designs/tx/encoder.sv testbenchs/tx/encoder_tb.sv
vsim -voptargs=+acc work.encoder_tb
add wave *
run -all

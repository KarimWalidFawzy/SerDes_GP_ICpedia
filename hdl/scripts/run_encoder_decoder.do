vlib work
vlog designs/tx/encoder.sv designs/rx/decoder.sv testbenchs/encoder_decoder_tb.sv
vsim -voptargs=+acc work.encoder_decoder_tb
add wave *
run -all

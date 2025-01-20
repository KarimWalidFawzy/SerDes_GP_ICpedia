vlib work
vlog designs/rx/SIPO.sv testbenchs/rx/SIPO_tb.sv
vsim -voptargs=+acc work.SIPO_tb
add wave *
run -all

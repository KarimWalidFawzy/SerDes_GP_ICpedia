vlib work
vlog designs/tx/PISO.sv testbenchs/tx/PISO_tb.sv
vsim -voptargs=+acc work.PISO_tb
add wave *
run -all

vlib work
vlog designs/rx/cdr/loop_filter.sv testbenchs/rx/cdr/loop_filter_tb.sv
vsim -voptargs=+acc work.loop_filter_tb
add wave *
run -all

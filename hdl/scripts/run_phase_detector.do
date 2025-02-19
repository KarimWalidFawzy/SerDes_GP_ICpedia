vlib work
vlog designs/rx/cdr/phase_detector.sv testbenchs/rx/cdr/phase_detector_tb.sv
vsim -voptargs=+acc work.phase_detector_tb
add wave *
run -all

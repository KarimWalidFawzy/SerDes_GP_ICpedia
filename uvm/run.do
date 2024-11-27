
vlog -f runfiles.f +define+QUESTA \

vsim -voptargs=+acc work.top +UVM_TESTNAME=enc_dec_test +UVM_VERBOSITY=UVM_HIGH

add wave -position insertpoint \
sim:/top/top_if/* \

run -all
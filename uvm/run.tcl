
#Change this variable to one of the following values
#TOP ENCODER PISO SIPO DECODER
set design_block ENCODER

set design_block_if [string cat [string tolower $design_block] _if]
set path top
switch $design_block {
    ENCODER {
        set path tx/encoder
    }
    PISO {
        set path tx/piso
    }
    SIPO {
        set path rx/sipo
    }
    DECODER {
        set path rx/decoder
    }
}
vlog -f $path/runfiles.f +define+$design_block +cover\ 

vsim -voptargs=+acc work.top -cover -classdebug -sv_seed 50 +UVM_TESTNAME=test +UVM_VERBOSITY=UVM_HIGH 

add wave -position insertpoint \
sim:/top/$design_block_if/* \


coverage save top_tb_tb.ucdb -onexit -du encoder

run -all
coverage report -output functional_coverage_rpt.txt -srcfile=* -detail -all -dump -annotate -directive -cvg
quit -sim
vcover report top_tb_tb.ucdb -details -annotate -all -output code_coverage_rpt.txt

#you can add -option to functional coverage
#you can add -classdebug in vsim command to access the classes in waveform
#you can add -uvmcontrol=all  in vsim command in case uvm
#in windows to create sourcefile.txt use dir /b > sourcefile.txt


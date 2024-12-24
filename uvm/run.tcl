
#Change this variable to one of the following values
#TOP ENCODER PISO SIPO DECODER
set design_block DECODER

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
vlog -f $path/runfiles.f +define+$design_block +cover

vsim -voptargs=+acc -voptargs="+cover=bcefst" work.top -cover -classdebug +UVM_TESTNAME=test +UVM_VERBOSITY=UVM_HIGH -sv_seed 1

add wave /top/$design_block_if/*
switch $design_block {
    ENCODER {
        add wave /top/encoder/assertions_encoder_i/assert_five_consecutive_bits
        add wave /top/encoder/assertions_encoder_i/assert_disparity
        add wave /top/encoder/assertions_encoder_i/assert_five_consecutive_bits_cover
        add wave /top/encoder/assertions_encoder_i/assert_disparity_cover
    }
    SIPO {
        add wave /top/sipo/assertions_sipo_i/comma_check_assert
        add wave /top/sipo/assertions_sipo_i/comma_check_cover
    }
    DECODER {add wave /top/decoder/disparity 
            add wave  /top/decoder/ones 
            add wave  /top/decoder/zeros
    }
}

coverage save top_tb_tb.ucdb -onexit 

run -all

coverage report -output functional_coverage_report.txt -srcfile=* -detail -all -dump -annotate -directive -cvg
vcover report top_tb_tb.ucdb -details -annotate -html -output coverage_reports/$path

#you can add -option to functional coverage
#you can add -classdebug in vsim command to access the classes in waveform
#you can add -uvmcontrol=all  in vsim command in case uvm
#in windows to create sourcefile.txt use dir /b > sourcefile.txt


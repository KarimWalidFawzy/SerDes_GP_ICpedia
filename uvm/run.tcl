
#Change this variable to one of the following values
#TOP ENCODER PISO SIPO DECODER
set design_block SIPO

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

vlog -f $path/runfiles.f +define+$design_block \

vsim -voptargs=+acc work.top +UVM_TESTNAME=test +UVM_VERBOSITY=UVM_HIGH -sv_seed 1

add wave /top/$design_block_if/*
switch $design_block {
    SIPO {
        add wave /top/sipo/assertions_sipo_i/comma_check_assert
        add wave /top/sipo/assertions_sipo_i/comma_check_cover
    }
}

run -all
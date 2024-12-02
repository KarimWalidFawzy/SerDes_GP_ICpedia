package scoreboard_decoder;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item_decoder::*;

    class scoreboard_decoder extends uvm_scoreboard;
        `uvm_component_utils(scoreboard_decoder)
        
        int correct_count;
        int error_count;
        `uvm_analysis_imp_decl(_decoder)
        uvm_analysis_imp_decoder #(sequence_item_decoder, scoreboard_decoder) scoreboard_block;
        sequence_item_decoder decoder_q[$];

        function new(string name="", uvm_component parent = null);
            super.new(name, parent);
            scoreboard_block = new("scoreboard_block", this);
        endfunction

        virtual function void write_decoder(sequence_item_decoder packet);
            decoder_q.push_back(packet);
            //**************************//
            // TODO: Check Results Here //
            //**************************//
        endfunction 

        function void report_phase(uvm_phase phase);
            `uvm_info(get_type_name(), $sformatf("correct_count=%d while error count=%d",correct_count , error_count), UVM_LOW)
        endfunction

    endclass
endpackage
6b / 5b Decoding Table			
6 bits binary	5 bits binary	6 bits hex	5 bits hex
	03	1C
	05	0F
	06	00
	07	07
	09	10
	0A	1F
	0B	0B
	0C	18
	0D	0D
	0E	0E
	11	01
	12	02
	13	13
	14	04
	15	15
	16	16
	17	17
	18	08
	19	19
	1A	1A
	1B	1B
	1C	1C
	1D	1D
	1E	1E
	21	1E
	22	1D
	23	03
	24	1B
	25	05
	26	06
	27	08
	28	17
	29	09
	2A	0A
	2B	04
	2C	0C
	2D	02
	2E	01
	31	11
	32	12
	33	18
	34	14
	35	1F
	36	10
	38	07
	39	00
	3A	0F
	3C	1C

package scoreboard;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `ifdef TOP    
        import sequence_item_top::*;
    `elsif ENCODER
        import sequence_item_encoder::*;
    `elsif PISO
        import sequence_item_piso::*;
    `elsif SIPO
        import sequence_item_sipo::*;
    `elsif DECODER
        import sequence_item_decoder::*;
    `endif

    class scoreboard extends uvm_scoreboard;
        `uvm_component_utils(scoreboard)
        
        int correct_count;
        int error_count;
        `ifdef TOP    
            int enc_packets;
            int dec_packets;
            `uvm_analysis_imp_decl(_enc)
            `uvm_analysis_imp_decl(_dec)
            uvm_analysis_imp_enc #(sequence_item_top, scoreboard) scoreboard_top_in;
            uvm_analysis_imp_dec #(sequence_item_top, scoreboard) scoreboard_top_out;
            sequence_item_top enc_q[$];
            sequence_item_top dec_q[$];
        `elsif ENCODER
            int encoder_packets;
            `uvm_analysis_imp_decl(_encoder)
            uvm_analysis_imp_encoder #(sequence_item_encoder, scoreboard) scoreboard_block;
            sequence_item_encoder encoder_q[$];
        `elsif PISO
            int piso_packets;
            `uvm_analysis_imp_decl(_piso)
            uvm_analysis_imp_piso #(sequence_item_piso, scoreboard) scoreboard_block;
            sequence_item_piso piso_q[$];
        `elsif SIPO
            int sipo_packets;
            `uvm_analysis_imp_decl(_sipo)
            uvm_analysis_imp_sipo #(sequence_item_sipo, scoreboard) scoreboard_block;
            sequence_item_sipo sipo_q[$];
        `elsif DECODER
            int decoder_packets;
            `uvm_analysis_imp_decl(_decoder)
            uvm_analysis_imp_decoder #(sequence_item_decoder, scoreboard) scoreboard_block;
            sequence_item_decoder decoder_q[$];
        `endif

        function new(string name="", uvm_component parent = null);
            super.new(name, parent);
            `ifdef TOP    
                scoreboard_top_in = new("scoreboard_top_in", this);
                scoreboard_top_out = new("scoreboard_top_out", this);
            `else
                scoreboard_block = new("scoreboard_block", this);
            `endif
        endfunction

        `ifdef TOP    
            virtual function void write_enc(sequence_item_top packet);
                enc_q.push_back(packet);
                enc_packets++;
            endfunction 
            
            virtual function void write_dec( sequence_item_top packet);
                sequence_item_top enc_packet= enc_q.pop_front();
                if (packet.output_data == enc_packet.input_data) begin
                    `uvm_info(get_type_name(), $sformatf("test_passed_data =%d ",enc_packet.input_data ), UVM_LOW)
                    correct_count ++;
                end 
                else begin
                    `uvm_error(get_type_name(), $sformatf("test_failed_input_data =%d but output data=%d ",enc_packet.input_data.name ,packet.output_data.name))
                    error_count ++;
                end
                dec_packets++;
            endfunction
        `elsif ENCODER
            virtual function void write_encoder(sequence_item_encoder packet);
                encoder_q.push_back(packet);
                //**************************//
                // TODO: Check Results Here //
                //**************************//
                encoder_packets++;
            endfunction 
        `elsif PISO
            virtual function void write_piso(sequence_item_piso packet);
                piso_q.push_back(packet);
                //**************************//
                // TODO: Check Results Here //
                //**************************//
                piso_packets++;
            endfunction 
        `elsif SIPO
            virtual function void write_sipo(sequence_item_sipo packet);
                sipo_q.push_back(packet);
                //**************************//
                // TODO: Check Results Here //
                //**************************//
                sipo_packets++;
            endfunction 
        `elsif DECODER
            virtual function void write_decoder(sequence_item_decoder packet);
                decoder_q.push_back(packet);
                //**************************//
                // TODO: Check Results Here //
                //**************************//
                decoder_packets++;
            endfunction 
        `endif

        function void report_phase(uvm_phase phase);
            `uvm_info(get_type_name(), $sformatf("correct_count=%d while error count=%d",correct_count , error_count), UVM_LOW)
        endfunction

    endclass
endpackage
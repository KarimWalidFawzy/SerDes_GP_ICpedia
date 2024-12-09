package scoreboard_decoder;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item_decoder::*;
    import enums ::*;

    class scoreboard_decoder extends uvm_scoreboard;
        `uvm_component_utils(scoreboard_decoder)
        
        int correct_count;
        int error_count;
        `uvm_analysis_imp_decl(_decoder)
        uvm_analysis_imp_decoder #(sequence_item_decoder, scoreboard_decoder) scoreboard_block;
    

        function new(string name="", uvm_component parent = null);
            super.new(name, parent);
            scoreboard_block = new("scoreboard_block", this);
        endfunction

         function void write_decoder(sequence_item_decoder packet);
            
            bit RxDataK ;
            bit [7:0] decoded_data ;
        decode(packet.RxParallel_10,decoded_data,RxDataK);
        if (decoded_data != packet.RxParallel_8 || RxDataK !=packet.RxDataK) begin
            `uvm_error("msimatch", $sformatf("expected %b k %b output %b k %b @ input data %b  ", decoded_data,RxDataK,packet.RxParallel_8 ,packet.RxDataK ,packet.RxParallel_10 ));
            error_count++;
        end else begin
            correct_count++;
        end
        endfunction 
        task decode(
            input  bit [9:0] data_in,
            output bit [7:0] decoded_data,
            output bit RxDataK
          );
          bit [4:0] decoding_table_5 [6'h00:6'h3F];
          bit [2:0] decoding_table_3 [4'h0:4'hF];
          bit [7:0] decoding_table_k [10'h000	:10'h3FF];


          bit k_28_x;
          bit k_x_7_1;
          bit k_x_7_2;
          bit not_D_x_A7;

          decoding_table_5[6'h05] = 5'h0F;
          decoding_table_5[6'h06] = 5'h00;
          decoding_table_5[6'h07] = 5'h07;
          decoding_table_5[6'h09] = 5'h10;
          decoding_table_5[6'h0A] = 5'h1F;
          decoding_table_5[6'h0B] = 5'h0B;
          decoding_table_5[6'h0C] = 5'h18;
          decoding_table_5[6'h0D] = 5'h0D;
          decoding_table_5[6'h0E] = 5'h0E;
          decoding_table_5[6'h11] = 5'h01;
          decoding_table_5[6'h12] = 5'h02;
          decoding_table_5[6'h13] = 5'h13;
          decoding_table_5[6'h14] = 5'h04;
          decoding_table_5[6'h15] = 5'h15;
          decoding_table_5[6'h16] = 5'h16;
          decoding_table_5[6'h17] = 5'h17;
          decoding_table_5[6'h18] = 5'h08;
          decoding_table_5[6'h19] = 5'h19;
          decoding_table_5[6'h1A] = 5'h1A;
          decoding_table_5[6'h1B] = 5'h1B;
          decoding_table_5[6'h1C] = 5'h1C;
          decoding_table_5[6'h1D] = 5'h1D;
          decoding_table_5[6'h1E] = 5'h1E;
          decoding_table_5[6'h21] = 5'h1E;
          decoding_table_5[6'h22] = 5'h1D;
          decoding_table_5[6'h23] = 5'h03;
          decoding_table_5[6'h24] = 5'h1B;
          decoding_table_5[6'h25] = 5'h05;
          decoding_table_5[6'h26] = 5'h06;
          decoding_table_5[6'h27] = 5'h08;
          decoding_table_5[6'h28] = 5'h17;
          decoding_table_5[6'h29] = 5'h09;
          decoding_table_5[6'h2A] = 5'h0A;
          decoding_table_5[6'h2B] = 5'h04;
          decoding_table_5[6'h2C] = 5'h0C;
          decoding_table_5[6'h2D] = 5'h02;
          decoding_table_5[6'h2E] = 5'h01;
          decoding_table_5[6'h31] = 5'h11;
          decoding_table_5[6'h32] = 5'h12;
          decoding_table_5[6'h33] = 5'h18;
          decoding_table_5[6'h34] = 5'h14;
          decoding_table_5[6'h35] = 5'h1F;
          decoding_table_5[6'h36] = 5'h10;
          decoding_table_5[6'h38] = 5'h07;
          decoding_table_5[6'h39] = 5'h00;
          decoding_table_5[6'h3A] = 5'h0F;
          
          

          decoding_table_3[4'h1] = 3'h7;
          decoding_table_3[4'h2] = 3'h0;
          decoding_table_3[4'h3] = 3'h3;
          decoding_table_3[4'h4] = 3'h4;
          decoding_table_3[4'h5] = 3'h5;
          decoding_table_3[4'h6] = 3'h6;
          decoding_table_3[4'h7] = 3'h7;
          decoding_table_3[4'h8] = 3'h7;
          decoding_table_3[4'h9] = 3'h1;
          decoding_table_3[4'hA] = 3'h2;
          decoding_table_3[4'hB] = 3'h4;
          decoding_table_3[4'hC] = 3'h3;
          decoding_table_3[4'hD] = 3'h0;
          decoding_table_3[4'hE] = 3'h7;
         

          decoding_table_k[10'h0BC] = 8'h1C;
          decoding_table_k[10'h27C] = 8'h3C;
          decoding_table_k[10'h2BC] = 8'h5C;
          decoding_table_k[10'h33C] = 8'h7C;
          decoding_table_k[10'h13C] = 8'h9C;
          decoding_table_k[10'h17C] = 8'hBC;
          decoding_table_k[10'h1BC] = 8'hDC;
          decoding_table_k[10'h07C] = 8'hFC;
          decoding_table_k[10'h057] = 8'hF7;
          decoding_table_k[10'h05B] = 8'hFB;
          decoding_table_k[10'h05D] = 8'hFD;
          decoding_table_k[10'h05E] = 8'hFE;
          decoding_table_k[10'h343] = 8'h1C;
          decoding_table_k[10'h183] = 8'h3C;
          decoding_table_k[10'h143] = 8'h5C;
          decoding_table_k[10'h0C3] = 8'h7C;
          decoding_table_k[10'h2C3] = 8'h9C;
          decoding_table_k[10'h283] = 8'hBC;
          decoding_table_k[10'h243] = 8'hDC;
          decoding_table_k[10'h383] = 8'hFC;
          decoding_table_k[10'h3A8] = 8'hF7;
          decoding_table_k[10'h3A4] = 8'hFB;
          decoding_table_k[10'h3A2] = 8'hFD;
          decoding_table_k[10'h3A1] = 8'hFE;
        
            k_28_x = (data_in[5:0] == 6'b111100 || data_in[5:0] == 6'b000011 );
            k_x_7_1 = (data_in[9:6] == 4'b1110 && data_in[5:0] != 6'b110001 && data_in[5:0] != 6'b110010 && data_in[5:0] != 6'b110100);
            k_x_7_2 = (data_in[9:6] == 4'b0001 && data_in[5:0] != 6'b001011 && data_in[5:0] != 6'b001101 && data_in[5:0] != 6'b001110);

            if ( k_28_x || k_x_7_1 || k_x_7_2) begin // k.28.x or ( k.x.7 not k.x.A7) 
                decoded_data = decoding_table_k[data_in];
                RxDataK = 1;
            end else begin
                decoded_data[7:5] = decoding_table_3[data_in[9:6]];
                decoded_data[4:0] = decoding_table_5[data_in[5:0]];
                RxDataK = 0;
            end
          
          endtask
        
        

        function void report_phase(uvm_phase phase);
            `uvm_info(get_type_name(), $sformatf("correct_count = %0d while error count = %0d",correct_count , error_count), UVM_LOW)
        endfunction

    endclass
endpackage
 
package scoreboard_encoder;
    import enums::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item_encoder::*;

    class scoreboard_encoder extends uvm_scoreboard;
        `uvm_component_utils(scoreboard_encoder)
         
        int correct_count;
        int error_count;
        `uvm_analysis_imp_decl(_encoder)
        uvm_analysis_imp_encoder #(sequence_item_encoder, scoreboard_encoder) scoreboard_block;
        sequence_item_encoder encoder_q[$];
        bit [5:0]   encoding_table_data_positive_5_6_1    [  bit [4:0] ];
    

        function new(string name="", uvm_component parent = null);
            super.new(name, parent);
            scoreboard_block = new("scoreboard_block", this);
            
        endfunction

        virtual function void write_encoder(sequence_item_encoder packet);
           bit [9:0] encoded_out_2 ;
           if (packet.TxDataK) begin
            encode_8b10b_k(packet.input_data,encoded_out_2);
           end
            else encode_8b10b_data(packet.input_data,encoded_out_2);
            if (encoded_out_2 != (packet.output_data)) begin
              `uvm_error("msimatch", $sformatf("expected %b output %b @ input data %s K %b ", encoded_out_2, packet.output_data, packet.input_data,packet.TxDataK));
            end
     
        endfunction 


  // Task for 8b/10b encoding

     task  encode_8b10b_data(
    input  bit [7:0] data_in,
    output bit [9:0] encoded_out
  );
   int disparity = -1;
    int ones_count, zeros_count;
    int  ones_count_2 ,zeros_count_2;

     bit [5:0] encoding_table_6 [32][2] = '{ // RD=-1, RD=+1
      5'h00: '{6'b111001, 6'b000110},
      5'h01: '{6'b101110, 6'b010001},
      5'h02: '{6'b101101, 6'b010010},
      5'h03: '{6'b100011, 6'b100011},
      5'h04: '{6'b101011, 6'b010100},
      5'h05: '{6'b100101, 6'b100101},
      5'h06: '{6'b100110, 6'b100110},
      5'h07: '{6'b000111, 6'b111000},
      5'h08: '{6'b100111, 6'b011000},
      5'h09: '{6'b101001, 6'b101001},
      5'h0A: '{6'b101010, 6'b101010},
      5'h0B: '{6'b001011, 6'b001011},
      5'h0C: '{6'b101100, 6'b101100},
      5'h0D: '{6'b001101, 6'b001101},
      5'h0E: '{6'b001110, 6'b001110},
      5'h0F: '{6'b111010, 6'b000101},
      5'h10: '{6'b110110, 6'b001001},
      5'h11: '{6'b110001, 6'b110001},
      5'h12: '{6'b110010, 6'b110010},
      5'h13: '{6'b010011, 6'b010011},
      5'h14: '{6'b110100, 6'b110100},
      5'h15: '{6'b010101, 6'b010101},
      5'h16: '{6'b010110, 6'b010110},
      5'h17: '{6'b010111, 6'b101000},
      5'h18: '{6'b110011, 6'b001100},
      5'h19: '{6'b011001, 6'b011001},
      5'h1A: '{6'b011010, 6'b011010},
      5'h1B: '{6'b011011, 6'b100100},
      5'h1C: '{6'b011100, 6'b011100},
      5'h1D: '{6'b011101, 6'b100010},
      5'h1E: '{6'b011110, 6'b100001},
      5'h1F: '{6'b110101, 6'b001010}
    };
    bit [3:0] encoding_table_4 [8][2] = '{ // RD=-1, RD=+1
        3'd0: '{4'b1101, 4'b0010},
        3'd1: '{4'b1001, 4'b1001},
        3'd2: '{4'b1010, 4'b1010},
        3'd3: '{4'b0011, 4'b1100},
        3'd4: '{4'b1011, 4'b0100},
        3'd5: '{4'b0101, 4'b0101},
        3'd6: '{4'b0110, 4'b0110},
        3'd7: '{4'b0111, 4'b1000} // donot forget soecial case
      };
      
  
    // Check if the input exists in the table
    
    // Select encoding based on current disparity
    if (disparity == -1) begin

      encoded_out[5:0] = encoding_table_6[data_in[4:0]][0]; // RD = -1
    end else begin
      encoded_out[5:0] = encoding_table_6[data_in [4:0]][1]; // RD = +1
    end

    // Update disparity
    ones_count = $countones(  encoded_out[5:0] );       // Count number of 1's
    zeros_count = 6 - ones_count;              // Count number of 0's

    if (ones_count > zeros_count) begin
      disparity = 1; // More 1's → RD becomes +1
    end else if (zeros_count > ones_count) begin
      disparity = -1; // More 0's → RD becomes -1
    end
  


    // Select encoding based on current disparity
    if (disparity == -1) begin
      if (data_in[4:0]==17 ||data_in[4:0]==18 || data_in[4:0]==20) begin
        encoded_out[9:6] = 4'b1110;
      end
     else encoded_out[9:6] = encoding_table_4[data_in[7:5]][0]; // RD = -1
    end else begin
      if (data_in[4:0]==11 ||data_in[4:0]==13 || data_in[4:0]==14) begin
        encoded_out[9:6] = 4'b0001;
      end
      else encoded_out[9:6] = encoding_table_4[data_in[7:5]][1]; // RD = +1
    end

     ones_count_2 = $countones(encoded_out[9:6] );       // Count number of 1's
     zeros_count_2 = 4 - ones_count_2;        
    if (ones_count_2 > zeros_count_2) begin
        disparity = 1; // More 1's → RD becomes +1
      end else if (zeros_count_2> ones_count_2) begin
        disparity = -1; // More 0's → RD becomes -1
      end
  endtask
  task  encode_8b10b_k(
    input  bit [7:0] data_in,
    output bit [9:0] encoded_out
  );
   int disparity = -1;
    int ones_count, zeros_count;
    int  ones_count_2 ,zeros_count_2;

    bit [5:0] encoding_table_6 [5'h17:5'h1E] [2];  // Declare the associative array
   
    
    bit [3:0] encoding_table_4 [8][2] = '{ // RD=-1, RD=+1
        3'd0: '{4'b1101, 4'b0010},
        3'd1: '{4'b0110, 4'b1001},
        3'd2: '{4'b0101, 4'b1010},
        3'd3: '{4'b0011, 4'b1100},
        3'd4: '{4'b1011, 4'b0100},
        3'd5: '{4'b1010, 4'b0101},
        3'd6: '{4'b1001, 4'b0110},
        3'd7: '{4'b1110, 4'b0001}
      };
      
      encoding_table_6[5'h17] = '{6'b010111, 6'b101000};
      encoding_table_6[5'h1B] = '{6'b011011, 6'b100100};
      encoding_table_6[5'h1C] = '{6'b111100, 6'b000011};
      encoding_table_6[5'h1D] = '{6'b011101, 6'b100010};
      encoding_table_6[5'h1E] = '{6'b011110, 6'b100001};
    // Check if the input exists in the table
    
    // Select encoding based on current disparity
    if (disparity == -1) begin
      encoded_out[5:0] = encoding_table_6[data_in[4:0]][0]; // RD = -1
    end else begin
      encoded_out[5:0] = encoding_table_6[data_in [4:0]][1]; // RD = +1
    end

    // Update disparity
    ones_count = $countones(  encoded_out[5:0] );       // Count number of 1's
    zeros_count = 6 - ones_count;              // Count number of 0's

    if (ones_count > zeros_count) begin
      disparity = 1; // More 1's → RD becomes +1
    end else if (zeros_count > ones_count) begin
      disparity = -1; // More 0's → RD becomes -1
    end
  


    // Select encoding based on current disparity
    if (disparity == -1) begin
      
      encoded_out[9:6] = encoding_table_4[data_in[7:5]][0]; // RD = -1
    end else begin
      encoded_out[9:6] = encoding_table_4[data_in[7:5]][1]; // RD = +1
    end

     ones_count_2 = $countones(encoded_out[9:6] );       // Count number of 1's
     zeros_count_2 = 4 - ones_count_2;        
    if (ones_count_2 > zeros_count_2) begin
        disparity = 1; // More 1's → RD becomes +1
      end else if (zeros_count_2> ones_count_2) begin
        disparity = -1; // More 0's → RD becomes -1
      end
  endtask



        function void report_phase(uvm_phase phase);
            `uvm_info(get_type_name(), $sformatf("correct_count=%d while error count=%d",correct_count , error_count), UVM_LOW)
        endfunction

    endclass

endpackage
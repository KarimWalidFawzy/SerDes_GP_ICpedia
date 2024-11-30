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
            encode_8b10b_data(packet.input_data,encoded_out_2);
            if (encoded_out_2 != (packet.output_data)) begin
                $error("msimatch expected %b output %b @ input %s ",encoded_out_2 ,packet.output_data,packet.input_data);
            end
            //**************************//
            // TODO: Check Results Here //
            //**************************//
            
        endfunction 


  // Task for 8b/10b encoding
  task automatic encode_8b10b_data(
    input  bit [7:0] data_in,
    output bit [9:0] encoded_out
  );
  static int disparity = -1;
    int ones_count, zeros_count;
    int  ones_count_2 ,zeros_count_2;

     bit [5:0] encoding_table_6 [32][2] = '{ // RD=-1, RD=+1
      5'd0: '{6'b100111, 6'b011000},
      5'd1: '{6'b011101, 6'b100010}, // D.0
      5'd2: '{6'b101101, 6'b010010},
      5'd3: '{6'b110001, 6'b110001},
      5'd4: '{6'b110101, 6'b001010}
    };
    bit [3:0] encoding_table_4 [8][2] = '{ // RD=-1, RD=+1
        5'd0: '{4'b1011, 4'b0100},
        5'd1:'{4'b1001, 4'b1001}, // D.0
        5'd2:'{4'b0101, 4'b0101},
        5'd3: '{4'b1100, 4'b0011},
        5'd4: '{4'b1101, 4'b0010}
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
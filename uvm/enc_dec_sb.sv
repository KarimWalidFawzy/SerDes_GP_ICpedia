package scoreboard ;
import uvm_pkg::*;
`include "uvm_macros.svh"
import seq_item::*;
class enc_dec_scoreboard extends uvm_scoreboard;


  // component utils macro
  `uvm_component_utils(enc_dec_scoreboard)


  // define TLM port imp object
  
  `uvm_analysis_imp_decl(_enc)
  `uvm_analysis_imp_decl(_dec)


  uvm_analysis_imp_enc #(transaction, enc_dec_scoreboard) sb_enc;
  uvm_analysis_imp_dec #(transaction, enc_dec_scoreboard) sb_dec;

  transaction enc_q[$];
  transaction dec_q[$];

  function new(string name="", uvm_component parent=null);
    super.new(name, parent);
    sb_enc = new("sb_enc", this);
    sb_dec= new("sb_dec", this);
  endfunction
  
 int enc_packets ;
 int dec_packets;
 int correct_count;
 int error_count;


  // write() function for generator
  virtual function void write_enc(transaction packet);
    enc_q.push_back(packet);
   /* for (int i = 0; i <= 5; i++) begin
        // Extract a 5-bit slice from encoded_data
        bit [4:0] slice = packet.encoded_data[i +: 5]; // Extract 5 bits starting at index i

        // Check for all zeros or all ones
        if (slice == 5'b00000 || slice == 5'b11111) begin
            `uvm_error(get_type_name(), $sformatf("test_failed_consecutive_ones_or_Zeros ",packet.encoded_data))
            break;
        end
            */


   
    enc_packets++;
  endfunction 
  
  // write() function for detector
  virtual function void write_dec( transaction packet);
    transaction enc_packet= enc_q.pop_front();
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
  
  // UVM report() phase
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("correct_count=%d while error count=%d",correct_count , error_count), UVM_LOW)
  
  endfunction

endclass
endpackage
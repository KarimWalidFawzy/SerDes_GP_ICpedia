package scoreboard_cdr;

import uvm_pkg::*;
`include "uvm_macros.svh"
import sequence_item_cdr::*;

class scoreboard_cdr extends uvm_scoreboard;
  `uvm_component_utils(scoreboard_cdr)

  sequence_item_cdr pkt_item;
  int ref_out; // Reference model output
  int total_correct = 0; // Count of correct outputs
  int total_errors = 0; // Count of errors
  int phase_shift; // DUT phase shift signal

  // Analysis export and TLM FIFO for communication
  uvm_analysis_export #(sequence_item_cdr) scoreboard_block;
  uvm_tlm_analysis_fifo #(sequence_item_cdr) analysis_fifo;

  // Constructor
  function new(string name = "scoreboard_cdr", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scoreboard_block = new("scoreboard_block", this);
    analysis_fifo = new("analysis_fifo", this);
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    scoreboard_block.connect(analysis_fifo.analysis_export);
  endfunction

  // Run phase: Continuously process transactions
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      analysis_fifo.get(pkt_item); // Get a transaction from the FIFO
      check_data(pkt_item); // Check the data
    end
  endtask

  // Reference model: Generate the expected output
 task reference_model(sequence_item_cdr item);
    if (item.Reset) begin
      ref_out = 0; // Reset state
    end else begin
      if ( (item.Dn ^ item.Pn)&& !(item.Pn ^ item.Dn_1))
      begin
        case (item.gainsel)
          2'b00:ref_out=item.phase_shift-1;
          2'b01:ref_out=item.phase_shift-2;
          2'b11:ref_out=item.phase_shift-4;
          default: ref_out=item.phase_shift;
        endcase
      end
      else if (!(item.Dn ^ item.Pn)&& (item.Pn ^ item.Dn_1))
      begin
        case (item.gainsel)
          2'b00:ref_out=item.phase_shift+1;
          2'b01:ref_out=item.phase_shift+2;
          2'b11:ref_out=item.phase_shift+4;
          default: ref_out=item.phase_shift;
        endcase
      end
      else ref_out=phase_shift;
    end
endtask

  // Check model: Compare DUT output with reference model output
  task check_data(sequence_item_cdr item);
    // Generate the expected output
    reference_model(item);

    // Compare expected vs actual
    if (ref_out == item.phase_shift) begin
      total_correct++;
    end else begin
      total_errors++;
      $display("Design error @ %0t ns: Expected = 0x%0h, Received = 0x%0h",
               $time, ref_out, item.phase_shift);
    end
  endtask

  // Report phase: Summarize results
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("Scoreboard Summary", 
              $sformatf("Correct: %0d, Errors: %0d", total_correct, total_errors),
              UVM_LOW);
  endfunction

endclass

endpackage

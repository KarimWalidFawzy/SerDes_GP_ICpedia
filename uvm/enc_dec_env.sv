package env;
import uvm_pkg::*;
`include "uvm_macros.svh"
import scoreboard::*;
import agent::*;
class enc_dec_env extends uvm_env;

    
    enc_agent enc_agent_;
    dec_agent  dec_agent_;
    enc_dec_scoreboard enc_dec_sb;
  
    // Provide implementations of virtual methods such as get_type_name and create
    `uvm_component_utils(enc_dec_env)
  
    // Constructor - required syntax for UVM automation and utilities
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new
  
    // UVM build() phase
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      enc_agent_ = enc_agent::type_id::create("enc_agent_", this);
      dec_agent_ = dec_agent::type_id::create("dec_agent+", this);
      enc_dec_sb =enc_dec_scoreboard::type_id::create("enc_dec_sb",   this);

    endfunction : build_phase
    function void connect_phase(uvm_phase phase);
        // Connect the TLM ports from the UVCs to the scoreboard
        //registers.reg_agent.monitor.item_collected_port.connect(freq_adpt_sb.sb_registers_in);
     
        enc_agent_.monitor.item_collected_port.connect(enc_dec_sb.sb_enc);
        dec_agent_.monitor.item_collected_port.connect(enc_dec_sb.sb_dec);
      endfunction : connect_phase
    
  endclass 
endpackage
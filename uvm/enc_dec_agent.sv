
package agent;
import uvm_pkg::*;
`include "uvm_macros.svh"
import seq_item::*;

import driver::*;
import sequencer::*;
import monitor::*;
class enc_agent extends uvm_agent;

    enc_monitor monitor;
    enc_dec_sequencer sequencer;
    enc_driver driver;
    
    // Provide implementations of virtual methods such as get_type_name and create
      `uvm_component_utils(enc_agent)
    
  
  
    // Constructor - required syntax for UVM automation and utilities
    function new (string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new
  
    // UVM build() phase
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      monitor = enc_monitor::type_id::create("monitor", this);
     
        sequencer = enc_dec_sequencer::type_id::create("sequencer", this);
        driver = enc_driver::type_id::create("driver", this);
    
    endfunction
  
    function void start_of_simulation_phase(uvm_phase phase);
      `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH);
    endfunction : start_of_simulation_phase
  
    // UVM connect() phase
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
     
        // Binds the driver to the sequencer using consumer-producer interface
        driver.seq_item_port.connect(sequencer.seq_item_export);
      
    endfunction 
  
  endclass 
  class dec_agent extends uvm_agent;

    dec_monitor monitor;
  
    // Provide implementations of virtual methods such as get_type_name and create
      `uvm_component_utils(dec_agent)
    
  
  
    // Constructor - required syntax for UVM automation and utilities
    function new (string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new
  
    // UVM build() phase
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      monitor = dec_monitor::type_id::create("monitor", this);
     
  
    
    endfunction
  
    function void start_of_simulation_phase(uvm_phase phase);
      `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH);
    endfunction : start_of_simulation_phase
  
    // UVM connect() phase
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
    
      
    endfunction 
  
  endclass 
  
endpackage
  
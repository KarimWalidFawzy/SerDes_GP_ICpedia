
package driver ;
import uvm_pkg::*;
`include "uvm_macros.svh"
import seq_item ::*;
class enc_driver extends uvm_driver #(transaction);
  // virtual enc_if enc_vif ;
    virtual top_if vif ;

    `uvm_component_utils(enc_driver)
   
  
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
    function void connect_phase(uvm_phase phase);
      //  if (!uvm_config_db#(virtual enc_if)::get(this,"","enc_vif", enc_vif))
        //  `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
        if (!uvm_config_db#(virtual top_if )::get(this,"","TOP_IF", vif))
        `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
      endfunction: connect_phase
      

     task run_phase(uvm_phase phase);
        super.run_phase(phase);
        vif.Reset=0;
        @(negedge vif.BitCLK_10_Tx);
        vif.Reset=1;
        forever begin
            seq_item_port.get_next_item(req);
                drive_item(req);
            seq_item_port.item_done();	// No response provided
        end
    endtask : run_phase

    virtual task drive_item(transaction rhs);
        @(negedge vif.BitCLK_10_Tx);
        vif.TxDataK=rhs.tx_data_k;
        vif.TxParallel_8=rhs.input_data;

        
    endtask : drive_item

endclass : enc_driver
endpackage
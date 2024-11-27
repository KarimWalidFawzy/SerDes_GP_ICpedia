package monitor ;
import uvm_pkg::*;
`include "uvm_macros.svh"
import seq_item::*;
	class enc_monitor extends uvm_monitor;

		`uvm_component_utils(enc_monitor)
     
		virtual top_if  vif ;
		uvm_analysis_port #(transaction) item_collected_port;

		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction : new
        function void connect_phase(uvm_phase phase);
            if (!uvm_config_db#(virtual top_if)::get(this,"","TOP_IF", vif))
            `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
          endfunction: connect_phase

		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			item_collected_port = new("item_collected_port", this);
		endfunction : build_phase


		virtual task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				sample_item();
			end
		endtask : run_phase

		virtual task sample_item();
			transaction resp = transaction::type_id::create("resp");
            
			  @(posedge vif.BitCLK_10_Tx);
            //   resp.encoded_data=vif.TxParallel_10;
              resp.input_data = vif.TxParallel_8;
			  item_collected_port.write(resp);

            

		endtask : sample_item

	endclass 
	class dec_monitor extends uvm_monitor;

		`uvm_component_utils(dec_monitor)
     
		virtual top_if  vif ;
		uvm_analysis_port #(transaction) item_collected_port;

		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction : new
        function void connect_phase(uvm_phase phase);
            if (!uvm_config_db#(virtual top_if)::get(this,"","TOP_IF", vif))
            `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
          endfunction: connect_phase

		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			item_collected_port = new("item_collected_port", this);
		endfunction : build_phase


		virtual task run_phase(uvm_phase phase);
			super.run_phase(phase);
			repeat(2) @(posedge vif.BitCLK_10_Tx);
			forever begin

				sample_item();
			end
		endtask : run_phase

		virtual task sample_item();
			transaction resp = transaction::type_id::create("resp");
			@(posedge vif.BitCLK_10_Tx);
			 resp.output_data=vif.RxParallel_8;
			 resp.rx_data_k=vif.RxDataK;
			 `uvm_info(get_type_name(), $sformatf("before_Sending_to_sb =%d ",  resp.output_data), UVM_LOW)
			 item_collected_port.write(resp);
		endtask : sample_item

	endclass 
endpackage
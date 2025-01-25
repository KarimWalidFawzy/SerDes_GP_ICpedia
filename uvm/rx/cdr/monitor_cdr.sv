package monitor_cdr;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import sequence_item_cdr::*;

	class monitor_cdr extends uvm_monitor;
		`uvm_component_utils(monitor_cdr)

		virtual cdr_if  vif;
		uvm_analysis_port #(sequence_item_cdr) item_collected_port;

		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction : new

        function void connect_phase(uvm_phase phase);
            if (!uvm_config_db#(virtual cdr_if)::get(this,"","cdr_if", vif))
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
			sequence_item_cdr resp = sequence_item_cdr::type_id::create("resp");            
			@(posedge vif.BitCLK);
            //***************************//
            // TODO: Sample Outputs Here //
            //***************************//
			// example: resp.signal = vif.signal
			resp.Reset = vif.Reset;         
            resp.Serial = vif.Serial;      
            resp.data_clock = vif.data_clock; 
            resp.phase_clock = vif.phase_clock;
            resp.recovered_clock = vif.recovered_clock; 
            resp.phase_shift = vif.phase_shift; 
            resp.Dn_1 = vif.Dn_1;         
            resp.Dn = vif.Dn;            
            resp.Pn = vif.Pn;              
            resp.decision = vif.decision;  
            resp.gainsel = vif.gainsel;     
			// resp.decision1 = vif.decision1; // Sample decision signal
			if (vif.Dn ^ vif.Pn) begin
					resp.decision = 2'b11; // Early
				end else if (vif.Pn ^ vif.Dn_1) begin
					resp.decision = 2'b01; // Late
				end else begin
					resp.decision = 2'b00; // Aligned
				end
	        item_collected_port.write(resp);
			
		endtask

	endclass 
endpackage
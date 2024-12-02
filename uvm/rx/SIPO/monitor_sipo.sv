package monitor_sipo;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import sequence_item_sipo::*;

	class monitor_sipo extends uvm_monitor;
		`uvm_component_utils(monitor_sipo)

		virtual sipo_if  vif;
		uvm_analysis_port #(sequence_item_sipo) item_collected_port;

		function new(string name, uvm_component parent);
			super.new(name, parent);
		endfunction : new

        function void connect_phase(uvm_phase phase);
            if (!uvm_config_db#(virtual sipo_if)::get(this,"","sipo_if", vif))
	            `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
		endfunction: connect_phase

		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			item_collected_port = new("item_collected_port", this);
		endfunction : build_phase

		virtual task run_phase(uvm_phase phase);
			bit [11:0] serial_in = 0;
			super.run_phase(phase);
			repeat(10) begin
				detect_comma();
			end
			repeat (2) begin
				@(posedge vif.BitCLK);
				serial_in = {vif.Serial, serial_in[11:1]};
			end
			forever begin
				for (int i = 0; i < 10; i++) begin
					@(posedge vif.BitCLK);
					serial_in = {vif.Serial, serial_in[11:1]};
				end
				sample_item(serial_in[9:0]);
			end
		endtask : run_phase

		virtual task sample_item(bit [9:0] serial_in);
			sequence_item_sipo resp = sequence_item_sipo::type_id::create("resp");
			resp.serial_in = serial_in;
            resp.parallel_out = vif.RxParallel_10;
			item_collected_port.write(resp);
		endtask : sample_item

		virtual task detect_comma();
			logic [9:0] last_10_bits = 10'bX;
			forever begin
				@(posedge vif.BitCLK);
				last_10_bits = {vif.Serial, last_10_bits[9:1]};
				if (last_10_bits == 124 || last_10_bits == 380 || last_10_bits == 387 || last_10_bits == 636 || last_10_bits == 643 || last_10_bits == 899)
					break;
			end
			`uvm_info(get_type_name(), $sformatf("Comma Detected."), UVM_LOW)
		endtask : detect_comma

	endclass 
endpackage
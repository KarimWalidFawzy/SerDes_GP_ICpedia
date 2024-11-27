
package test;
import uvm_pkg::*;
`include "uvm_macros.svh"
import seq_item::*;
import sequence_::*;
import env::*;
class enc_dec_test extends uvm_test;
	
	enc_dec_sequence enc_dec_seq;
    enc_dec_env 		enc_dec_env_i;				

	`uvm_component_utils(enc_dec_test)						

	function new(input string name = "enc_dec_test", uvm_component parent = null);	// component hence two arguments	
		super.new(name,parent);
	endfunction: new

			

// build_phase:- responsible for building all lower level components
//		 executes in top down manner.	

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		enc_dec_env_i = enc_dec_env::type_id::create("enc_dec_env_i",this);		
		enc_dec_seq=enc_dec_sequence::type_id :: create("enc_dec_seq",this);	// creating an objects for env and generator(sequence)

		// cfg = enc_dec_config::type_id::create("cfg", this);
		// if (!uvm_config_db#(virtual top_if)::get(this,"","TOP_IF", cfg.vif))
		// 	`uvm_fatal("build_phase", "unable to get virtual interface from uvm_config_db");

		// uvm_config_db #(enc_dec_config)::set(this, "*", "CFG", cfg);

	endfunction: build_phase


// end_of_elaboration_phase:- print_topology executes in buttom up manner.
//	       			

	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();	
	endfunction: end_of_elaboration_phase

virtual task run_phase(uvm_phase phase);

    		phase.raise_objection(this);
            enc_dec_seq.start(enc_dec_env_i.enc_agent_.sequencer);
    		phase.drop_objection(this);

			
  	endtask: run_phase


// report_phase:- display result of the simulation.
//		  executes in buttom up manner.


	virtual function void report_phase(uvm_phase phase);
		
		uvm_report_server svr;

		super.report_phase(phase);

		svr = uvm_report_server::get_server();

		if(svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR) > 0) begin: B1

			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)
			`uvm_info(get_type_name(), "-------------- TEST FAIL -------------", UVM_NONE)
			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)

		end: B1
	
		else begin: B2

			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)
			`uvm_info(get_type_name(), "-------------- TEST PASS -------------", UVM_NONE)
			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)

		end: B2

	endfunction: report_phase


endclass
endpackage
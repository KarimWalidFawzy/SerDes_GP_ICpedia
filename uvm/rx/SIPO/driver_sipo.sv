package driver_sipo;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item_sipo ::*;

    class driver_sipo extends uvm_driver #(sequence_item_sipo);
        `uvm_component_utils(driver_sipo)
    
        virtual sipo_if vif;
    
        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction : new

        function void connect_phase(uvm_phase phase);
            if (!uvm_config_db#(virtual sipo_if)::get(this,"","sipo_if", vif))
                `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
        endfunction: connect_phase

        task run_phase(uvm_phase phase);
            int random_number, i = 0;
            logic [9:0] comma_values [5] = '{124, 380, 387, 636, 899};
            super.run_phase(phase);
            vif.Reset=0;
            @(negedge vif.BitCLK);
            vif.Reset=1;
            repeat(10) begin
                i = i + 1;
                repeat (20 + $urandom_range(9, 1)) begin
                    @(negedge vif.BitCLK);
                    vif.Serial = $urandom_range(1, 0);
                end
                `uvm_info(get_type_name(), $sformatf("Start Sending Comma."), UVM_LOW)
                if (i < 10) begin
                    random_number = $urandom_range(4,0);
                    drive_item(comma_values[random_number]);
                end else begin
                    drive_item(643);
                end
            end
            forever begin
                seq_item_port.get_next_item(req);
                drive_item(req.serial_in);
                seq_item_port.item_done();
            end
        endtask : run_phase

        virtual task drive_item(bit [9:0] serial_in);
            for (int i = 0; i < 10; i++) begin
                @(negedge vif.BitCLK);
                vif.Serial = serial_in[i];
            end
        endtask : drive_item

    endclass
endpackage
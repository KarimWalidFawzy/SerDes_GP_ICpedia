package sequence_cdr;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item_cdr::*;

    class sequence_cdr extends uvm_sequence #(sequence_item_cdr);
        `uvm_object_utils(sequence_cdr)

        sequence_item_cdr sequence_item;

        function new(string name = "sequence_cdr");
            super.new(name);
        endfunction : new

        virtual task body();
            repeat(1000) begin
                sequence_item = sequence_item_cdr::type_id::create("sequence_item");
                start_item(sequence_item);
                assert(sequence_item.randomize());
                finish_item(sequence_item);
            end
        endtask 

    endclass
endpackage
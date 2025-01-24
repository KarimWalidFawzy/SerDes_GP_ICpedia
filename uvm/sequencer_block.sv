package sequencer_block;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `ifdef ENCODER
        import sequence_item_encoder::*;
    `elsif PISO
        import sequence_item_piso::*;
    `elsif SIPO
        import sequence_item_sipo::*;
    `elsif DECODER
        import sequence_item_decoder::*;
    `elsif CDR
        import sequence_item_cdr::*;
    `endif

    class sequencer_block extends uvm_sequencer #(
        `ifdef ENCODER
            sequence_item_encoder
        `elsif PISO
            sequence_item_piso
        `elsif SIPO
            sequence_item_sipo
        `elsif DECODER
            sequence_item_decoder
        `elsif CDR
            sequence_item_cdr
        `endif
    );
        `uvm_component_utils(sequencer_block)

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction : new

    endclass 
endpackage
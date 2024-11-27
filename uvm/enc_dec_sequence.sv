
package sequence_ ;
import uvm_pkg::*;
`include "uvm_macros.svh"
import seq_item ::*;
import enums::*;

class enc_dec_sequence extends uvm_sequence #(transaction);
    `uvm_object_utils(enc_dec_sequence)

    transaction  seq_item;

    function new(string name = "enc_dec_sequence");
        super.new(name);
    endfunction : new

    virtual task body ();
        seq_item = transaction::type_id::create("seq_item");
        seq_item.input_data = D_28_1;
        seq_item.tx_data_k = 1;
        start_item(seq_item);
        assert(seq_item);
        finish_item(seq_item);

        repeat(50) begin
            seq_item = transaction::type_id::create("seq_item");

            start_item(seq_item);
            assert(seq_item.randomize() );
            finish_item(seq_item);
        end
    endtask : body

endclass
endpackage
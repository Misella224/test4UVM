`ifndef ADDER_BASE_SEQ_SV
`define ADDER_BASE_SEQ_SV

class adder_base_seq extends uvm_sequence #(adder_seq_item);

    `uvm_object_utils(adder_base_seq)

    function new(string name = "adder_base_seq");
        super.new(name);
    endfunction

    task body();
        adder_seq_item tr;
        repeat (5) begin
            tr = adder_seq_item::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize());
            finish_item(tr);
        end
    endtask

endclass

`endif
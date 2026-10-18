`ifndef ADDER_SEQ_ITEM_SV
`define ADDER_SEQ_ITEM_SV

class adder_seq_item extends uvm_sequence_item;

    rand bit [15:0] dataA;
    rand bit [15:0] dataB;
    rand bit        en;

    bit [15:0] sum;
    bit        C_over;

    `uvm_object_utils_begin(adder_seq_item)
        `uvm_field_int(dataA,  UVM_ALL_ON)
        `uvm_field_int(dataB,  UVM_ALL_ON)
        `uvm_field_int(en,     UVM_ALL_ON)
        `uvm_field_int(sum,    UVM_ALL_ON)
        `uvm_field_int(C_over, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "adder_seq_item");
        super.new(name);
    endfunction

endclass

`endif
`ifndef ADDER_AGENT_SV
`define ADDER_AGENT_SV

class adder_agent extends uvm_agent;

    `uvm_component_utils(adder_agent)

    adder_driver    drv;
    adder_sequencer sqr;
    adder_monitor   mon;

    function new(string name = "adder_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = adder_driver   ::type_id::create("drv", this);
        sqr = adder_sequencer::type_id::create("sqr", this);
        mon = adder_monitor  ::type_id::create("mon", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction

endclass

`endif
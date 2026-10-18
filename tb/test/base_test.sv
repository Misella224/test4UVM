`ifndef BASE_TEST_SV
`define BASE_TEST_SV

class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    adder_env env;

    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = adder_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        adder_base_seq seq;
        phase.raise_objection(this);
        seq = adder_base_seq::type_id::create("seq");
        seq.start(env.agent.sqr);
        phase.drop_objection(this);
    endtask

endclass

`endif
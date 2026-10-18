`ifndef ADDER_MONITOR_SV
`define ADDER_MONITOR_SV

class adder_monitor extends uvm_monitor;

    `uvm_component_utils(adder_monitor)

    virtual adder_if vif;

    uvm_analysis_port #(adder_seq_item) ap;

    function new(string name = "adder_monitor", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("MON", "Failed to get vif from config_db")
        end
    endfunction

task run_phase(uvm_phase phase);
    adder_seq_item tr;

    wait (vif.rst_n === 1'b1);
    @(posedge vif.clk);

    forever begin
        @(negedge vif.clk);   // 在下降沿采样
        if (vif.en) begin
            tr = adder_seq_item::type_id::create("tr");
            tr.dataA  = vif.dataA;
            tr.dataB  = vif.dataB;
            tr.en     = vif.en;
            tr.sum    = vif.sum;
            tr.C_over = vif.C_over;
            `uvm_info("MON", $sformatf("Sampled: %0d + %0d = %0d, C_over=%0b",
                      tr.dataA, tr.dataB, tr.sum, tr.C_over), UVM_MEDIUM)
            ap.write(tr);
        end
    end
endtask

endclass

`endif
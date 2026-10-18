`ifndef ADDER_DRIVER_SV
`define ADDER_DRIVER_SV

class adder_driver extends uvm_driver #(adder_seq_item);

    `uvm_component_utils(adder_driver)

    virtual adder_if vif;

    function new(string name = "adder_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("DRV", "Failed to get vif from config_db")
        end
    endfunction

    task run_phase(uvm_phase phase);
        vif.rst_n <= 1'b0;
        vif.en    <= 1'b0;
        vif.dataA <= '0;
        vif.dataB <= '0;

        @(posedge vif.clk);
        vif.rst_n <= 1'b1;

        forever begin
            seq_item_port.get_next_item(req);
            drive_one(req);
            seq_item_port.item_done();
        end
    endtask

    task drive_one(adder_seq_item tr);
    @(negedge vif.clk);
    vif.en    <= tr.en;
    vif.dataA <= tr.dataA;
    vif.dataB <= tr.dataB;
endtask

endclass

`endif
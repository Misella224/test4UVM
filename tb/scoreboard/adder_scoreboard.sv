`ifndef ADDER_SCOREBOARD_SV
`define ADDER_SCOREBOARD_SV

class adder_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(adder_scoreboard)

    uvm_analysis_imp #(adder_seq_item, adder_scoreboard) imp;

    int unsigned num_checked;
    int unsigned num_errors;

    function new(string name = "adder_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        imp = new("imp", this);
        num_checked = 0;
        num_errors  = 0;
    endfunction

    function void write(adder_seq_item tr);
        bit [16:0] expected;
        expected = tr.dataA + tr.dataB;

        num_checked++;

        if (tr.sum !== expected[15:0] || tr.C_over !== expected[16]) begin
            num_errors++;
            `uvm_error("SCB", $sformatf(
                "Mismatch: %0d + %0d = DUT %0d (C=%0b), expected %0d (C=%0b)",
                tr.dataA, tr.dataB, tr.sum, tr.C_over,
                expected[15:0], expected[16]))
        end else begin
            `uvm_info("SCB", $sformatf(
                "PASS: %0d + %0d = %0d, C_over=%0b",
                tr.dataA, tr.dataB, tr.sum, tr.C_over), UVM_HIGH)
        end
    endfunction

    function void report_phase(uvm_phase phase);
        `uvm_info("SCB", $sformatf("Checked %0d, Errors %0d", num_checked, num_errors), UVM_LOW)
    endfunction

endclass

`endif
`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "adder_if.sv"
`include "adder_seq_item.sv"
`include "adder_driver.sv"
`include "adder_monitor.sv"
`include "adder_sequencer.sv"
`include "adder_agent.sv"
`include "adder_scoreboard.sv"
`include "adder_env.sv"
`include "adder_base_seq.sv"
`include "base_test.sv"

module top_tb;

    localparam DATA_WIDTH = 16;

    logic clk;

    adder_if #(DATA_WIDTH) vif (clk);

    adder #(
        .DATA_WIDTH (DATA_WIDTH)
    ) u_adder (
        .clk     (clk),
        .rst_n   (vif.rst_n),
        .en      (vif.en),
        .dataA   (vif.dataA),
        .dataB   (vif.dataB),
        .sum     (vif.sum),
        .C_over  (vif.C_over)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        uvm_config_db#(virtual adder_if)::set(null, "*", "vif", vif);
        run_test();
    end

endmodule
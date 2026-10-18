`ifndef ADDER_IF_SV
`define ADDER_IF_SV

interface adder_if #(parameter DATA_WIDTH = 16) (input logic clk);

    logic                  rst_n;
    logic                  en;
    logic [DATA_WIDTH-1:0] dataA;
    logic [DATA_WIDTH-1:0] dataB;
    logic [DATA_WIDTH-1:0] sum;
    logic                  C_over;

    // 可选：clocking block，后面 driver 可以用
    clocking drv_cb @(posedge clk);
        default input #1step output #1step;
        output rst_n;
        output en;
        output dataA;
        output dataB;
        input  sum;
        input  C_over;
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1step;
        input rst_n;
        input en;
        input dataA;
        input dataB;
        input sum;
        input C_over;
    endclocking

endinterface

`endif
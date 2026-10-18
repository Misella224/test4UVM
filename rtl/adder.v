`timescale 1ns/1ps

module adder #(
    parameter DATA_WIDTH = 16
) (
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire                  en,
    input  wire [DATA_WIDTH-1:0] dataA,
    input  wire [DATA_WIDTH-1:0] dataB,
    output wire [DATA_WIDTH-1:0] sum,
    output wire                  C_over
);

    reg [DATA_WIDTH:0] sum_add;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum_add <= '0;
        end else begin
            if (en) begin
                sum_add <= dataA + dataB;
            end else begin
                sum_add <= sum_add;
            end
        end
    end

    assign sum    = sum_add[DATA_WIDTH-1:0];
    assign C_over = sum_add[DATA_WIDTH];

endmodule
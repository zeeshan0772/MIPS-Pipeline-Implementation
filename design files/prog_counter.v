`timescale 1ns / 1ps

module prog_counter(
    input clk,
    input reset,
    input [31:0] next_PC,
    output reg [31:0] PC
);

initial begin
    PC = 0;
end

always @(posedge clk) begin
    if (reset) begin
        PC = 0;
    end
    else begin
        PC = next_PC;
    end
end

endmodule

`timescale 1ns / 1ps

module IF_ID_reg(
    input clk,
    input [31:0] PC,
    input [31:0] instruction,
    output reg [63:0] out
    );
    
    // Write Operation
    always @ (posedge clk) begin
        #2 // Memory read latency simulation
        out = {instruction, PC};
    end
endmodule

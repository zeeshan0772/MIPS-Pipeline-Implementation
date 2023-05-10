`timescale 1ns / 1ps

module IF_ID_reg_tb();

    reg clk;
    reg [31:0] current_PC;
    reg [31:0] instruction;

    wire [63:0] out;
    
    IF_ID_reg uut (
        .clk(clk),
        .current_PC(current_PC),
        .instruction(instruction),
        .out(out)
    );
    
    initial begin
        clk = 0;
        current_PC = 32'h80000000; // Initialize current_PC to some value
        instruction = 32'h8fa2000c; // Initialize instruction to some value
        
        #30 $finish; // Wait for a few cycles for the output to stabilize
        
    end
    
    always #5 clk = ~clk; // Toggle the clock every 5 time units

endmodule

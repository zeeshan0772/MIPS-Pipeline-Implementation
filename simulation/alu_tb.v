`timescale 1ns / 1ps

module alu_tb;
    // Inputs
    reg clk;
    reg [7:0] ALU_operand_1;
    reg [7:0] ALU_operand_2;
    reg [3:0] ALU_ctrl_input;
    
    // Outputs
    wire [7:0] Zero;
    wire [7:0] ALU_result;
    
    // Instantiate the Unit Under Test (UUT)
    alu uut (
        .clk(clk), 
        .ALU_operand_1(ALU_operand_1), 
        .ALU_operand_2(ALU_operand_2), 
        .ALU_ctrl_input(ALU_ctrl_input), 
        .Zero(Zero), 
        .ALU_result(ALU_result)
    );

    initial begin
        // Initialize inputs
        clk = 0;
        ALU_operand_1 = 15;
        ALU_operand_2 = 10;
        ALU_ctrl_input = 4'b0110; // Set ALU operation to ADD
        
        // Wait for a few clock cycles for the results to settle
        #10;
        
        // Finish the simulation
        $finish;
    end
    
    // Toggle the clock every 5 ns
    always #5 clk <= ~clk;
    
endmodule

`timescale 1ns / 1ps

module instruction_mem(
    input clk,
    input [31:0] address,
    output reg [31:0] instruction
);

reg [31:0] memory [0:1023]; // Declare a 1024-word memory array

initial begin
    /*
    L:
        ADD $2, $zero, $1
        SUB $2, $3, $1
        SW $3, 0($s1)
        LW $s4, 0($s1)
        ADD $5, $1, $4
        BNE $6, $7, L
    */
    // Initialize memory
    
    // **** MUST add nop instructions ***** //
    
    // add $2, $zero, $1
    // 000000 00001 00010 00000 00000 100000
    memory[0] = 32'b000000_00000_00001_00010_00000_100000;
    
    // NOP
    memory[1] = 32'b000000_00000_00000_00000_00000_000000;
    
    // NOP
    memory[2] = 32'b000000_00000_00000_00000_00000_000000;
    
    
    // sub $2, $3, $1
    // $2 = 15 - 10
    memory[3] = 32'b000000_00011_00001_00010_00000_100010;
    
    // sw $3, 0($s1)
    // 101011 00001 00011 0000000000000000
    //memory[0] = 32'b101011_00001_00011_0000000000000000;
    
    // * Add NOP to avoid hazard
    
    // lw $s4, 0($s1)
    // 100011 10010 10100 0000000000000000
    //memory[1] = 32'b100011_00001_00100_0000000000000000;
    
    // add $5, $1, $4
    //memory[4] = 32'b000000_00001_00100_00101_00000_100000;
    
    
    // BNE $6, $7, -6
    //memory[0] = 32'b000101_00111_00110_1111111111111010;
end

always @(posedge clk) begin
    #1  // FU delay
    instruction = memory[address >> 2]; // Fetch the instruction from memory
end

endmodule

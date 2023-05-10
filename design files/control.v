`timescale 1ns / 1ps

module control(
    input [5:0] opcode,  // Instruction opcode
    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUop,
    output reg MemWrite,
    output reg ALUsrc,
    output reg RegWrite
    );
    
    parameter r_format = 6'b000000;
    parameter lw = 6'b100011;
    parameter sw = 6'b101011;
    parameter bne = 6'b000101;
    
    // refer to pg:269 for control signal values
    

    always @ * begin
        if (opcode == r_format) begin
            RegDst = 1;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUop = 2'b10;
            MemWrite = 0;
            ALUsrc = 0;
            RegWrite = 1;
        end
        else if (opcode == lw) begin
            RegDst = 0;
            Branch = 0;
            MemRead = 1;
            MemtoReg = 1;
            ALUop = 2'b00;
            MemWrite = 0;
            ALUsrc = 1;
            RegWrite = 1;
        end
        else if (opcode == sw) begin
            RegDst = 1'bx;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 1'bx;
            ALUop = 2'b00;
            MemWrite = 1;
            ALUsrc = 1;
            RegWrite = 0;
        end 
        else if (opcode == bne) begin
            RegDst = 1'bx;
            Branch = 1;
            MemRead = 0;
            MemtoReg = 0;
            ALUop = 2'b01;
            MemWrite = 0;
            ALUsrc = 0;
            RegWrite = 0;
        end 
    end
endmodule

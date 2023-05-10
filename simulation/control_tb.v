`timescale 1ns / 1ps

module control_tb;
  // Inputs
  reg [5:0] opcode;

  // Outputs
  wire RegDst;
  wire Branch;
  wire MemRead;
  wire MemtoReg;
  wire [1:0] ALUop;
  wire MemWrite;
  wire ALUsrc;
  wire RegWrite;

  // Instantiate the Unit Under Test (UUT)
  control uut (
    .opcode(opcode),
    .RegDst(RegDst),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUop(ALUop),
    .MemWrite(MemWrite),
    .ALUsrc(ALUsrc),
    .RegWrite(RegWrite)
  );

  // Initialize Inputs
  initial begin
    opcode = 6'b000000; // r_format
    #10;
    opcode = 6'b100011; // lw
    #10;
    opcode = 6'b101011; // sw
    #10;
    opcode = 6'b000101; // bne
    #10;
    $finish;
  end
endmodule

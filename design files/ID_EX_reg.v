`timescale 1ns / 1ps

module ID_EX_reg(
    input clk,
    input RegDst,
    input Branch,
    input MemRead,
    input MemtoReg,
    input [1:0] ALUop,
    input MemWrite,
    input ALUsrc,
    input RegWrite,
    input [31:0] PC,
    input [7:0] read_reg_1, // read register 1 from register file. <rs> 
    input [7:0] read_reg_2, // read register 2 from register file <rt>
    input [31:0] sign_extended,
    input [4:0] rt_reg_addr,
    input [4:0] rd_reg_addr,
    output reg [98:0] out
);

    initial begin
    #2
        out = 0;
    end
    
// Write Operation
always @ (posedge clk) begin
    #2 // register file read latency simulation
    out = { rd_reg_addr, 
            rt_reg_addr, 
            sign_extended, 
            read_reg_2, 
            read_reg_1,
            PC,
            RegWrite,
            ALUsrc,
            MemWrite,
            ALUop,
            MemtoReg,
            MemRead,
            Branch,
            RegDst
           };
end
endmodule
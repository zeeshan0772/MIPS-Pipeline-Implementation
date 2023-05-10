`timescale 1ns / 1ps

module EX_MEM_reg(
    input clk,
    input Branch,
    input MemRead,
    input MemWrite,
    input MemtoReg,
    input RegWrite,
    input [31:0] PC,
    input zero_signal,
    input [7:0] alu_result,
    input [7:0] data_mem_write_data,    // data to be written to data mem
    input [4:0] rt_rd_reg,
    output reg [58:0] out
    );
    

    initial begin
    #2
        out = 0;
    end
    
    always @ (posedge clk) begin
        #2
        out = {
                rt_rd_reg,
                data_mem_write_data,
                alu_result,
                zero_signal,
                PC,
                RegWrite,
                MemtoReg,
                MemWrite,
                MemRead,
                Branch
                };
    end
endmodule

`timescale 1ns / 1ps

module MEM_WB_reg(
    input clk,
    input MemtoReg,
    input RegWrite,
    input [7:0] data_mem_dout,
    input [7:0] alu_result,
    output reg [17:0] out
    );
    
    initial begin
        #2
        out = 0;
    end
    
    always @ (posedge clk) begin
        out = { alu_result,
                data_mem_dout,
                RegWrite,
                MemtoReg
              };
    end
endmodule

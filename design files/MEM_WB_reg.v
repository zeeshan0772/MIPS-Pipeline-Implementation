`timescale 1ns / 1ps

module MEM_WB_reg(
    input clk,
    input MemtoReg,
    input RegWrite,
    input [7:0] data_mem_dout,
    input [7:0] alu_result,
    input [4:0] mem_wb_rt_rd_reg_address,
    output reg [22:0] out
    );
    
    initial begin
        #2
        out = 0;
    end
    
    always @ (posedge clk) begin
        #2
        out = { mem_wb_rt_rd_reg_address,
                alu_result,
                data_mem_dout,
                RegWrite,
                MemtoReg
              };
    end
endmodule

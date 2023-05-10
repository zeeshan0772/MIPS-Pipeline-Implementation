`timescale 1ns / 1ps

module data_mem(
    input clk,
    input [7:0] address,
    input [7:0] write_data,
    input MemWrite,
    input MemRead,
    output reg [7:0] read_data
    );
    
    reg [7:0] mem[0:1023]; // 1024 8-bit registers
    
    always @(posedge clk) begin
        if (MemWrite) begin
            mem[address] = write_data;
        end
        else if (MemRead) begin
            read_data = mem[address];
        end
    end
endmodule

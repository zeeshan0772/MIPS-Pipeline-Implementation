`timescale 1ns / 1ps

module instruction_mem_tb;
reg clk;
reg [31:0] address;
wire [31:0] instruction;

instruction_mem dut (
    .clk(clk),
    .address(address),
    .instruction(instruction)
);

initial begin
    clk = 0;
    address = 0;
    #10 address = 4; // Set the address to fetch the second instruction
    #10 address = 0; // Set the address to fetch the first instruction
    #10 $finish; // End the simulation
end

always #5 clk = ~clk; // Toggle the clock every 5ns

endmodule

`timescale 1ns / 1ps

module prog_counter_tb;

reg clk;
reg reset;
reg [31:0] next_PC;
wire [31:0] PC;

prog_counter dut(
    .clk(clk),
    .reset(reset),
    .next_PC(next_PC),
    .PC(PC)
);

initial begin
    clk = 0;
    #5
    reset = 1;
    next_PC = 0;
    #10 reset = 0;  // Release reset after 10 ns
    #10 next_PC = 4;  // Set next_PC to 4 after 10 ns
    #10 next_PC = 8;  // Set next_PC to 8 after 20 ns
    #10 next_PC = 12; // Set next_PC to 12 after 30 ns
    #10 $finish;
end

always #5 clk = ~clk; // Generate a clock with period 10 ns

endmodule

`timescale 1ns / 1ps

module sign_extender_tb;
  // Inputs
  reg [15:0] in;

  // Outputs
  wire [31:0] out;

  // Instantiate the sign extender
  sign_extender dut(
    .in(in),
    .out(out)
  );

  // Apply test vectors
  initial begin
    // Positive input
    in = 16'h1234;
    #10;
    
    // Negative input
    in = 16'hFEDC;
    #10;
    
    // Zero input
    in = 16'h0000;
    #10;
    
    // Max positive input
    in = 16'h7FFF;
    #10;
    
    // Min negative input
    in = 16'h8000;
    #10;
    
    // Delay for a few more cycles before ending the simulation
    #10 $finish;
  end

endmodule

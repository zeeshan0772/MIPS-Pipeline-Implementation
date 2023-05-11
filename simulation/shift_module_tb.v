`timescale 1ns / 1ps

module shift_module_tb;

  // Inputs
  reg [31:0] in_data;

  // Outputs
  wire [31:0] out_data;

  // Instantiate the module to be tested
  shift_module uut(
    .in_data(in_data),
    .out_data(out_data)
  );

  // Stimulus
  initial begin
    in_data = 12;
    
    #10 in_data = -12;

    // Stop the simulation
    #10 $finish;
  end

endmodule


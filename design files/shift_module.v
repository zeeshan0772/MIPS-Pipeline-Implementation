`timescale 1ns / 1ps

module shift_module(
  input [31:0] in_data,
  output [31:0] out_data
);

  assign out_data = in_data << 2;

endmodule

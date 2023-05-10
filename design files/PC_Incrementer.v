`timescale 1ns / 1ps

module PC_Incrementer (
  input [31:0] current_PC,
  output reg [31:0] next_PC
);

    always @(*) begin
      next_PC = current_PC + 32'h4;
    end

endmodule

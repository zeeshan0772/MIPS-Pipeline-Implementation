`timescale 1ns / 1ps

module alu_control(
    input [1:0] ALUop,  // signal generated by control unit
    input [5:0] funct,  // function field extracted from instruction
    output reg [3:0] ALU_control_signal     // output control signal generated by ALU controller. This is input to the ALU.
    );
    
    always @ * begin

        // Refer to Fig 4.12, and 4.13 of Textbook
        case (ALUop)
            2'b00: ALU_control_signal = 4'b0010;    // control signal for ADD operation
            2'b01: ALU_control_signal = 4'b0110;    // control signal for SUB operation
            2'b10: begin
                case (funct)
                    6'b100000: ALU_control_signal = 4'b0010;
                    6'b100010: ALU_control_signal = 4'b0110;
                    default: ALU_control_signal = 4'bxxxx;
                endcase
            end
        endcase
    end
endmodule
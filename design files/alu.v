`timescale 1ns / 1ps

module alu(
    input clk,
    input [7:0] ALU_operand_1, // first operand of ALU
    input [7:0] ALU_operand_2, // second operand of ALU
    input [3:0] ALU_ctrl_input, // control signal coming from the ALU control unit
    output reg [7:0] Zero, // Zero output of ALU
    output reg [7:0] ALU_result    // result of ALU operation
    );

    // internal wires
    // They store the contain the result of all ALU operations
    // based on the ALU control signal, we'll route one of these to result port
    wire [7:0] add_result;
    wire [7:0] sub_result;
    
    assign add_result = ALU_operand_1 + ALU_operand_2;
    assign sub_result = ALU_operand_1 - ALU_operand_2;   
    
    // ALU Control Logic
    always @ (posedge clk) begin
    //#4  // FU delay
        case (ALU_ctrl_input)
            4'b0010: ALU_result = add_result; // ADD
            4'b0110: ALU_result = sub_result; // SUBTRACT
            default: ALU_result = 8'hxx; // Undefined
        endcase
        
        // Set/clear zero output port
        if (ALU_result == 0) begin
            Zero = 1;
        end else begin
            Zero = 0;
        end
    end
endmodule
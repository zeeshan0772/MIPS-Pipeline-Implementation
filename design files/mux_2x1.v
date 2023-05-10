`timescale 1ns / 1ps

module mux_2x1(
    input [7:0] a, 
    input [7:0] b, 
    input sel,
    output reg [7:0] y
    );
    
    always @ (a, b, sel)
    begin
        case(sel)
            1'b0: y = a; // when sel = 0, output a
            1'b1: y = b; // when sel = 1, output b
        endcase
    end
endmodule
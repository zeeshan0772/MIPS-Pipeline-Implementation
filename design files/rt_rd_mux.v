`timescale 1ns / 1ps

module rt_rd_mux(
    input [4:0] rt, 
    input [4:0] rd, 
    input sel,
    output reg [4:0] out
    );
    
    always @ *
    begin
        case(sel)
            1'b0: out = rt; // when sel = 0, output rt
            1'b1: out = rd; // when sel = 1, output rd
        endcase
    end
endmodule
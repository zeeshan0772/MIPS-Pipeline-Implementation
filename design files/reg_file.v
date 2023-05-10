`timescale 1ns / 1ps

module reg_file(
    input clk,
    input [4:0] read_reg_1, // address of first read register. Fetched from instruction
    input [4:0] read_reg_2, // address of second read register. Fetched from instruction
    input [4:0] write_reg_addr, // address of register write. 
    input [7:0] write_data,  // data to be written at register address
    input regWrite, // control signal from main control. specifying to write data 
    output reg [7:0] read_data_1,   // contents of register at address read_reg_1
    output reg [7:0] read_data_2    // contents of register at address read_reg_2
    );
    
    // Implement zero register
    
    reg [7:0] reg_bank [0:31];  // array of 32 registers. each register is 8-bit wide
    
    // random data
    initial begin

        reg_bank[0] = 0;
        reg_bank[1] = 15;
        reg_bank[3] = 10;
        
        reg_bank[6] = 19;
        reg_bank[7] = 30;
    end
    
    
    // Outputs
    always @ (posedge clk) begin
    //#3  // FU delay. 2+1
        read_data_1 = reg_bank[read_reg_1];
        read_data_2 = reg_bank[read_reg_2];
    end
    
    // Register file write
    always @ (posedge clk) begin
    //#7  // FU delay. 6+1
        if (regWrite) begin
            reg_bank[write_reg_addr] = write_data;
        end
    end
endmodule

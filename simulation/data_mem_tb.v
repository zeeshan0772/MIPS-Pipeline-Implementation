`timescale 1ns / 1ps

module data_mem_tb;

    // Inputs
    reg clk;
    reg [31:0] address;
    reg [7:0] write_data;
    reg MemWrite;
    reg MemRead;
    
    // Outputs
    wire [7:0] read_data;
    
    // Instantiate the module to be tested
    data_mem dut (
        .clk(clk),
        .address(address),
        .write_data(write_data),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .read_data(read_data)
    );
    
    // Clock generator
    always #5 clk = ~clk;
    
    // Test case 1: Write and read
    initial begin
        clk = 0;
        #5
        address = 0;
        write_data = 8'hAA;
        MemWrite = 1;
        MemRead = 0;
        #10;
        MemWrite = 0;
        MemRead = 1;
        #10;
        
    // Test case 2: Write-only
        address = 1;
        write_data = 8'h55;
        MemWrite = 1;
        MemRead = 0;
        #10;
        MemWrite = 0;
        MemRead = 1;
        #10;
        
    // Test case 3: Read-only
    // output will be undefined because no data has been stored at address 2
        address = 2;
        MemWrite = 0;
        MemRead = 1;
        #10; 
        
        #10 $finish;
    end
    
endmodule

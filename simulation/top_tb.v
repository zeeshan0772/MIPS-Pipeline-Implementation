`timescale 1ns / 1ps

module top_tb;

    // Declare inputs and outputs for the test bench
    reg clk;
    reg PC_reset;
    
    wire [31:0] pc_wire;
    wire [31:0] instruction;
    wire [63:0] IF_ID_output_port;
    wire RegDst_wire;
    wire Branch_wire;
    wire MemRead_wire;
    wire MemtoReg_wire;
    wire [1:0] ALUop_wire;
    wire MemWrite_wire;
    wire ALUsrc_wire;
    wire RegWrite_wire;
    wire [7:0] read_data_1_wire;   // contents of register at address read_reg_1
    wire [7:0] read_data_2_wire;    // contents of register at address read_reg_2
    wire [31:0] sign_extend_wire;
    wire [98:0] ID_EX_output_port;
    wire [7:0] ALU_op_2;
    wire [3:0] ALU_control_signal_wire;
    wire zero_wire;
    wire [7:0] ALU_result_wire;
    wire [4:0] rt_rd_mux_output_wire;
    wire [58:0] EX_MEM_output_port;
    wire PCSrc;
    wire [31:0] target_pc_wire;
    wire [7:0] data_mem_dout_wire;
    
    
    wire [31:0] selected_address_for_pc;
    wire [31:0] PC_value_after_EX_MEM;
    wire [31:0] next_pc_wire;
    wire [17:0] MEM_WB_output_port;
    wire [7:0] write_back_data_wire;
    /*wire [31:0] left_shift_wire;
    wire [31:0] branch_addr_wire;
    wire mux_sel_for_branching_wire;
    
    

    
    
    

    
    wire [7:0] constant;*/
    
    // Instantiate the top-level module
    top top_inst(
        .clk(clk),
        .PC_reset(PC_reset),
        .pc_wire(pc_wire),
        .instruction_wire(instruction),
        .IF_ID_output_port(IF_ID_output_port),
        .RegDst_wire(RegDst_wire),
        .Branch_wire(Branch_wire),
        .MemRead_wire(MemRead_wire),
        .MemtoReg_wire(MemtoReg_wire),
        .ALUop_wire(ALUop_wire),
        .MemWrite_wire(MemWrite_wire),
        .ALUsrc_wire(ALUsrc_wire),
        .RegWrite_wire(RegWrite_wire),
        .read_data_1_wire(read_data_1_wire),
        .read_data_2_wire(read_data_2_wire),
        .sign_extend_wire(sign_extend_wire),
        .ID_EX_output_port(ID_EX_output_port),
        .ALU_op_2(ALU_op_2),
        .ALU_control_signal_wire(ALU_control_signal_wire),
        .zero_wire(zero_wire),
        .ALU_result_wire(ALU_result_wire),        
        .rt_rd_mux_output_wire(rt_rd_mux_output_wire),
        .EX_MEM_output_port(EX_MEM_output_port),
        .PCSrc(PCSrc),
        .target_pc_wire(target_pc_wire),
        .data_mem_dout_wire(data_mem_dout_wire),
        .selected_address_for_pc(selected_address_for_pc),
        .PC_value_after_EX_MEM(PC_value_after_EX_MEM),
        .next_pc_wire(next_pc_wire),
        .MEM_WB_output_port(MEM_WB_output_port),
        .write_back_data_wire(write_back_data_wire)
        /*
        .left_shift_wire(left_shift_wire),
        .branch_addr_wire(branch_addr_wire),
        .mux_sel_for_branching_wire(mux_sel_for_branching_wire),
        
        
        
        
        
        

        
        ,
        .constant(constant)*/
    );

    // Reset generation
    initial begin
        clk = 0;
        #10
        PC_reset = 1;
        #20 
        PC_reset = 0;
        #300 $finish;
    end
        
    // Clock generation
    always #10 clk = ~clk;

endmodule

`timescale 1ns / 1ps

module top(
    input clk,
    input PC_reset,  // reset signal to PC
    output [31:0] pc_wire,  // current PC value
    output [31:0] instruction_wire, // fetched instruction
    output [63:0] IF_ID_output_port,     // output port of IF/ID pipeline register
    output RegDst_wire,
    output Branch_wire,
    output MemRead_wire,
    output MemtoReg_wire,
    output [1:0] ALUop_wire,
    output MemWrite_wire,
    output ALUsrc_wire,
    output RegWrite_wire,
    output [7:0] read_data_1_wire,   // contents of register at address read_reg_1
    output [7:0] read_data_2_wire,    // contents of register at address read_reg_2
    output [31:0] sign_extend_wire, // output of sign extender module
    output [98:0] ID_EX_output_port,
    output ID_EX_branch_wire,
    output [7:0] ALU_op_2,
    output [3:0] ALU_control_signal_wire,
    output zero_wire,
    output [7:0] ALU_result_wire,
    output [4:0] rt_rd_reg_address_mux_out,
    output [31:0] left_shift_wire, 
    output [31:0] ID_EX_PC_value,   
    output [58:0] EX_MEM_output_port,
    output data_mem_MemRead_signal,
    output PCSrc,
    output [31:0] target_pc_wire,
    output [7:0] data_mem_dout_wire,
    output [31:0] selected_address_for_pc,
    output [31:0] PC_value_after_EX_MEM,
    output [31:0] next_pc_wire,
    output [7:0] data_mem_write_addr,
    output [7:0] data_mem_write_data,
    output [22:0] MEM_WB_output_port,
    output [7:0] write_back_data_wire,
    output [4:0] regfile_write_reg_address/*,
    output [4:0] rt_rd_mux_output_wire,

    
    
    

    
    ,
    output [7:0] constant*/
    );
    
    //wire [31:0] next_pc_wire;
    
    // Program Counter
    prog_counter pc_inst(
        .clk(clk),
        .reset(PC_reset),
        .next_PC(target_pc_wire),
        .PC(pc_wire)
    );
    
    // PC Incrementer
    PC_Incrementer pc_incrementer_inst(
        .current_PC(pc_wire),
        .next_PC(next_pc_wire)
    );
    
    // Instruction Memory
    instruction_mem instruction_mem_inst(
        .clk(clk),
        .address(pc_wire),
        .instruction(instruction_wire)
    );
    
    // ********************************* //
    // IF_ID pipeline register
    IF_ID_reg IF_ID_reg_inst(
        .clk(clk),
        .PC(next_pc_wire),
        .instruction(instruction_wire),
        .out(IF_ID_output_port)
    );
    
    

    control control_inst(
        .opcode(IF_ID_output_port[63:58]),  // read opcode from IF/ID register
        .funct(IF_ID_output_port[37:32]),
        .RegDst(RegDst_wire),
        .Branch(Branch_wire),
        .MemRead(MemRead_wire),
        .MemtoReg(MemtoReg_wire),
        .ALUop(ALUop_wire),
        .MemWrite(MemWrite_wire),
        .ALUsrc(ALUsrc_wire),
        .RegWrite(RegWrite_wire)
        );

    // Register file integration
    
    //wire [7:0] write_back_data_wire;
    reg_file reg_file_inst(
        .clk(clk),
        .read_reg_1(IF_ID_output_port[57:53]),  // extract address of rs register
        .read_reg_2(IF_ID_output_port[52:48]),  // extract address of rt register
        .write_reg_addr(regfile_write_reg_address), // ****** need modfication ****** //
        .write_data(write_back_data_wire),
        .regWrite(MEM_WB_output_port[1]),
        .read_data_1(read_data_1_wire),
        .read_data_2(read_data_2_wire)
    );
    
    // sign extender
    sign_extender sign_ext_inst(
        .in(IF_ID_output_port[47:32]),
        .out(sign_extend_wire)
    );
    

    // ****************************************** //
    // ID_EX stage
    ID_EX_reg ID_EX_reg_inst(
        .clk(clk),
        .RegDst(RegDst_wire),
        .Branch(Branch_wire),
        .MemRead(MemRead_wire),
        .MemtoReg(MemtoReg_wire),
        .ALUop(ALUop_wire),
        .MemWrite(MemWrite_wire),
        .ALUsrc(ALUsrc_wire),
        .RegWrite(RegWrite_wire),
        .PC(IF_ID_output_port[31:0]),
        .read_reg_1(read_data_1_wire),
        .read_reg_2(read_data_2_wire),
        .sign_extended(sign_extend_wire),
        .rt_reg_addr(IF_ID_output_port[52:48]),
        .rd_reg_addr(IF_ID_output_port[47:43]),
        .out(ID_EX_output_port)
    );
    
    // left shift by 2
    // wire [31:0] left_shift_wire;
    shift_module shift_inst(
        .in_data(ID_EX_output_port[88:57]),
        .out_data(left_shift_wire)
    );
    
    // adder module
    //wire [31:0] selected_address_for_pc;
    assign ID_EX_PC_value = ID_EX_output_port[40:9];
    adder adder_inst(
        .a(ID_EX_output_port[40:9]),    // value of pc from ID/EX
        .b(left_shift_wire),
        .sum(selected_address_for_pc)
    );
    
    // ALU 2nd operand selection mux
    mux_2x1 mux_inst(
        .a(ID_EX_output_port[56:49]),   // read register 2 from regfile
        .b(ID_EX_output_port[64:57]),  // immediate constant from sign extender
        .sel(ID_EX_output_port[7]),      // control signal for selection - ALUsrc
        .y(ALU_op_2)    // output is the second operand for ALU
        );

    // ALU control integration
    alu_control alu_control_inst(
        .ALUop(ID_EX_output_port[5:4]),
        .funct(ID_EX_output_port[62:57]), 
        .ALU_control_signal(ALU_control_signal_wire)
        );

    // ALU integration
    alu alu_inst(
        .clk(clk),
        .ALU_operand_1(ID_EX_output_port[48:41]),
        .ALU_operand_2(ALU_op_2),
        .ALU_ctrl_input(ALU_control_signal_wire),
        .Zero(zero_wire),
        .ALU_result(ALU_result_wire)
    );
    
    // output of mux which is either the address of rt or rd register.
    //wire [4:0] rt_rd_reg_address_mux_out;
    // Mux for selecting rt or rd
    rt_rd_mux rt_rd_mux_inst(
        .rt(ID_EX_output_port[93:89]),
        .rd(ID_EX_output_port[98:94]),
        .sel(ID_EX_output_port[0]),     // RegDst control signal extracted from pipeline register
        .out(rt_rd_reg_address_mux_out)
    );    
    
    assign ID_EX_branch_wire = ID_EX_output_port[1];
    // ******************************************* //
    // EX_MEM stage
    EX_MEM_reg EX_MEM_reg_inst(
        .clk(clk),
        .Branch(ID_EX_output_port[1]),
        .MemRead(ID_EX_output_port[2]),
        .MemWrite(ID_EX_output_port[6]),
        .MemtoReg(ID_EX_output_port[3]),
        .RegWrite(ID_EX_output_port[8]),
        .PC(selected_address_for_pc),
        .zero_signal(zero_wire),
        .alu_result(ALU_result_wire),
        .data_mem_write_data(ID_EX_output_port[56:49]),
        .rt_rd_reg(rt_rd_reg_address_mux_out),
        .out(EX_MEM_output_port)
    );
    
    
    
    
    // ANDing branch with NOT zero signal
    // generating PCSrc signal
    assign PCSrc = EX_MEM_output_port[0] & ~EX_MEM_output_port[37]; // Branch_wire & ~zero_wire;
    assign PC_value_after_EX_MEM = EX_MEM_output_port[36:5];
    // mux module
    mux_2x1_32_bits mux_32bit_inst(
        .a(next_pc_wire),
        .b(EX_MEM_output_port[36:5]),   // PC value extracted from EX_MEM
        .sel(PCSrc),
        .y(target_pc_wire)
    );
    
    assign data_mem_write_addr = EX_MEM_output_port[45:38];
    assign data_mem_write_data = EX_MEM_output_port[53:46];
    assign data_mem_MemRead_signal = EX_MEM_output_port[1];
    // data memory integration
    data_mem data_mem_inst(
        .clk(clk),
        .address(EX_MEM_output_port[45:38]),    // ALU result
        .write_data(EX_MEM_output_port[53:46]),  // Read register 2 from Regfile
        .MemWrite(EX_MEM_output_port[2]),
        .MemRead(EX_MEM_output_port[1]),
        .read_data(data_mem_dout_wire)
    );
    
    // ******************************************** //
    // MEM/WB stage
    MEM_WB_reg MEM_WB_reg_inst(
        .clk(clk),
        .MemtoReg(EX_MEM_output_port[3]),
        .RegWrite(EX_MEM_output_port[4]),
        .data_mem_dout(data_mem_dout_wire),
        .alu_result(EX_MEM_output_port[45:38]),
        .mem_wb_rt_rd_reg_address(EX_MEM_output_port[58:54]),
        .out(MEM_WB_output_port)
        
    );
    
    // address of write for register file
    // feb back to regfile
    assign regfile_write_reg_address = MEM_WB_output_port[22:18];
    // Mux for selecting the data-out from memory and 
    // ALU result
    mux_2x1 mux_alu_dout(
        .a(MEM_WB_output_port[17:10]),  // alu result
        .b(MEM_WB_output_port[9:2]),    // memory dout
        .sel(MEM_WB_output_port[0]),
        .y(write_back_data_wire)
    );
    
    //assign constant = instruction_wire[7:0];
endmodule

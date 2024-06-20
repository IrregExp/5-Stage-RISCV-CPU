// Organizes and initializes wires and modules including:
// pc counter, memory, register, mux, and alu

`include "structs.sv"

module Datapath (input logic clk
						, input logic reset
						, input logic reg_write
						, input logic mem2reg   
						, input logic alu_src   
						, input logic mem_write 
						, input logic mem_read  
						, input logic branch
						, input logic jump
            , input logic [1:0] alu_op
						, input logic [3:0] alu_cc 
            , output logic stallMux_sel   
						, output logic [6:0] opcode   
						, output logic [6:0] funct7   
						, output logic [2:0] funct3  
            , output logic [1:0] alu_op_ff
						, output logic [31:0] alu_result 
						);

    // Initialize wires
    wire flush, stall;
    wire [1:0] ForwardA, ForwardB;
    wire [7:0] n_pc_count;
    wire [31:0] wrt_data, alu_in1, alu_in2, alu_in2_mux;

    IF_ID IFID_in;
    IF_ID IFID_out;

    ID_EX IDEX_in;
    ID_EX IDEX_out;


    EX_MEM EXMEM_in;
    EX_MEM EXMEM_out;

    MEM_WB MEMWB_in;
    MEM_WB MEMWB_out;
    
    
    assign IDEX_in.rd       = IFID_out.instr_code[11:7];
    assign IDEX_in.rs1      = IFID_out.instr_code[19:15];
    assign IDEX_in.rs2      = IFID_out.instr_code[24:20];
    assign IDEX_in.ctrl     = {alu_src, mem2reg, reg_write, mem_read, mem_write, branch, jump, alu_op};
    assign IDEX_in.PC_count = IFID_out.PC_count;
    assign IDEX_in.funct7   = IFID_out.instr_code[31:25];
    assign IDEX_in.funct3   = IFID_out.instr_code[14:12];

    assign EXMEM_in.rd              = IDEX_out.rd;
    assign EXMEM_in.ctrl            = IDEX_out.ctrl[7:2];
    assign EXMEM_in.PC_count_jump   = IDEX_out.PC_count + (IDEX_out.ImmGen << 1);
    assign EXMEM_in.wr_data         = alu_in2_mux;

    assign MEMWB_in.rd              = EXMEM_out.rd;
    assign MEMWB_in.ctrl            = EXMEM_out.ctrl[5:4];
    assign MEMWB_in.dataMem_addr    = EXMEM_out.dataMem_addr;
    

    assign alu_op_ff = IDEX_out.ctrl[1:0];
    assign alu_result = EXMEM_out.dataMem_addr;
    assign flush = EXMEM_out.ctrl[0] | (EXMEM_out.ctrl[1] & EXMEM_out.zero);
    assign stallMux_sel = flush | stall;


    // Instruction Fetch/Decode Flip-flop
    Fetch_Decode IFID_ff( .clk(clk),
                          .reset(reset),
                          .stall(stall),
                          .flush(flush),
                          .IFID_in(IFID_in),
                          .IFID_out(IFID_out)
                        );

    // The PC counter
    PC ff1( .clk(clk),
            .reset(reset),
            .PC_in(n_pc_count),
            .stall(stall),
            .PC_out(IFID_in.PC_count)
          );


    // The 64x32 Instruction Memory
    InstMem im1( .addr(IFID_in.PC_count),
                 .instruction(IFID_in.instr_code)
                );

    // Hazard detection module
    Hazard_Detect hazard( .IF_ID(IFID_out),
                         .ID_EX(IDEX_out),
                         .stall(stall)
                        );


    // The 64x32 Register File
    RegFile rg1( .clk(clk),
                 .reset(reset),
                 .wr_en(MEMWB_out.ctrl[0]), //reg_write
                 .rd_addr1(IFID_out.instr_code[19:15]),
                 .rd_addr2(IFID_out.instr_code[24:20]),
                 .wr_addr(MEMWB_out.rd),
                 .wr_data(wrt_data),
                 .rd_data1(IDEX_in.rd_data1),
                 .rd_data2(IDEX_in.rd_data2) 
                );

    // Instruction decode/execute flip-flop
    Decode_Execute IDEX_ff( .clk(clk),
                            .reset(reset),
                            .flush(flush),
                            .IDEX_in(IDEX_in),
                            .IDEX_out(IDEX_out)
                          );


    // Generate the Immidiate value
    ImmGen ig1( .InstCode(IFID_out.instr_code),
                .ImmOut(IDEX_in.ImmGen) 
              );

	// Determine whether to increment by 4, or jump to new address
	Mux_2to1 #(.WIDTH(8)) next_count( .A(IFID_in.PC_count + 8'd4),
							                      .B(EXMEM_out.PC_count_jump),
							                      .sel(flush),  // jump | (branch & zero), determines if a jump is occuring (and therefore a flush)
							                      .out(n_pc_count) 
                                  );


  // Forwarding multiplexor A
  Mux_3to1 ALUInFWDA( .A(IDEX_out.rd_data1),
                      .B(wrt_data),
                      .C(EXMEM_out.dataMem_addr),
                      .sel(ForwardA),
                      .out(alu_in1)
                      );

  // Forwarding multiplexor B
  Mux_3to1 ALUInFWDB( .A(IDEX_out.rd_data2),
                      .B(wrt_data),
                      .C(EXMEM_out.dataMem_addr),
                      .sel(ForwardB),
                      .out(alu_in2_mux)
                      );

    // A mux to decide if the data from Register File or Immidiate value
    // will be the second input for the ALU
    Mux_2to1 mux1( .A(alu_in2_mux),
                   .B(IDEX_out.ImmGen),
                   .sel(IDEX_out.ctrl[8]),   //alu_src
                   .out(alu_in2) 
                  );

    // ALU with 4 operations (add, sub, AND, OR)
    // Needs to be changed
    ALU a1( .rd1(alu_in1),
            .rd2(alu_in2),
            .sel(alu_cc),
            .ALUOut(EXMEM_in.dataMem_addr),
            .zero(EXMEM_in.zero)
					);

    Execute_Memory EXMEM_ff( .clk(clk),
                             .reset(reset),
                             .flush(flush),
                             .EXMEM_in(EXMEM_in),
                             .EXMEM_out(EXMEM_out)
                           );

    // The 128x32 Data Memory
    DataMem dm1( .clk(clk),
						     .reset(reset),
					       .memWrite(EXMEM_out.ctrl[2]), // mem_write
                 .memRead(EXMEM_out.ctrl[3]), // mem_read
                 .addr(EXMEM_out.dataMem_addr[8:0]),
                 .wr_data(EXMEM_out.wr_data),
                 .rd_data(MEMWB_in.dataMem_rdData) 
                );

  // Memory/writback flip flop
  Memory_Writeback MEMWB_ff( .clk(clk),
                             .reset(reset),
                             .MEMWB_in(MEMWB_in),
                             .MEMWB_out(MEMWB_out) 
                            );
  // Forwarding unit
  Forwarding_Unit fwd( .EX_MEM(EXMEM_out),
                       .ID_EX(IDEX_out),
                       .MEM_WB(MEMWB_out),
                       .ForwardA(ForwardA),
                       .ForwardB(ForwardB)
                       );

    // A 2 to 1 mux that will decide whether the data from memory
    // or ALU will be written to the Register File
    Mux_2to1 mux2( .A(MEMWB_out.dataMem_addr),
                   .B(MEMWB_out.dataMem_rdData),
                   .sel(MEMWB_out.ctrl[1]), //mem2reg
                   .out(wrt_data) 
                  );

    // Assigning the outputs of the Datapath to part of the instruction code
    assign opcode = IFID_out.instr_code[6:0];
    assign funct7 = IDEX_out.funct7;
    assign funct3 = IDEX_out.funct3;

endmodule
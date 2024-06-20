// Top module that initailzes the data pathway and control wires

module Processor(input logic clk
					  , input logic  reset
					  , output logic [31:0] Result  
					  );

    
    wire reg_write, mem2reg, alu_src, mem_write, mem_read, jump, branch;
    //wire stallMux;
    wire [8:0] ctrlMask, stallMux_out;
    wire [3:0] alu_cc;
    wire [6:0] opcode, funct7;
    wire [2:0] funct3;
    wire [1:0] alu_op, alu_op_ff;

    assign {alu_src, mem2reg, reg_write, mem_read, mem_write, branch, jump, alu_op} = stallMux_out;
    
    Datapath dp1(  .clk(clk),
                    .reset(reset),
                    .reg_write(reg_write),
                    .mem2reg(mem2reg),
                    .alu_src(alu_src),
                    .mem_write(mem_write),
                    .mem_read(mem_read),
					.branch(branch),
					.jump(jump),
                    .alu_cc(alu_cc),
                    .alu_op(alu_op),
                    .stallMux_sel(stallMux_sel),
                    .opcode(opcode),
                    .funct3(funct3),
                    .funct7(funct7),
                    .alu_op_ff(alu_op_ff),
                    .alu_result(Result) 
                    );

    
    Mux_2to1 #(.WIDTH(9)) stallMux( .A(ctrlMask),
                                    .B(9'b0),
                                    .sel(stallMux_sel),
                                    .out(stallMux_out)
                                    );
                    
     Controller c1( .opcode(opcode),
                    .ctrlMask(ctrlMask));
                    // .ALUSrc(alu_src),
                    // .mem2Reg(mem2reg),
                    // .memWrite(mem_write),
                    // .memRead(mem_read),
                    // .regWrite(reg_write),
					// .branch(branch),
					// .jump(jump),
                    // .ALUOp(alu_op) );
                    
     ALUController ac1( .ALUOp(alu_op_ff),
                        .funct3(funct3),
                        .funct7(funct7),
                        .operation(alu_cc) );
endmodule

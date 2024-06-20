  // Allows to more easily send data across each stage's flip-flop
  
  typedef struct packed {
    logic [7:0] PC_count;
    logic [31:0] instr_code;
  } IF_ID;

  typedef struct packed {
    logic [8:0] ctrl;     // ALUSrc, mem2Reg, regWrite, memRead, memWrite, branch, jump, ALUOp[1:0]
    logic [7:0] PC_count;
    logic [31:0] rd_data1;
    logic [31:0] rd_data2; 
    logic [31:0] ImmGen;
    logic [6:0] funct7;
    logic [2:0] funct3;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
  } ID_EX;

  typedef struct packed {
    logic [5:0] ctrl;     // mem2Reg, regWrite, memRead, memWrite, branch, jump
    logic zero;
    logic [7:0] PC_count_jump;
    logic [31:0] dataMem_addr;
    logic [31:0] wr_data;
    logic [4:0] rd;
  } EX_MEM;

  typedef struct packed { 
    logic [1:0] ctrl;     // mem2reg, regwrite
    logic [31:0] dataMem_rdData;
    logic [31:0] dataMem_addr; // was 9 bits
    logic [4:0] rd;
  } MEM_WB;
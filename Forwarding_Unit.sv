// Determines which stage to forward forward data from, 
// outputs the corresponding select line for the two 3:1 muxes that output to ALU

// Input: EX_MEM, ID_EX and MEM_WB structs. 
//        Uses EX_MEM and MEM_WB regWrite flag, 
//             EX_MEM and MEM_WB rd (register dest) property,
//             and ID_EX rs1 and rs2 properties
//
// Output: Two 2 bit select lines which control two 3:1 muxes

`include "structs.sv"

module Forwarding_Unit( input EX_MEM EX_MEM
         , input ID_EX ID_EX
         , input MEM_WB MEM_WB
			   , output logic [1:0] ForwardA
         , output logic [1:0] ForwardB
				);



  
	always_comb begin
    ForwardA = 2'b00;
    ForwardB = 2'b00;
    
    // ctrl[4] = regWrite for EX_MEM
    if ((EX_MEM.ctrl[4] & (EX_MEM.rd != 5'b0))) begin
      if (EX_MEM.rd == ID_EX.rs1)
        ForwardA = 2'b10;
      if (EX_MEM.rd == ID_EX.rs2)
        ForwardB = 2'b10;
    end

    // ctrl[0] = regWrite for MEM_WB
    if ((MEM_WB.ctrl[0] & (MEM_WB.rd != 5'b0))) begin
      if (MEM_WB.rd == ID_EX.rs1)
        ForwardA = 2'b01;
      if (MEM_WB.rd == ID_EX.rs2)
        ForwardB = 2'b01;
    end
	end
endmodule

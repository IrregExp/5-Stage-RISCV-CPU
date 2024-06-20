`include "structs.sv"

module Hazard_Detect( input IF_ID IF_ID
                    , input ID_EX ID_EX
                    , output logic stall
				            );


  // ctrl[5] = memRead
  // stall if reading mem and next instr. dependent on a value loaded from mem
  assign stall = (ID_EX.ctrl[5] & ((ID_EX.rd == IF_ID.instr_code[19:15]) | (ID_EX.rd == IF_ID.instr_code[24:20])));
  
  
endmodule

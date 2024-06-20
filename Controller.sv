// Module that represents processor control based on 7 bit opcode
// from the instructions that enables and disables parts of the processor

// Input: 7 bit opcode
// Output: wires to the various modules of the processor
//			in order as: ALUSrc, mem2Reg, regWrite, memRead, memWrite, branch, jump, ALUOp[1], ALUOp[0]
module Controller(input logic [6:0] opcode
				  , output logic [8:0] ctrlMask
				);

	
	always_comb begin
		case (opcode)
			7'b0000011: ctrlMask = 9'b111100000; // LW
			7'b0100011: ctrlMask = 9'b100010000; // SW
			7'b0010011: ctrlMask = 9'b101000011; // I-type
			7'b0110011: ctrlMask = 9'b001000010; // R-type
			7'b1100011: ctrlMask = 9'b000001001; // branch
			7'b1100111: ctrlMask = 9'b111000100; // JAL/JALR
			7'b1101111: ctrlMask = 9'b111000100; // JAL/JALR
			default: 	ctrlMask = 9'b000000000; 
		endcase
	end
endmodule

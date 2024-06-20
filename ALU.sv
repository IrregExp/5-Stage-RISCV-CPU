// Module to represent the ALU. Takes input from the registers and uses selector
// to determine the operation used

// Input: 2 32 bit registers, a 4 bit selector signal
// Output: a 32 bit output, a 32 bit value filled with 0
module ALU( input logic [31:0] rd1
			   , input logic [31:0] rd2
			   , input logic [3:0] sel
			   , output logic [31:0] ALUOut
			   , output logic zero
				);
			   
	// Used to determine whether to branch
	assign zero = (ALUOut == 32'b0);
	
	always_comb begin 
		case(sel)
			4'b0000: ALUOut = rd1 & rd2;
			4'b0001: ALUOut = rd1 | rd2;	
			4'b0010: ALUOut = rd1 + rd2;	
			4'b0110: ALUOut = rd1 - rd2;	
			default: ALUOut = rd1 + rd2;
		endcase
	end
endmodule	
			
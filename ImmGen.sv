// Module that represents the immediate generation unit. Provides the instructions
// in the correct format based on whether it's a load, store, branch, or jump instruction

// Input: 32 bit instruction code
// Output: 32 bit sign extended immediate output

module ImmGen(input logic [31:0] InstCode
				 , output logic [31:0] ImmOut
				 );

	// Sign extend immediate value based on opcode
	always_comb begin
        casex(InstCode[6:0])
				7'b00X0011: ImmOut = {{20{InstCode[31]}}, InstCode[31:20]};  // I-type / load instruction
				7'b0100011: ImmOut = {{20{InstCode[31]}}, InstCode[31:25], InstCode[11:7]}; // store instruction
				7'b1100011: ImmOut = {{20{InstCode[31]}}, InstCode[31], InstCode[7], InstCode[30:25], InstCode[11:8]}; // branch
				7'b1101111: ImmOut = {{12{InstCode[31]}}, InstCode[19:12], InstCode[20], InstCode[30:21]}; // jump
            	default : ImmOut = 32'b0;
        endcase
    end 
    
endmodule

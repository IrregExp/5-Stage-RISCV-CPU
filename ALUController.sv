// Module to represent ALU Controller. Takes in controls from the
// instructions represented by ALUOp and funct3 and 7.
// Uses these to determine the appropriate operation to be used by the ALU

// Input: 2 bit ALUOp, 7 bit funct7, 3 bit funct3
// Output: 4 bits representing the ALU logic
module ALUController(input logic [1:0] ALUOp
							, input logic [6:0] funct7
							, input logic [2:0] funct3
							, output logic [3:0] operation 
							);
    
		always_comb begin			
        casex({funct3,ALUOp})
			5'b1111X : operation = 4'b0000;     // AND operation
            5'b1101X : operation = 4'b0001;     // OR operation
            5'b00010 : if(~funct7[5])
                           operation = 4'b0010; // ADD operation
                       else
                           operation = 4'b0110; // SUB operation
            5'b00011 : operation = 4'b0010;     // ADDI operation
            5'b0XX00 : operation = 4'b0010;     // LW or SW operation
            default  : operation = 4'b0110;     // default sub operation, branch
			endcase
		end    
		
endmodule

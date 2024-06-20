`timescale 1 ps / 1 ps

module ALUController_tb();
	
	logic [1:0] ALUOp;
   logic [6:0] funct7;
   logic [2:0] funct3;
   logic [3:0] operation;
	
	
	ALUController dut(.*);
	
	
	initial begin
		// see what happens with random input
		
		ALUOp = 2'b11;
		funct7 = 7'b1111111;
		funct3 = 3'b111; #100
		
		// If ALUOp == 00,
		// operation should always be 0010
		ALUOp = 2'b00; #100 // Going off of truth table
		funct7 = 7'b0101011;
		funct3 = 3'b111; #100
		
		// 01 and 11 should both produce output of 0110
		ALUOp = 2'b01;
		funct7 = 7'b1111111;
		funct3 = 3'b111; #100
		
		funct7 = 7'b0101011;
		funct3 = 3'b111; #100
		
		ALUOp = 2'b11;
		funct7 = 7'b1111111;
		funct3 = 3'b111; #100
		
		funct7 = 7'b0101011;
		funct3 = 3'b111; #100
		
		
		
		ALUOp = 2'b10;
		funct7 = 7'b0000000;
		funct3 = 3'b000; #100   // Should output 0010
		
		
		ALUOp = 2'b11;
		funct7 = 7'b0000000;
		funct3 = 3'b000; #100 // Should output 0010
		
		
		
		ALUOp = 2'b10;
		funct7 = 7'b0100000;
		funct3 = 3'b000; #100   // Should output 0110
		
		
		ALUOp = 2'b11;
		funct7 = 7'b0100000;
		funct3 = 3'b000; #100 // Should output 0110
		
		
		ALUOp = 2'b10;
		funct7 = 7'b0000000;
		funct3 = 3'b111; #100   // Should output 0000
		
		
		ALUOp = 2'b11;
		funct7 = 7'b0000000;
		funct3 = 3'b111; #100 // Should output 0000
		
		
		ALUOp = 2'b10;
		funct7 = 7'b0000000;
		funct3 = 3'b110; #100   // Should output 0010
		
		
		ALUOp = 2'b11;
		funct7 = 7'b0000000;
		funct3 = 3'b110; #100; // Should output 0010
	end
endmodule
		
		
		
		
		
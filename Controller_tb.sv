`timescale 1 ps / 1 ps

module Controller_tb();
		
		logic [6:0] opcode;
		logic ALUSrc;
		logic mem2Reg;
		logic regWrite;
		logic memRead;
		logic memWrite;
		logic branch;
		logic jump;
		logic [1:0] ALUOp;
		
		Controller dut(.*);
		
		initial begin
			opcode = 7'b0; #100
			opcode = 7'b1100011; #200 //test SB (branch) instructions
			opcode = 7'b0110011; #150 // test R instructions
			opcode = 7'b0010011; #200 // test I instructions (immediate)
			opcode = 7'b0000011; #200 // test load instructions
			opcode = 7'b0100011; #100 // test store instructions
			opcode = 7'b1101111; #156 // test jump instruction
			opcode = 7'b1100111; #250 // test another jump instruction
			opcode = 7'b0100101; #100; // test invalid instruction
		end
endmodule
			
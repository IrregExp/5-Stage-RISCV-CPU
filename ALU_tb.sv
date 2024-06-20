`timescale 1 ps / 1 ps

module ALU_tb();

	logic [31:0] rd1;
   	logic [31:0] rd2;
   	logic [3:0] sel;
	logic [31:0] ALUOut;
	logic zero;
	
	ALU dut(.*);
	
	initial begin
		
		// Test with rd1 > rd2
		rd1 = 32'd122;
		rd2 = 32'd100;
		
		sel = 4'b0000; #100  // 96
		sel = 4'b0001; #100	 // 126
		sel = 4'b0010; #100  // 222
		sel = 4'b0110; #100  // 22
		
		// Test with rd1 < rd2
		
		rd1 = 32'd50;
		rd2 = 32'd75;
		
		sel = 4'b0000; #100  // 2
		sel = 4'b0001; #100  // 123
		sel = 4'b0010; #100	 // 125
		sel = 4'b0110; #100  // -25
		
		
		// Test with rd1 == rd2
		
		rd1 = 32'd128;
		rd2 = 32'd128;
		
		sel = 4'b0000; #100  // 128
		sel = 4'b0001; #100  // 128
		sel = 4'b0010; #100	 // 256
		sel = 4'b0110; #100  // 0
		
		// check non subtraction also results in "zero" assertion
		rd1 = 32'b0101;
		rd2 = 32'b1010;
		sel = 4'b0000; #100;
		
	end
endmodule
		
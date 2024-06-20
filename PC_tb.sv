`timescale 1 ps / 1 ps

module PC_tb();
	logic clk;
	logic reset;
	logic [7:0] PC_in;
	logic [7:0] PC_out;
	
	PC dut (.*);
	

	
	// Creates a clock with a frequency of 50MHz
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 1;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		reset = 1; #50
		reset = 0;
		
		PC_in = 32'd4; #100
		
		PC_in = 32'd16; #100
		
		
		PC_in = 32'd32; #100
		
		$finish;
		
	end
endmodule
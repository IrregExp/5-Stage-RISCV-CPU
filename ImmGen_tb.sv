`timescale 1 ps / 1 ps

module ImmGen_tb();
	logic [31:0] InstCode;
	logic [31:0] ImmOut;
	
	ImmGen dut(.*);
	
	initial begin
		InstCode = 32'h00058283; #100 //load
		InstCode = 32'h00150513; #100 //i type (imm)
		InstCode = 32'hfedff06f; #150 //j
		InstCode = 32'h00550023; #100 //store
		InstCode = 32'h00028863; #200; // SB type (branch)
	
	end
endmodule

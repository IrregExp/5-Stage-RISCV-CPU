`timescale 1ns / 1ps

//tests the RISC-V processor by comparing the test bench result to the
//processor's output. A correct processor outupt, gives a point.
//The testbench must give a total of 20 points to verify the processor.

module Processor_tb( );

    // inputs
    logic clk; 
    logic rst; 

    // outputs
    logic [31:0] tb_Result; 

    Processor dut(
        .clk(clk),
        .reset(rst),
        .Result(tb_Result)
    );

	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 1;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end

	initial begin 
		rst = 0; #100;
		rst = 1; #100;
		rst = 0; #100;
		#20000;
		$finish; 
   end


endmodule

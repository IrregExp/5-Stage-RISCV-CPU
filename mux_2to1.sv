// Module that represents MUX. Takes in two input and a selector signal
// Outputs an input signal based on the selector signal

// Input: two 32 bit values, a selector signal
// Output: one 32 bit value

module Mux_2to1 #(parameter WIDTH = 32) 
	(input logic [WIDTH-1:0] A
	, input logic [WIDTH-1:0] B
	, input logic sel
	, output logic [WIDTH-1:0] out
	);

	assign out = sel ? B:A;
    
endmodule

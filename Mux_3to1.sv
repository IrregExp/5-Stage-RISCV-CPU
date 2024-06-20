// Module that represents MUX. Takes in 3 input and a selector signal
// Outputs an input signal based on the selector signal

// Input: three 32 bit values, a 2 bit selector signal
// Output: one 32 bit value

module Mux_3to1 ( input logic [31:0] A
                , input logic [31:0] B
                , input logic [31:0] C
                , input logic [1:0] sel
                , output logic [31:0] out
                );

    always_comb begin
        case (sel)
            2'b00: out = A;
            2'b01: out = B;
            2'b10: out = C;
            default: out = 31'b0;
        endcase
    end
endmodule
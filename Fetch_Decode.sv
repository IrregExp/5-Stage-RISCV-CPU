// Flip flop for the fetch/decode stage.
//
// input: clock, reset, flush and IFID struct. Reset and flush both set output struct properties to 0
// output: The output struct. Either all struct properties are set to 0, or the same as the input struct.

`include "structs.sv"

module Fetch_Decode(input logic clk
            , input logic reset
            , input logic stall
            , input logic flush
            , input IF_ID IFID_in
            , output IF_ID IFID_out
            );

    always_ff @(posedge clk) begin
        if (reset | flush) begin
            IFID_out.PC_count <= 8'b0;
            IFID_out.instr_code <= 32'b0;
        end else begin
            if (~stall)
                IFID_out <= IFID_in;
        end
    end
endmodule
                
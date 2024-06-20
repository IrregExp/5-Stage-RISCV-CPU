// Flip flop for the decode/execute stage.
//
// input: clock, reset, flush and IDEX struct. Reset and flush both set output struct properties to 0
// output: The output struct. Either all struct properties are set to 0, or the same as the input struct.
`include "structs.sv"
module Decode_Execute(input logic clk
               , input logic reset
               , input logic flush
               , input ID_EX IDEX_in
               , output ID_EX IDEX_out
            );

    always_ff @(posedge clk) begin  
        if (reset | flush) begin
            IDEX_out.ctrl <= 9'b0;
            IDEX_out.PC_count <= 8'b0;
            IDEX_out.rd_data1 <= 32'b0;
            IDEX_out.rd_data2 <= 32'b0;
            IDEX_out.ImmGen <= 32'b0;
            IDEX_out.funct7 <= 7'b0;
            IDEX_out.funct3 <= 3'b0;
            IDEX_out.rs1 <= 5'b0;
            IDEX_out.rs2 <= 5'b0;
            IDEX_out.rd <= 5'b0;
        end else begin
            IDEX_out <= IDEX_in;
        end
    end
endmodule
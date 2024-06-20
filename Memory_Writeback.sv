// Flip flop for the memory/writeback stage.
//
// input: clock and reset and MEMWB struct. Reset and flush both set output struct properties to 0
// output: The output struct. Either all struct properties are set to 0, or the same as the input struct.

`include "structs.sv"

module Memory_Writeback(input logic clk
                        , input logic reset
                        , input MEM_WB MEMWB_in
                        , output MEM_WB MEMWB_out
                        );
    
    always_ff @(posedge clk) begin
        if (reset) begin
            MEMWB_out.ctrl <= 2'b0;
            MEMWB_out.dataMem_rdData <= 32'b0;
            MEMWB_out.dataMem_addr <= 9'b0;
            MEMWB_out.rd <= 5'b0;
        end else begin
            MEMWB_out <= MEMWB_in;
        end
    end
endmodule

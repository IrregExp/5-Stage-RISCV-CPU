// Flip flop for the execute/memory stage.
//
// input: clock, reset, flush and EXMEM struct. Reset and flush both set output struct properties to 0
// output: The output struct. Either all struct properties are set to 0, or the same as the input struct.

`include "structs.sv"

module Execute_Memory(input logic clk
                     , input logic reset
                     , input logic flush
                     , input EX_MEM EXMEM_in
                     , output EX_MEM EXMEM_out
                     );

    always_ff @(posedge clk) begin
        if (reset | flush) begin
            EXMEM_out.ctrl <= 6'b0;
            EXMEM_out.zero <= 1'b0;
            EXMEM_out.PC_count_jump <= 8'b0;
            EXMEM_out.dataMem_addr <= 32'b0;
            EXMEM_out.wr_data <= 32'b0;
            EXMEM_out.rd <= 5'b0;
        
        end else begin 
            EXMEM_out <= EXMEM_in;
        end
    end
endmodule
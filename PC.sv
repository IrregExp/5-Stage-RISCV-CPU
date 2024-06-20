// Module that represents the program counter (pc): increments the instructions
// address every clock cycle to the next address

// Input: takes in the clock, reset signal and current 8 bit instruction address
// Output: next 8 bit instruction address

module PC(input logic clk
					, input logic reset
                    , input logic stall
					, input logic [7:0] PC_in
					, output logic [7:0] PC_out 
					);
					
    // On the posedge of the clk, if reset q will get 0 for a synchronous reset
    // else q will get the input of d.
    always_ff @(posedge clk) begin
        if(reset)
            PC_out <= 8'b0;
        else begin
            if (~stall)
                PC_out <= PC_in;
        end
    end
    
endmodule

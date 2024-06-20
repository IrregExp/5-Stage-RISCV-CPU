// Module to represent the data memory.

// Input: clock and reset signals, read signal (checks valid or invalid),
// write address and 32 bit data
// Output: 32 bit read data from memory

module DataMem(input logic clk
					, input logic reset
					, input logic memRead
					, input logic memWrite
					, input logic [8:0] addr 
					, input logic [31:0] wr_data
					, output logic [31:0] rd_data );
	
	logic [31:0] RAM [127:0];


    // For any changes to occur if MemWrite is active then the desired RAM register 
    // will get the data of write_data
	always_ff @(posedge clk) begin 
		if (reset) begin
			for (integer i = 0; i < 128; i = i+1) 
				RAM[i] <= 32'b0;
		end else begin
        	if(memWrite)
            	RAM[addr] <= wr_data;
		end
    end

	always_comb begin
		if (memRead) 
			rd_data = RAM[addr];
		else 
			rd_data = 32'b0;
	end
         
endmodule

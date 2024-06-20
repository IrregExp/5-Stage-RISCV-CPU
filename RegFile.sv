// Module that represents a register: values can be read or written to registers.
// write is based on the write enabler.

// Input: address of write register, 32 bit data to be written,
//				clock module, reset, and enable signal for writing
// Output: 32 bit read register contents

module RegFile(input logic clk
				, input logic reset
				, input logic wr_en
				, input logic [4:0] rd_addr1
				, input logic [4:0] rd_addr2
				, input logic [4:0] wr_addr
				, input logic [31:0] wr_data
				, output logic [31:0] rd_data1
				, output logic [31:0] rd_data2 
				);
               

		logic [31:0] register [31:0];
		
		always_ff @(negedge clk) begin
			if (reset) begin
				for (integer i =0; i < 32; i = i+1)
					register[i] <= 32'b0;
			end else begin
				if (wr_en)
					register[wr_addr] <= wr_data;
			end
		end


    // Read the desire register
    assign rd_data1 = register[rd_addr1];
    assign rd_data2 = register[rd_addr2];
    
endmodule

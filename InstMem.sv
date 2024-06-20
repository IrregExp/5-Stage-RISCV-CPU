// Module that represents instruction memory. Has pre-loaded instructions, uses
// program counter to increment through pre-loaded instructions.

// Input: 8 bit instruction address
// Output: 32 bit instruction

module InstMem(input logic [7:0] addr
					, output logic [31:0] instruction 
					);
    
	 logic [31:0] ROM [63:0];
    
    // The instruction code the RISC-V processor will execute
    initial begin
		
		// Testing basic flush
		ROM[0] = 32'h00c08093; // addi x1, x1, 12
		ROM[1] = 32'h00010463; // beqz x2, ROM[3]
		ROM[2] = 32'h00f10113; // addi x2, x2, 15
		ROM[3] = 32'h00103023; // sd x1, 0(x0)
		
		// Test showing j and beq functionality
		// ROM[0] = 32'h07e08093; // addi x1, x1, 126
		// ROM[1] = 32'h03510113; // addi x2, x2, 53
		// ROM[2] = 32'h0020f1b3; // and x3, x1, x2 result = 52
		
		// ROM[3] = 32'h0100006f; // j rom[7]
		
		// ROM[4] = 32'h03420213; // addi x4, x4, 52
		// ROM[5] = 32'h00418463; // beq x3, x4 rom[7]
		// ROM[6] = 32'hfff28293; // addi x5, x5, -1
		// ROM[7] = 32'h00200023; // sb x2, 0(x0)
		// ROM[8] = 32'h00000403; // lb x8, 0(x0)

				
  		// Show working stall logic and forwarding
 	 	// ROM[0] = 32'h01608093; // addi x1, x1, 22
  		// ROM[1] = 32'h02310113; // addi x2, x2, 35
  		// ROM[2] = 32'h00203023; // sd x2, 0(x0)
  		// ROM[3] = 32'h00003203; // ld x4, 0(x0)
  		// ROM[4] = 32'h00208333; // add x6, x1, x2
  		// ROM[5] = 32'h001030a3; // sd x1, 1(x0)

  		// Test showing looping behavior
		// ROM[0] = 32'h00c08093; // addi x1, x1, 12
		// ROM[1] = 32'h01110113; // addi x2, x2, 17
		// ROM[2] = 32'h01d18193; // addi x3, x3, 29
		// ROM[3] = 32'h00100023; // sb x1, 0(x0)
		// ROM[4] = 32'h002000a3; // sb x2, 1(x0)
		// ROM[5] = 32'h00300123; // sb x3, 2(x0)
		// ROM[6] = 32'hfff08093; // addi, x1, x1, -1
		// ROM[7] = 32'h00008463; // beqz x1, rom [9]
		// ROM[8] = 32'hff9ff06f; // j rom[6]
		// ROM[9] = 32'h00000013;  // nop



    end
    
    // Retriving the instruction code based on the PC count
    assign instruction = ROM[addr[7:2]];

endmodule

# 5-Stage-RISCV-CPU

## This program implements a 5 cycle pipelined RISCV 32 bit CPU. The instructions implemented are:
	* R-type (ADD, OR, AND, SUB)
	* I-type (ADDI, ORI, ANDI, SUBI)
	* Load/Store operations (SW, SL)
	* Conditional branches (BEQ)
	* Unconditional branches (J)

Using the block diagram shown in "Computer Organization and Design RISC-V Edition" on
page 699, along with the supporting documentation presented throughout the book on the
subject, the following modules were created:

	* Program Counter (simple 8 bit flip-flop)
	* 32x64 Instruction Memory (ROM, where instructions are manually added)
	* 32x32 Register file
	* Immediate generator (parses the appropriate Imm bits, based on opcode)
	* 32 bit 4 operation (AND, OR, add and subtract) ALU
	* 32x128 Data Memory (RAM, where data is saved for store and added to register
				in load instructions)
	* Multiple 2 to 1 muxes
	* Two 3 to 1 muxes
	* Hazard control unit, to determine if a stall should occur
	* Forwarding unit, to forward correct data to ALU before it can be accessed in refile
	* Fetch/Decode, Decode/Execute, Execute/Memory, Memory/Writeback flip flops that either
	  pass previous struct through on next clock cycle, or sets all struct properties to 0
	  depending on reset and flush conditions.
	* structs that are used to simplify passing data between stages.

The image labeled "TestShowingBEQZ" shows that no value is ever saved into x2, as it is currently 0.
Also in this image, we can see the instructions passing through each flip flop after every clock cycle

The image labeled "TestShowingFlush" shows the flush signal being asserted when the correct condition is met.

Assembly: 

Test used to show branching behavior, used in "TestShowingBEQZ" and "TestShowingFlush"
```
addi x1, x1, 12
beqz x2, ROM[3]
addi x2, x2, 15
sd x1, 0(x0)
```

Show working stall logic and forwarding
```
addi x1, x1, 22
addi x2, x2, 35
sd x2, 0(x0)
ld x4, 0(x0)
add x6, x1, x2
sd x1, 1(x0)
```

Test showing looping behavior
```
addi x1, x1, 12
addi x2, x2, 17
addi x3, x3, 29
sb x1, 0(x0)
sb x2, 1(x0)
sb x3, 2(x0)
x1, x1, -1
beqz x1, rom [9] 	// rom[9] = nop
j rom[6]		// rom[6] = addi, x1, x1, -1
nop
```

Test showing j and beq functionality
```
addi x1, x1, 126
addi x2, x2, 53
and x3, x1, x2 result = 52


j rom[7]		// rom[7] = sb x2, 0(x0)
addi x4, x4, 52
beq x3, x4 rom[7]	// rom[7] = sb x2, 0(x0)
addi x5, x5, -1
sb x2, 0(x0)
lb x8, 0(x0)
```
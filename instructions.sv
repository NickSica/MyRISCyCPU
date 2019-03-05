`define LOAD	 7'b0000011
`define MISC-MEM 7'b0001111
`define OP-IMM   7'b0010011
`define AUIPC	 7'b0010111
`define STORE    7'b1000011
`define OP  	 7'b1010011
`define LUI	 	 7'b1010111
`define BRANCH   7'b1100011
`define JALR     7'b1100111
`define JAL		 7'b1101111
`define SYSTEM   7'b1110011

// R-Type
// | 31:25  | 24:20 | 19:15 | 14:12  | 11:7 | 6:0    |
// | funct7 | rs2   | rs1   | funct3 | rd   | opcode |
// OP-CODE = 

// I-Type
// | 31:20     | 19:15 | 14:12  | 11:7 | 6:0    |
// | imm[11:0] | rs1   | funct3 | rd   | opcode |
// OP-CODE = OP-IMM, 



// S-Type
// | 31:25     | 24:20 | 19:15 | 14:12  | 11:7     | 6:0    |
// | imm[11:5] | rs2   | rs1   | funct3 | imm[4:0] | opcode |
// OP-CODE = 

// S-Type
// | 31:25     | 24:20 | 19:15 | 14:12  | 11:7     | 6:0    |
// | imm[11:5] | rs2   | rs1   | funct3 | imm[4:0] | opcode |
// OP-CODE = 

// U-Type
// | 31:12      | 11:7 | 6:0    |
// | imm[31:12] | rd   | opcode |
// OP-CODE = 

// S-Type
// | 31:25     | 24:20 | 19:15 | 14:12  | 11:7     | 6:0    |
// | imm[11:5] | rs2   | rs1   | funct3 | imm[4:0] | opcode |
// OP-CODE = 
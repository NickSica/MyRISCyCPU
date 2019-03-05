

`define LOAD	 7'b0000011
`define MISC-MEM 7'b0001111
`define OP-IMM   7'b0010011
`define AUIPC	 7'b0010111
`define OP  	 7'b0110011
`define LUI	 	 7'b0110111
`define STORE    7'b0100011
`define BRANCH   7'b1100011
`define JALR     7'b1100111
`define JAL		 7'b1101111
`define SYSTEM   7'b1110011

/* LUI(0110111) U-Type
 **ex 31:12         11:7    6:0
 **** imm[31:12]    rd      0110111 | LUI 
*/

/* AUIPC(0010111) U-Type
 **ex 31:12         11:7    6:0
 **** imm[31:12]    rd      0010111 | AUIPC
*/

/* JAL(1101111) J-Type
 **ex 31:12                        11:7    6:0
 **** imm[20|10 : 1|11|19 : 12]    rd      1101111 | JAL 
*/

/* JALR(1100111) I-Type
 **ex 31:20        19:15    14:12     11:7    6:0    
 **** imm[11:0]    rs1      000       rd      1100111 | JALR 
*/

/* BRANCH(1100011) B-Type
 **ex 31:25        24:20 19:15 14:12  11:7        6:0
 **ex imm[12|10:5] rs2   rs1   funct3 imm[4:1|11] 1100011 |
 ****                           000                       | BEQ 
 ****                           001                       | BNE 
 ****                           100                       | BLT 
 ****                           101                       | BGE 
 ****                           110                       | BLTU 
 ****                           111                       | BGEU
*/

/* LOAD(0000011) I-Type
 **ex 31:20        19:15    14:12     11:7    6:0    
 **ex imm[11:0]    rs1      funct3    rd      0000011 |
 ****                        000                      | LB 
 ****                        001                      | LH 
 ****                        010                      | LW 
 ****                        100                      | LBU 
 ****                        101                      | LHU 
*/

/* STORE(0100011)
imm[11:5] rs2 rs1 000 imm[4:0] 0100011 SB 
imm[11:5] rs2 rs1 001 imm[4:0] 0100011 SH 
imm[11:5] rs2 rs1 010 imm[4:0] 0100011 SW 
*/

/* OP-IMM(0010011) I-Type
 **ex 31:20            19:15    14:12     11:7    6:0    
 **ex imm[11:0]        rs1      funct3    rd      0010011 |
 ****                            000                      | ADDI 
 ****                            010                      | SLTI 
 ****                            011                      | SLTIU 
 ****                            100                      | XORI 
 ****                            110                      | ORI 
 ****                            111                      | ANDI 
 **** 0000000 shamt              001                      | SLLI 
 **** 0000000 shamt              101                      | SRLI 
 **** 0100000 shamt              101                      | SRAI
*/

/* OP(0110011) R-Type
 **ex 31:25      24:20    19:15    14:12  |  11:7    6:0    
 **ex funct7     rs2      rs1      funct3    rd      0110011 |
 **** 0000000                       000                      | ADD 
 **** 0100000                       000                      | SUB 
 **** 0000000                       001                      | SLL 
 **** 0000000                       010                      | SLT 
 **** 0000000                       011                      | SLTU 
 **** 0000000                       100                      | XOR 
 **** 0000000                       101                      | SRL 
 **** 0100000                       101                      | SRA 
 **** 0000000                       110                      | OR 
 **** 0000000                       111                      | AND 
*/

/* MISC-MEM(0001111) 
 **** 0000 pred succ 00000 000 00000 0001111 FENCE 
 **** 0000 0000 0000 00000 001 00000 0001111 FENCE.I 
 
*/

/* SYSTEM(1110011) I-Type
 **ex 31:20           19:15    14:12     11:7     6:0    
 **ex imm[11:0]       rs1      funct3    rd       1110011 |
 **** 000000000000    00000     000      00000            | ECALL 
 **** 000000000001    00000     000      00000            | EBREAK
 ****                           001                       | CSRRW 
 ****                           010                       | CSRRS 
 ****                           011                       | CSRRC 
 ****                 zimm      101                       | CSRRWI 
 ****                 zimm      110                       | CSRRSI 
 ****                 zimm      111                       | CSRRCI
*/



// R-Type
// | 31:25  | 24:20 | 19:15 | 14:12  | 11:7 | 6:0    |
// | funct7 | rs2   | rs1   | funct3 | rd   | opcode |


// I-Type
// | 31:20     | 19:15 | 14:12  | 11:7 | 6:0    |
// | imm[11:0] | rs1   | funct3 | rd   | opcode |


// S-Type
// | 31:25     | 24:20 | 19:15 | 14:12  | 11:7     | 6:0    |
// | imm[11:5] | rs2   | rs1   | funct3 | imm[4:0] | opcode |


// S-Type
// | 31:25     | 24:20 | 19:15 | 14:12  | 11:7     | 6:0    |
// | imm[11:5] | rs2   | rs1   | funct3 | imm[4:0] | opcode |


// U-Type
// | 31:12      | 11:7 | 6:0    |
// | imm[31:12] | rd   | opcode |
 

// S-Type
// | 31:25     | 24:20 | 19:15 | 14:12  | 11:7     | 6:0    |
// | imm[11:5] | rs2   | rs1   | funct3 | imm[4:0] | opcode |


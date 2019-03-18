enum logic[6:0] 
{
    LOAD     = 7'b0000011,
    MISC_MEM = 7'b0001111,
    OP_IMM   = 7'b0010011,
    AUIPC	 = 7'b0010111,
    OP  	 = 7'b0110011,
    LUI	 	 = 7'b0110111,
    STORE    = 7'b0100011,
    BRANCH   = 7'b1100011,
    JALR     = 7'b1100111,
    JAL		 = 7'b1101111,
    SYSTEM   = 7'b1110011
} opcode;

enum logic[31:0] 
{
    LUI      = 32'b????????????????????_?????_0110111,
    AUIPC	 = 32'b????????????????????_?????_0010111,
    JAL		 = 32'b????????????????????_?????_1101111,
    JALR     = 32'b????????????_?????_000_?????_1100111,
    //BRANCH Instructions
    BEQ      = 32'b???????_?????_?????_000_?????_1100011,
    BNE      = 32'b???????_?????_?????_001_?????_1100011,
    BLT      = 32'b???????_?????_?????_100_?????_1100011,
    BGE      = 32'b???????_?????_?????_101_?????_1100011,
    BLTU     = 32'b???????_?????_?????_110_?????_1100011,
    BGEU     = 32'b???????_?????_?????_111_?????_1100011,
    //LOAD Instructions
    LB       = 32'b????????????_?????_000_?????_0000011,
    LH       = 32'b????????????_?????_001_?????_0000011,
    LW       = 32'b????????????_?????_010_?????_0000011,
    LBU      = 32'b????????????_?????_100_?????_0000011,
    LHU      = 32'b????????????_?????_101_?????_0000011,
    //STORE Instructions
    SB       = 32'b???????_?????_?????_000_?????_0100011,
    SH       = 32'b???????_?????_?????_001_?????_0100011,
    SW       = 32'b???????_?????_?????_010_?????_0100011,
    //OP-IMM Instructions
    ADDI     = 32'b????????????_?????_000_?????_0010011,
    SLTI     = 32'b????????????_?????_010_?????_0010011,
    SLTIU    = 32'b????????????_?????_011_?????_0010011,
    XORI     = 32'b????????????_?????_100_?????_0010011,
    ORI      = 32'b????????????_?????_110_?????_0010011,
    ANDI     = 32'b????????????_?????_111_?????_0010011,
    SLLI     = 32'b0000000_?????_?????_001_?????_0010011,
    SRLI     = 32'b0000000_?????_?????_101_?????_0010011,
    SRAI     = 32'b0100000_?????_?????_101_?????_0010011,
    //OP Instructions
    ADD  	 = 32'b0000000_?????_?????_000_?????_0110011,
    SUB  	 = 32'b0100000_?????_?????_000_?????_0110011,
    SLL  	 = 32'b0000000_?????_?????_001_?????_0110011,
    SLT  	 = 32'b0000000_?????_?????_010_?????_0110011,
    SLTU  	 = 32'b0000000_?????_?????_011_?????_0110011,
    XOR  	 = 32'b0000000_?????_?????_100_?????_0110011,
    SRL  	 = 32'b0000000_?????_?????_101_?????_0110011,
    SRA  	 = 32'b0100000_?????_?????_101_?????_0110011,
    OR  	 = 32'b0000000_?????_?????_110_?????_0110011,
    AND  	 = 32'b0000000_?????_?????_111_?????_0110011,
    //MISC-MEM Instructions
    FENCE    = 32'b????_????_????_00000_000_00000_0001111,
    FENCE_I  = 32'b0000_0000_0000_00000_001_00000_0001111,
    //SYSTEM Instructions
    ECALL    = 32'b000000000000_00000_000_00000_1110011,
    EBREAK   = 32'b000000000001_00000_000_00000_1110011,
    CSRRW    = 32'b????????????_?????_001_?????_1110011,
    CSRRS    = 32'b????????????_?????_010_?????_1110011,
    CSRRC    = 32'b????????????_?????_011_?????_1110011,
    CSRRWI   = 32'b????????????_?????_101_?????_1110011,
    CSRRSI   = 32'b????????????_?????_110_?????_1110011,
    CSRRCI   = 32'b????????????_?????_111_?????_1110011
} assembly_cmds;

interface instr_ports();
    logic[31:0] instruction;
    assembly_cmds asm;

    logic[4:0] pc;
    logic[31:0] imm;

    logic[4:0] rs1;
    logic[4:0] rs2;
    logic[31:0] rs1_val;
    logic[31:0] rs2_val;
    logic[0] r1_en;
    logic[0] r2_en;

    logic[4:0] rd;
    logic[31:0] rd_val;
    logic[4:0] mem_rd;
    logic[4:0] wb_rd;
    logic[31:0] wb_rd_val;
    logic[0] w_en;
    logic[4:0] w_addr;
    logic[31:0] w_data;

    logic[0] csrr_en;
    logic[0] csrw_en;
    logic[11:0] csrr_addr;
    logic[11:0] csrw_addr;
    logic[31:0] csrr_data;
    logic[31:0] csrw_data;


    modport fetch(
        inout pc,
        
        output instruction,
        output asm
    );

    modport decode(
        input instruction,
        input asm,
        output rd,
        output rs1,
        output rs2,
        output r1_en,
        output r2_en
    );
    
    modport exec(
        inout pc,
        
        input rs1_val,
        input rs2_val,
        input rd,
        input mem_rd_val,
        input asm,
        input imm,

        output rd_val,
        output mem_rd
    );

    modport mem(
        output wb_rd,
        output wb_rd_val
    );

    modport wb(
        input wb_rd,
        input wb_rd_val
    );

    modport reg_file(
        input r1_en,
        input rs1,
        input r2_en,
        input rs2,
        input w_en,
        input w_addr,
        input w_data,

        output rs1_val,
        output rs2_val
    );

    modport csr_file(
        inout csrr_en,
        inout csrw_en,
        input csrr_addr,
        input csrw_addr,
        input csrw_data,

        output csrr_data
    );
endinterface: instr_ports

interface ctl_flags();
    logic[0] bypass;
    logic[0] is_ls;
    logic[35:0] ls_type_reg;
    
endinterface: ctl_flags

module CPU(
    input logic clk,
    input logic[31:0] encoded_value,
    flags.sink fsrc);
    //TODO: Implement flags to check for stalling/killing new instructions for branch, jump, etc
    //      Error checking for misaligned instruction fetch due to jump (pg 16)
    assign ctl_flags.bypass = (2'(instr_ports.rs1 == mem_rd) | (2'(instr_ports.rs2 == mem_rd) << 1)) ^ 2'b0;  
    
    InstructionFetch instr_fetch(.clk(clk), .ports(instr_ports.fetch));
    Decode decode(.bypass(bypass), .ports(instr_ports.decode), .flags(instr_ports.ctl_flags));
    Execute execute(.ports(instr_ports.exec));
    MemoryAccess mem_access(.ports(instr_ports.mem));
    //Writeback writeback(.ports(instr_ports.wb));
    RegisterFile reg_file(.clk(clk), .ports(instr_ports.reg_file));
    CSRFile csr_file(.clk(clk), .ports(instr_ports.csr_file));
endmodule: CPU

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
 **** csr             rs1       001      rd               | CSRRW 
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

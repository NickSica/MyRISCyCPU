enum logic[6:0] 
{
    LOAD     = 7'b0000011
    MISC-MEM = 7'b0001111
    OP-IMM   = 7'b0010011
    AUIPC	 = 7'b0010111
    OP  	 = 7'b0110011
    LUI	 	 = 7'b0110111
    STORE    = 7'b0100011
    BRANCH   = 7'b1100011
    JALR     = 7'b1100111
    JAL		 = 7'b1101111
    SYSTEM   = 7'b1110011
} opcode;

enum logic[31:0] 
{
    LUI      = 32'b????????????????????_?????_0110111
    AUIPC	 = 32'b????????????????????_?????_0010111
    JAL		 = 32'b????????????????????_?????_1101111
    JALR     = 32'b????????????_?????_000_?????_1100111
    //BRANCH Instructions
    BEQ      = 32'b???????_?????_?????_000_?????_1100011
    BNE      = 32'b???????_?????_?????_001_?????_1100011
    BLT      = 32'b???????_?????_?????_100_?????_1100011
    BGE      = 32'b???????_?????_?????_101_?????_1100011
    BLTU     = 32'b???????_?????_?????_110_?????_1100011
    BGEU     = 32'b???????_?????_?????_111_?????_1100011
    //LOAD Instructions
    LB       = 32'b????????????_?????_000_?????_0000011
    LH       = 32'b????????????_?????_001_?????_0000011
    LW       = 32'b????????????_?????_010_?????_0000011
    LBU      = 32'b????????????_?????_100_?????_0000011
    LHU      = 32'b????????????_?????_101_?????_0000011
    //STORE Instructions
    SB       = 32'b???????_?????_?????_000_?????_0100011
    SH       = 32'b???????_?????_?????_001_?????_0100011
    SW       = 32'b???????_?????_?????_010_?????_0100011
    //OP-IMM Instructions
    ADDI     = 32'b????????????_?????_000_?????_0010011
    SLTI     = 32'b????????????_?????_010_?????_0010011
    SLTIU    = 32'b????????????_?????_011_?????_0010011
    XORI     = 32'b????????????_?????_100_?????_0010011
    ORI      = 32'b????????????_?????_110_?????_0010011
    ANDI     = 32'b????????????_?????_111_?????_0010011
    SLLI     = 32'b0000000_?????_?????_001_?????_0010011
    SRLI     = 32'b0000000_?????_?????_101_?????_0010011
    SRAI     = 32'b0100000_?????_?????_101_?????_0010011
    //OP Instructions
    ADD  	 = 32'b0000000_?????_?????_000_?????_0110011
    SUB  	 = 32'b0100000_?????_?????_000_?????_0110011
    SLL  	 = 32'b0000000_?????_?????_001_?????_0110011
    SLT  	 = 32'b0000000_?????_?????_010_?????_0110011
    SLTU  	 = 32'b0000000_?????_?????_011_?????_0110011
    XOR  	 = 32'b0000000_?????_?????_100_?????_0110011
    SRL  	 = 32'b0000000_?????_?????_101_?????_0110011
    SRA  	 = 32'b0100000_?????_?????_101_?????_0110011
    OR  	 = 32'b0000000_?????_?????_110_?????_0110011
    AND  	 = 32'b0000000_?????_?????_111_?????_0110011
    //MISC-MEM Instructions
    FENCE    = 32'b0000_????_????_00000_000_00000_0001111
    FENCE_I  = 32'b0000_0000_0000_00000_001_00000_0001111
    //SYSTEM Instructions
    ECALL    = 32'b000000000000_00000_000_00000_1110011
    EBREAK   = 32'b000000000001_00000_000_00000_1110011
    CSRRW    = 32'b????????????_?????_001_?????_1110011
    CSRRS    = 32'b????????????_?????_010_?????_1110011
    CSRRC    = 32'b????????????_?????_011_?????_1110011
    CSRRWI   = 32'b????????????_?????_101_?????_1110011
    CSRRSI   = 32'b????????????_?????_110_?????_1110011
    CSRRCI   = 32'b????????????_?????_111_?????_1110011
} assembly_cmds;

module ControlPath
    (input logic[31:0] instruction);
    
    logic[3:0] operation;
    logic[31:0] op1, op2, op_out;

    assign assembly_cmds asm <= instruction;



    always_comb begin
        case(instruction)
            LUI     : 
            AUIPC   :
            JAL     :
            JALR    :
            //BRANCH Instructions
            BEQ     :
            BNE     :
            BLT     :
            BGE     :
            BLTU    :
            BGEU    :
            //LOAD Instructions
            LB      :
            LH      :
            LW      :
            LBU     :
            LHU     :
            //STORE Instructions
            SB      : 
            SH      : 
            SW      : 
            //OP-IMM Instructions
            ADDI    : 
            SUBI    :
            SLTI    : 
            SLTIU   : 
            XORI    : 
            ORI     : 
            ANDI    : 
            SLLI    : 
            SRLI    : 
            SRAI    : 
            //OP Instructions
            ADD: 
                operation <= 4'b0000;
                op1 <= 
            SUB: 
            SLL: op_out = op1 << op2; 
            SLT: op_out = (signed'(op1) < signed'(op2) ? 32'b1 : 32'b0);
            SLTU: op_out = (op1 < op2 ? 32'b1 : 32'b0);
            XOR: op_out = op1 ^ op2;
            SRL: op_out = op1 >> op2;
            SRA: op_out = op1 >>> op2;
            OR: op_out = op1 | op2;
            AND: op_out = op1 & op2;
            //MISC-MEM Instructions
            FENCE   :
            FENCE_I :
            //SYSTEM Instructions
            ECALL   :
            EBREAK  :
            CSRRW   :
            CSRRS   :
            CSRRC   :
            CSRRWI  :
            CSRRSI  :
            CSRRCI  :
            default: op_out = 'z
    end //always_comb

    

    
    Alu alu(.*);

endmodule: ControlPath

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


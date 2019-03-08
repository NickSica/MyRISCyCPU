

module Decode(instr_ports.decode ports);
    always_comb begin
        case(ports.asm)
            //U-Type
            LUI, AUIPC:
                stage2_rd <= ports.instruction[11:7];
                rs1 <= 5'bx;
                rs2 <= 5'bx;
                imm <= {ports.instruction[31:12], 12'b0};
            
            //J-Type
            JAL:
                stage2_rd <= ports.instruction[11:7];
                rs1 <= 5'bx;
                rs2 <= 5'bx;
                imm <= {12{ports.instruction[31]}, ports.instruction[19:12], ports.instruction[20], ports.instruction[30:21]};
            
            //I-Type
            JALR, LB, LH, LW, LBU, LHU, ADDI, SUBI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, CSRRW, CSRRS, CSRRC, CSRRWI, CSRRSI, CSRRCI:
                stage2_rd <= ports.instruction[11:7];
                rs1 <= ports.instruction[19:15];
                rs2 <= 5'bx;
                imm <= {21{ports.instruction[31]}, ports.instruction[30:20]};
            
            //B-Type
            BEQ, BNE, BLT, BGE, BLTU, BGEU:
                stage2_rd <= 5'bx;
                rs1 <= ports.instruction[19:15];
                rs2 <= ports.instruction[24:20];
                imm <= {20{ports.instruction[31]}, ports.instruction[7], ports.instruction[30:25], ports.instruction[11:8], 1'b0};
            
            //S-Type
            SB, SH, SW: 
                stage2_rd <= 5'bx;
                rs1 <= ports.instruction[19:15];
                rs2 <= ports.instruction[24:20];
                imm <= {21{ports.instruction[31]}, ports.instruction[30:25], ports.instruction[11:7]};
            
            //R-Type
            ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND:            
                stage2_rd <= ports.instruction[11:7];
                rs1 <= ports.instruction[19:15];
                rs2 <= ports.instruction[24:20];
                imm <= 31'bx;

            //Weird Types
            FENCE, FENCE_I:
                stage2_rd <= 5'b0;
                rs1 <= 5'b0;
                rs2 <= ports.instruction[23:20];
                imm <= ports.instruction[27:24];
            ECALL:
                stage2_rd <= 5'b0;
                rs1 <= 5'b0;
                rs2 <= 5'bx;
                imm <= 31'b0;
            EBREAK:
                stage2_rd <= 5'b0;
                rs1 <= 5'b0;
                rs2 <= 5'bx;
                imm <= 31'b1;
        
            default:
                stage2_rd <= 5'bx;
                rs1 <= 5'bx;
                rs2 <= 5'bx;
                imm <= 32'bx;
    end //always_comb
endmodule: Decode


module Decode(instr_ports.decode ports);
    always_comb begin
        case(ports.asm)
            //U-Type
            LUI, AUIPC:
                ports.rd0 <= ports.instruction[11:7];
                ports.rs1 <= 5'bx;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.imm <= {ports.instruction[31:12], 12'b0};
            
            //J-Type
            JAL:
                ports.rd0 <= ports.instruction[11:7];
                ports.rs1 <= 5'bx;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.imm <= {12{ports.instruction[31]}, ports.instruction[19:12], ports.instruction[20], ports.instruction[30:21]};
            
            //I-Type
            JALR, LB, LH, LW, LBU, LHU, ADDI, SUBI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, CSRRW, CSRRS, CSRRC, CSRRWI, CSRRSI, CSRRCI:
                ports.rd0 <= ports.instruction[11:7];
                ports.rs1 <= ports.instruction[19:15];
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b1;
                ports.r2_en <= 1'b0;
                ports.imm <= {21{ports.instruction[31]}, ports.instruction[30:20]};
            
            //B-Type
            BEQ, BNE, BLT, BGE, BLTU, BGEU:
                ports.rd0 <= 5'bx;
                ports.rs1 <= ports.instruction[19:15];
                ports.rs2 <= ports.instruction[24:20];
                ports.r1_en <= 1'b1;
                ports.r2_en <= 1'b1;
                ports.imm <= {20{ports.instruction[31]}, ports.instruction[7], ports.instruction[30:25], ports.instruction[11:8], 1'b0};
            
            //S-Type
            SB, SH, SW: 
                ports.rd0 <= 5'bx;
                ports.rs1 <= ports.instruction[19:15];
                ports.rs2 <= ports.instruction[24:20];
                ports.r1_en <= 1'b1;
                ports.r2_en <= 1'b1;
                ports.imm <= {21{ports.instruction[31]}, ports.instruction[30:25], ports.instruction[11:7]};
            
            //R-Type
            ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND:            
                ports.rd0 <= ports.instruction[11:7];
                ports.rs1 <= ports.instruction[19:15];
                ports.rs2 <= ports.instruction[24:20];
                ports.r1_en <= 1'b1;
                ports.r2_en <= 1'b1;
                ports.imm <= 31'bx;

            //Weird Types
            FENCE, FENCE_I:
                ports.rd0 <= 5'b0;
                ports.rs1 <= 5'b0;
                ports.rs2 <= ports.instruction[23:20];
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b1;
                ports.imm <= ports.instruction[27:24];
            ECALL:
                ports.rd0 <= 5'b0;
                ports.rs1 <= 5'b0;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.imm <= 31'b0;
            EBREAK:
                ports.rd0 <= 5'b0;
                ports.rs1 <= 5'b0;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.imm <= 31'b1;
        
            default:
                ports.rd0 <= 5'bx;
                ports.rs1 <= 5'bx;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.imm <= 32'bx;
        endcase
    end //always_comb
endmodule: Decode
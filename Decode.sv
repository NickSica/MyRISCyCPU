

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
                ports.csrr_en <= 1'b0;
                ports.imm <= {ports.instruction[31:12], 12'b0};
            
            //J-Type
            JAL:
                ports.rd0 <= ports.instruction[11:7];
                ports.rs1 <= 5'bx;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.csrr_en <= 1'b0;
                ports.imm <= {12{ports.instruction[31]}, ports.instruction[19:12], ports.instruction[20], ports.instruction[30:21]};
            
            //I-Type
            JALR, LB, LH, LW, LBU, LHU, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI:
                ports.rd0 <= ports.instruction[11:7];
                ports.rs1 <= ports.instruction[19:15];
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b1;
                ports.r2_en <= 1'b0;
                ports.csrr_en <= 1'b0;
                ports.imm <= {21{ports.instruction[31]}, ports.instruction[30:20]};
            
            //B-Type
            BEQ, BNE, BLT, BGE, BLTU, BGEU:
                ports.rd0 <= 5'bx;
                ports.rs1 <= ports.instruction[19:15];
                ports.rs2 <= ports.instruction[24:20];
                ports.r1_en <= 1'b1;
                ports.r2_en <= 1'b1;
                ports.csrr_en <= 1'b0;
                ports.imm <= {20{ports.instruction[31]}, ports.instruction[7], ports.instruction[30:25], ports.instruction[11:8], 1'b0};
            
            //S-Type
            SB, SH, SW: 
                ports.rd0 <= 5'bx;
                ports.rs1 <= ports.instruction[19:15];
                ports.rs2 <= ports.instruction[24:20];
                ports.r1_en <= 1'b1;
                ports.r2_en <= 1'b1;
                ports.csrr_en <= 1'b0;
                ports.imm <= {21{ports.instruction[31]}, ports.instruction[30:25], ports.instruction[11:7]};
            
            //R-Type
            ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND:            
                ports.rd0 <= ports.instruction[11:7];
                ports.rs1 <= ports.instruction[19:15];
                ports.rs2 <= ports.instruction[24:20];
                ports.r1_en <= 1'b1;
                ports.r2_en <= 1'b1;
                ports.csrr_en <= 1'b0;
                ports.imm <= 32'bx;

            //Weird Types
            FENCE, FENCE_I:
                ports.rd0 <= 5'b0;
                ports.rs1 <= 5'b0;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.csrr_en <= 1'b0;
                ports.imm <= ports.instruction[31:20];
            ECALL:
                ports.rd0 <= 5'b0;
                ports.rs1 <= 5'b0;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.csrr_en <= 1'b0;
                ports.imm <= 32'b0;
            EBREAK:
                ports.rd0 <= 5'b0;
                ports.rs1 <= 5'b0;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.csrr_en <= 1'b0;
                ports.imm <= 32'b1;
             CSRRW, CSRRS, CSRRC:
                ports.rd0 <= ports.instruction[11:7];
                ports.rs1 <= ports.instruction[19:15];
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b1;
                ports.r2_en <= 1'b0;
                ports.csrr_en <= 1'b1;
                ports.csrr_addr <= ports.instruction[31:20];
                ports.imm <= 32'b0;
            CSRRWI, CSRRSI, CSRRCI:
                ports.rd0 <= ports.instruction[11:7];
                ports.rs1 <= 5'bx;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.csrr_en <= 1'b1;
                ports.csrr_addr <= ports.instruction[31:20];
                ports.imm <= {27'b0, ports.instruction[19:15]};

            default:
                ports.rd0 <= 5'bx;
                ports.rs1 <= 5'bx;
                ports.rs2 <= 5'bx;
                ports.r1_en <= 1'b0;
                ports.r2_en <= 1'b0;
                ports.csrr_en <= 1'b0;
                ports.imm <= 32'bx;
        endcase
    end //always_comb
endmodule: Decode
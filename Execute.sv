module Execute(instr_ports ports, ctl_flags flags);
/*
    logic[3:0] aluOperation = 0'b0;
    logic[31:0] op1 = 0'b0;
    logic[31:0] op2 = 0'b0;
    logic[31:0] op_out = 0'b0;
*/
    always_comb 
    begin
        case(instruction)
            LUI:
                ports.rd0_val = ports.imm;
            AUIPC:
                ports.rd0_val = ports.imm + ports.pc;
                /*
                aluOperation = 4'b0000;
                op1 = ports.imm;
                op2 = ports.pc;
                */
            JAL: //x1 as return address register and x5 as an alternate link register
                ports.rd0_val = ports.pc + 4;
                ports.pc = ports.pc + ports.imm;
                
            JALR:
                ports.rd0_val = ports.pc + 4;
                ports.pc = (ports.rs1_val + ports.imm) & 8'hFFFFFFFE;
                ports.pc[0] = 0;
            //BRANCH Instructions
            BEQ:
                ports.pc = (rs1_val == rs2_val) ? (ports.imm + ports.pc) : (ports.pc);
            BNE:
                ports.pc = (rs1_val != rs2_val) ? (ports.imm + ports.pc) : (ports.pc);
            BLT:
                ports.pc = (signed'(ports.rs1_val) < signed'(ports.rs2_val)) ? (ports.imm + ports.pc) : ports.pc;
            BGE:
                ports.pc = (signed'(ports.rs1_val) >= signed'(ports.rs2_val)) ? (ports.imm + ports.pc) : ports.pc;
            BLTU:
                ports.pc = (unsigned'(ports.rs1_val) < unsigned'(ports.rs2_val)) ? (ports.imm + ports.pc) : ports.pc;
            BGEU:
                ports.pc = (unsigned'(ports.rs1_val) >= unsigned'(ports.rs2_val)) ? (ports.imm + ports.pc) : ports.pc;
            //LOAD Instructions
            //TODO: Retrieve from memory here                
            LB, LH, LW, LBU, LHU:
                ports.rd0_val = {27'b0, ports.rd};
                flags.is_ls = 1'b1;
            LB:
                flags.ls_type_reg = {4'b0_000, (ports.rs1_val + ports.imm)};
            LH:
                flags.ls_type_reg = {4'b0_001, (ports.rs1_val + ports.imm)};
            LW:
                flags.ls_type_reg = {4'b0_010, (ports.rs1_val + ports.imm)};
            LBU:
                flags.ls_type_reg = {4'b0_100, (ports.rs1_val + ports.imm)};
            LHU:
                flags.ls_type_reg = {4'b0_110, (ports.rs1_val + ports.imm)};
            //STORE Instructions
            SB, SH, SW:
                ports.rd0_val = ports.rs2_val;
                flags.is_ls = 1'b1;
            SB: 
                flags.ls_type_reg = {4'b1_000, (ports.rs1_val + ports.imm)};
            SH:
                flags.ls_type_reg = {4'b1_001, (ports.rs1_val + ports.imm)};
            SW:
                flags.ls_type_reg = {4'b1_010, (ports.rs1_val + ports.imm)};
            //OP-IMM Instructions
            ADDI:
                ports.rd0_val = 32'(ports.imm + ports.rs1_val);
                /*
                aluOperation = 4'b0000;
                op1 = ports.imm;
                op2 = ports.rs1_val;
                */
            SLTI: 
                ports.rd0_val = (signed'(ports.rs1_val) < signed'(ports.imm) ? 32'b1 : 32'b0);
                /* aluOperation = 4'b0011;
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            SLTIU:
                ports.rd0_val = (unsigned'(ports.rs1_val) < unsigned'(ports.imm) ? 32'b1 : 32'b0);
                /* aluOperation = 4'b0100;
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            XORI:
                ports.rd0_val = ports.rs1_val ^ ports.imm;
                /* aluOperation = 4'b0101;
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            ORI:
                ports.rd0_val = ports.rs1_val | ports.imm;
                /* aluOperation = 4'b1000; 
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            ANDI:
                ports.rd0_val = ports.rs1_val & ports.imm;
                /* aluOperation = 4'b1001;
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            SLLI:
                ports.rd0_val = ports.rs1_val << ports.imm[4:0]; 
                /* aluOperation = 4'b0010;
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            SRLI:
                ports.rd0_val = ports.rs1_val >> ports.imm[4:0];
                /* aluOperation = 4'b0110; 
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            SRAI:
                ports.rd0_val = ports.rs1_val >>> ports.imm[4:0];
                /* aluOperation = 4'b0111; 
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            //OP Instructions
            ADD:
                ports.rd0_val = 32'(ports.rs1_val + ports.rs2_val);
                /* aluOperation = 4'b0000;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SUB:
                ports.rd0_val = 32'(ports.rs1_val - ports.rs2_val);
                /* aluOperation = 4'b0001;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SLL:
                ports.rd0_val = ports.rs1_val << ports.rs2_val[4:0]; 
                /* aluOperation = 4'b0010;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SLT:
                ports.rd0_val = (signed'(ports.rs1_val) < signed'(ports.rs2_val)) ? 32'b1 : 32'b0;
                /* aluOperation = 4'b0011;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SLTU:
                ports.rd0_val = (unsigned'(ports.rs1_val) < unsigned'(ports.rs2_val)) ? 32'b1 : 32'b0;
                /* aluOperation = 4'b0100;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            XOR:
                ports.rd0_val = ports.rs1_val ^ ports.rs2_val;
                /* aluOperation = 4'b0101;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SRL:
                ports.rd0_val = ports.rs1_val >> ports.rs2_val[4:0];
                /* aluOperation = 4'b0110;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SRA:
                ports.rd0_val = ports.rs1_val >>> ports.rs2_val[4:0]; 
                /* aluOperation = 4'b0111;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            OR:
                ports.rd0_val = ports.rs1_val | ports.rs2_val;
                /* aluOperation = 4'b1000;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            AND:
                ports.rd0_val = ports.rs1_val & ports.rs2_val; 
                /* aluOperation = 4'b1001;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            //MISC-MEM Instructions
            // TODO: Unsure where to go with this as the base implementation is very vague
            FENCE:
            FENCE_I:
            //SYSTEM Instructions
            // TODO: Unsure where to go with these(ECALL/EBREAK) as the base implementation is very vague
            ECALL   :
            EBREAK  :
            CSRRW:
            CSRRS:
            CSRRC:
            CSRRWI:
            CSRRSI:
            CSRRCI:
        endcase
        /*
        if(~op1 || ~op2)
            Alu alu0(.operation(aluOperation), .op1, .op2, .op_out)
        */
    end
endmodule: Execute
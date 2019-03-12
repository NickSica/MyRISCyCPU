module Execute(input logic[0] val_change, instr_ports ports, ctl_flags flags);
/*
    logic[3:0] aluOperation = 0'b0;
    logic[31:0] op1 = 0'b0;
    logic[31:0] op2 = 0'b0;
    logic[31:0] op_out = 0'b0;
*/
    always_comb 
    begin
        if(flags.bypass & 2'b01) begin
            ports.rs1_val = ports.mem_rd_val;
        end else if(flags.bypass & 2'b10) begin
            ports.rs2_val = ports.mem_rd_val;
        end

        case(instruction)
            LUI:
                ports.rd_val = ports.imm;
            AUIPC:
                ports.rd_val = ports.imm + ports.pc;
                /*
                aluOperation = 4'b0000;
                op1 = ports.imm;
                op2 = ports.pc;
                */
            JAL: //x1 as return address register and x5 as an alternate link register
                ports.rd_val = ports.pc + 4;
                ports.pc = ports.pc + ports.imm;
                
            JALR:
                ports.rd_val = ports.pc + 4;
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
            LB:
                ports.rd_val = {27'b0, ports.rd};
                flags.is_ls = 1'b1;
                flags.ls_type_reg = {4'b0_000, (ports.rs1_val + ports.imm)};
            LH:
                ports.rd_val = {27'b0, ports.rd};
                flags.is_ls = 1'b1;
                flags.ls_type_reg = {4'b0_001, (ports.rs1_val + ports.imm)};
            LW:
                ports.rd_val = {27'b0, ports.rd};
                flags.is_ls = 1'b1;
                flags.ls_type_reg = {4'b0_010, (ports.rs1_val + ports.imm)};
            LBU:
                ports.rd_val = {27'b0, ports.rd};
                flags.is_ls = 1'b1;
                flags.ls_type_reg = {4'b0_100, (ports.rs1_val + ports.imm)};
            LHU:
                ports.rd_val = {27'b0, ports.rd};
                flags.is_ls = 1'b1;
                flags.ls_type_reg = {4'b0_110, (ports.rs1_val + ports.imm)};
            //STORE Instructions
            SB: 
                ports.rd_val = ports.rs2_val;
                flags.is_ls = 1'b1;
                flags.ls_type_reg = {4'b1_000, (ports.rs1_val + ports.imm)};
            SH:
                ports.rd_val = ports.rs2_val;
                flags.is_ls = 1'b1;
                flags.ls_type_reg = {4'b1_001, (ports.rs1_val + ports.imm)};
            SW:
                ports.rd_val = ports.rs2_val;
                flags.is_ls = 1'b1;
                flags.ls_type_reg = {4'b1_010, (ports.rs1_val + ports.imm)};
            //OP-IMM Instructions
            ADDI:
                ports.rd_val = 32'(ports.imm + ports.rs1_val);
                /*
                aluOperation = 4'b0000;
                op1 = ports.imm;
                op2 = ports.rs1_val;
                */
            SLTI: 
                ports.rd_val = (signed'(ports.rs1_val) < signed'(ports.imm) ? 32'b1 : 32'b0);
                /* aluOperation = 4'b0011;
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            SLTIU:
                ports.rd_val = (unsigned'(ports.rs1_val) < unsigned'(ports.imm) ? 32'b1 : 32'b0);
                /* aluOperation = 4'b0100;
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            XORI:
                ports.rd_val = ports.rs1_val ^ ports.imm;
                /* aluOperation = 4'b0101;
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            ORI:
                ports.rd_val = ports.rs1_val | ports.imm;
                /* aluOperation = 4'b1000; 
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            ANDI:
                ports.rd_val = ports.rs1_val & ports.imm;
                /* aluOperation = 4'b1001;
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            SLLI:
                ports.rd_val = ports.rs1_val << ports.imm[4:0]; 
                /* aluOperation = 4'b0010;
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            SRLI:
                ports.rd_val = ports.rs1_val >> ports.imm[4:0];
                /* aluOperation = 4'b0110; 
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            SRAI:
                ports.rd_val = ports.rs1_val >>> ports.imm[4:0];
                /* aluOperation = 4'b0111; 
                op1 = ports.rs1_val;
                op2 = ports.imm; */
            //OP Instructions
            ADD:
                ports.rd_val = 32'(ports.rs1_val + ports.rs2_val);
                /* aluOperation = 4'b0000;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SUB:
                ports.rd_val = 32'(ports.rs1_val - ports.rs2_val);
                /* aluOperation = 4'b0001;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SLL:
                ports.rd_val = ports.rs1_val << ports.rs2_val[4:0]; 
                /* aluOperation = 4'b0010;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SLT:
                ports.rd_val = (signed'(ports.rs1_val) < signed'(ports.rs2_val)) ? 32'b1 : 32'b0;
                /* aluOperation = 4'b0011;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SLTU:
                ports.rd_val = (unsigned'(ports.rs1_val) < unsigned'(ports.rs2_val)) ? 32'b1 : 32'b0;
                /* aluOperation = 4'b0100;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            XOR:
                ports.rd_val = ports.rs1_val ^ ports.rs2_val;
                /* aluOperation = 4'b0101;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SRL:
                ports.rd_val = ports.rs1_val >> ports.rs2_val[4:0];
                /* aluOperation = 4'b0110;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            SRA:
                ports.rd_val = ports.rs1_val >>> ports.rs2_val[4:0]; 
                /* aluOperation = 4'b0111;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            OR:
                ports.rd_val = ports.rs1_val | ports.rs2_val;
                /* aluOperation = 4'b1000;
                op1 = ports.rs1_val;
                op2 = ports.rs2_val; */
            AND:
                ports.rd_val = ports.rs1_val & ports.rs2_val; 
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
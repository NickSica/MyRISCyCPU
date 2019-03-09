module Execute(instr_ports ports);
    logic[3:0] aluOperation;
    logic[31:0] op1;
    logic[31:0] op2;
    logic[31:0] op_out;

    always_comb 
    begin
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
            ADDI:
                aluOperation = 4'b0000;
                op1 = ports.imm;
                op2 = ports.rs1_val;
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
                aluOperation = 4'b0000; 
            SUB, SUBI:
            SLL     : 
            SLT     : 
            SLTU    : 
            XOR     : 
            SRL     : 
            SRA     : 
            OR      : 
            AND     : 
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
        endcase

        Alu alu0(.operation(aluOperation), .op1, .op2, .op_out)
    end
endmodule: Execute
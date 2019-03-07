module alu
    (input logic[3:0] operation, 
    input unsigned logic[31:0] op1, 
    input unsigned logic[31:0] op2, 
    output logic[31:0] op_out);
    
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
        SLTI    : 
        SLTIU   : 
        XORI    : 
        ORI     : 
        ANDI    : 
        SLLI    : 
        SRLI    : 
        SRAI    : 
        //OP Instructions
        ADD     : assign op_out = 32'(op1 + op2);
        SUB, SUBI: assign op_out = 32'(op1 - op2);
        SLL     : assign op_out = op1 << op2; 
        SLT     : assign op_out = (signed'(op1) < signed'(op2) ? 32'b1 : 32'b0);
        SLTU    : assign op_out = (op1 < op2 ? 32'b1 : 32'b0);
        XOR     : assign op_out = op1 ^ op2;
        SRL     : assign op_out = op1 >> op2;
        SRA     : assign op_out = op1 >>> op2;
        OR      : assign op_out = op1 | op2;
        AND     : assign op_out = op1 & op2;
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
endmodule: alu
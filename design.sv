interface registers(input logic clk);
    const logic x0 = 1'b0;
    logic [31:0] x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11;
    logic [31:0] x12, x13, x14, x15, x16, x17, x18, x19, x20;
    logic [31:0] x21, x22, x23, x24, x25, x26, x27, x28, x29; 
    logic [31:0] x30, x31, x32;
    logic [31:0] pc;
endinterface: registers

module top(input logic[31:0] encoded_value);
    instructions::instructions instruction;

    instructions::decode decoder0(.encoded_value(encoded_value), .instruction(instruction));
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
            alu alu0(.operation(4'b0001), .op1(), .op2(), .op_out());
        SLTI    : 
        SLTIU   : 
        XORI    : 
        ORI     : 
        ANDI    : 
        SLLI    : 
        SRLI    : 
        SRAI    : 
        //OP Instructions
        ADD: alu alu0(.operation(4'b0000), .op1(), .op2(), .op_out());
        SUB: alu alu0(.operation(4'b0001), .op1(), .op2(), .op_out());
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
endmodule: top
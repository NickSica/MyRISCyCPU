module Alu(
    input logic[3:0] operation, 
    input logic[31:0] op1, 
    input logic[31:0] op2, 
    output logic[31:0] op_out);
    
    always_comb begin
        case(operation)
            //OP Instructions
            ADD     : op_out = 32'(op1 + op2);
            SUB, SUBI: op_out = 32'(op1 - op2);
            SLL     : op_out = op1 << op2; 
            SLT     : op_out = (signed'(op1) < signed'(op2) ? 32'b1 : 32'b0);
            SLTU    : op_out = (op1 < op2 ? 32'b1 : 32'b0);
            XOR     : op_out = op1 ^ op2;
            SRL     : op_out = op1 >> op2;
            SRA     : op_out = op1 >>> op2;
            OR      : op_out = op1 | op2;
            AND     : op_out = op1 & op2;
        endcase
    end
endmodule: Alu
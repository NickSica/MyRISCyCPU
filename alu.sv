module Alu(
    input logic[3:0] operation, 
    input logic[31:0] op1, 
    input logic[31:0] op2, 
    output logic[31:0] op_out);
    
    always_comb begin
        case(operation)
            //OP Instructions
            4'b0000: op_out = 32'(op1 + op2);                                    // Addition
            4'b0001: op_out = 32'(op1 - op2);                                    // Subtraction
            4'b0010: op_out = op1 << op2[4:0];                                   // Logic left shift
            4'b0011: op_out = (signed'(op1) < signed'(op2)) ? 32'b1 : 32'b0;     // Signed less than
            4'b0100: op_out = (unsigned'(op1) < unsigned'(op2)) ? 32'b1 : 32'b0; // Unsigned less than
            4'b0101: op_out = op1 ^ op2;                                         // Xor
            4'b0110: op_out = op1 >> op2[4:0];                                   // Logic right shift
            4'b0111: op_out = op1 >>> op2[4:0];                                  // Arithmetic right shift
            4'b1000: op_out = op1 | op2;                                         // Or
            4'b1001: op_out = op1 & op2;                                         // And
        endcase
    end
endmodule: Alu
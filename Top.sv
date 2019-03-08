interface registers(input logic clk);
    const logic x0 = 1'b0;
    logic [31:0] x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11;
    logic [31:0] x12, x13, x14, x15, x16, x17, x18, x19, x20;
    logic [31:0] x21, x22, x23, x24, x25, x26, x27, x28, x29; 
    logic [31:0] x30, x31, x32;
    logic [31:0] pc;
endinterface: registers

typedef struct 
{
    logic[0] 
} ControlData;

typedef struct
{
    
} DataControl;

module Top(input logic[31:0] encoded_value);
    ControlPath ctrl
        (input clk,
        input reset,
        );
    
endmodule: Top
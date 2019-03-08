/*
interface registers(input logic clk);
    const logic x0 = 1'b0;
    logic [31:0] x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11;
    logic [31:0] x12, x13, x14, x15, x16, x17, x18, x19, x20;
    logic [31:0] x21, x22, x23, x24, x25, x26, x27, x28, x29; 
    logic [31:0] x30, x31, x32;
    logic [31:0] pc;
endinterface: registers
*/
interface Flags 
    logic[0] we_bypass;
    logic[0] we_stall;
    logic[4:0] curr_rd;

    modport src(
        input curr_rd,
        output we_bypass,
        output we_stall
    );

    modport sink(
        input we_bypass,
        input we_stall,
        output curr_rd
    );
endinterface: flags;

module Top(input clk, input logic[31:0] encoded_value);
    ControlPath ctrl(.clk(clk), .fsrc(flags.src));

    DataPath data(.clk(clk), .fsink(flags.sink));
    
endmodule: Top
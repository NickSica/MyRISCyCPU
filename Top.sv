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
interface wishbone();
    // Master to Slave
    logic o_cyc; // 1 to start read or write
    logic o_stb; // 1 to start read or write
    logic o_we; // 0 for read, 1 for write
    logic[2:0] o_addr; // Address of slave
    logic o_data; // Data from master to slave
    logic o_sel;

    // Slave to Master
    logic i_stall; // 0 to start read or write
    logic i_ack; // Master must accept at any time after a transaction is initiated
    logic i_data; // Data returned from slave to master
    logic i_err;

    modport master(
        input placeholder
    );

    modport slave(
        output placeholder
    );
endinterface: wishbone

interface flags();
    logic[31:0] instr;
    logic[0] we_stall;
    logic[4:0] curr_rd;

    modport cpu(
        input curr_rd,
        input instr,
        output we_bypass,
        output we_stall
    );

    modport ram(
        input we_bypass,
        input we_stall,
        output instr
    );
endinterface: flags;

module Top(input clk);
    logic[7:0] bootcode[0:255];
    wishbone wb();

    initial begin
        logic boot_complete = 1'b0;
        while(boot_complete == 1'b0) begin
            Boot boot(.clk(scl), .data(bootcode), .boot_complete);
        end
    end

    always_comb begin
        case(wb.o_addr)
            3'b000: begin
                if(wb.o_stb && (!wb.i_stall)) begin
                    if(!wb.o_we) begin
                        Ram ram(.clk(clk), );
                    end else begin
                        Ram ram(.clk(clk), );
                    end
                end
            end

            3'b001: begin

            end

        endcase
    end

    CPU cpu(.clk(clk), .fcpu(flags.cpu));
    RAM ram(.clk(clk), .fram(flags.ram));

endmodule: Top
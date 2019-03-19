module RAM
    (input clk,
    flags.src fsrc);

    logic[12:0] addr;
    logic[15:0] data;
    logic[1:0] dmask; // byte data mask
    logic[1:0] bank_addr;
    logic ras_n; // row address strobe
    logic cas_n; // column address strobe
    logic we_n; // write enable
    logic cs_n; // chip select
    logic clk_en;

endmodule: RAM



/*
MRD
[13:10] -> 0 for future compatibility
[9]     -> 0 programmed burst length, 1 single location access
[8:7]   -> 0 Standard Operation
[6:4]   -> 010 CAS Latency 2, 011 CAS Latency 3
[3]     -> Burst Type: 0 Sequential, 1 Interleaved
[2:0]   -> Max Burst Length: 000 1, 010 2, 011 4, 100 8, 111 full page
*/
typedef enum logic[3:0] {
    IDLE,
    ROW_ACTIVE,
    READ,
    READA,
    WRITE,
    WRITEA,
    PRE,
    NOP,
    PWR_DWN,

} States;

typedef enum logic[3:0] {
    DESL  = 4'b1_?_?_?,
    NOP   = 4'b0_1_1_1,
    BST   = 4'b0_1_1_0,
    READ  = 4'b0_1_0_1,
    READA = 4'b0_1_0_1,
    WRIT  = 4'b0_1_0_0,
    WRITA = 4'b0_1_0_0,
    ACT   = 4'b0_0_1_1,
    PRE   = 4'b0_0_1_0,
    PALL  = 4'b0_0_1_0,
    REF   = 4'b0_0_0_1,
    SELF  = 4'b0_0_0_1,
    MRS   = 4'b0_0_0_0,
} Commands;

module RAM(
    input clk,
    inout logic[15:0] data,
    flags.src fsrc);

/*
                                CKE                             A12,A11
    Function                    n–1 n       CS RAS CAS WE       BA1 BA0 A10 A9-A0
    Device deselect (DESL)      H   ×       H  ×   ×   ×        ×   ×   ×   ×
    No operation (NOP)          H   ×       L  H   H   H        ×   ×   ×   ×
    Burst stop (BST)            H   ×       L  H   H   L        ×   ×   ×   ×
    Read                        H   ×       L  H   L   H        V   V   L   V
    Read with auto precharge    H   ×       L  H   L   H        V   V   H   V
    Write                       H   ×       L  H   L   L        V   V   L   V
    Write with auto precharge   H   ×       L  H   L   L        V   V   H   V
    Bank activate (ACT)         H   ×       L  L   H   H        V   V   V   V
    Precharge select bank (PRE) H   ×       L  L   H   L        V   V   L   ×
    Precharge all banks (PALL)  H   ×       L  L   H   L        ×   ×   H   ×
    CBR Auto-Refresh (REF)      H   H       L  L   L   H        ×   ×   ×   ×
    Self-Refresh (SELF)         H   L       L  L   L   H        ×   ×   ×   ×
    Mode register set (MRS)     H   ×       L  L   L   L        L   L   L   V
*/
    const logic[14:0] DEF_MRD = 15'b00000_0_00_010_0_001;

    States state = IDLE;
    Commands cmd = NOP;
    logic[12:0] addr;
    logic[15:0] data;
    logic[1:0] dmask; // byte data mask
    logic[1:0] bank_addr;
    logic counter = 0;
    logic ras_n; // row address strobe
    logic cas_n; // column address strobe
    logic we_n; // write enable
    logic cs_n; // chip select
    logic clk_en;

    initial begin
        // Initialization starts on page 20
        // 200 us delay
        // PRECHARGE command
        //>=8 AUTO REFRESH cycles
        // Mode Register programming

    end

    always_ff @(posedge clk) begin
        case(state)
            IDLE:
                case(command)
                    DESL: state <= (({bank_addr, cke} == 3'b0) ? PWR_DWN : NOP);
                    NOP:
                    BST:
                    READ, READA:
                    WRIT, WRITA:
                    ACT:
                    PRE, PALL:
                    REF, SELF:
                    MRS:
                endcase
            IDLE:
                case(command)
                    DESL:
                    NOP:
                    BST:
                    READ, READA:
                    WRIT, WRITA:
                    ACT:
                    PRE, PALL:
                    REF, SELF:
                    MRS:
            endcase
        IDLE:
            case(command)
                DESL:
                    NOP:
                        BST:
                        READ, READA:
            WRIT, WRITA:
            ACT:
            PRE, PALL:
            REF, SELF:
            MRS:
        endcase

        endcase
    end

    always_ff @(clk) begin
        counter = ((counter < 391) ? counter + 1 : counter);
    end

endmodule: RAM



/*
    Transfers bootcode from eeprom to ram
*/
typedef enum[3:0] {
    WAIT = 2'b000,
    SEND = 2'b001,
    ACK = 2'b010,
    RECV = 2'b11,
} ControllerState;

module Boot(
    input logic i2c_clk,
    input logic ram_clk,
    output logic boot_complete,
    output logic[15:0] data[0:9] = '{default:0}); //First 5 Instructions

    logic sda;
    logic ack;
    logic data_byte = 8'b0;
    ControllerState state = WAIT;
    logic[13:0] ram_addr = 13'b0;
    logic addr[7:0] = 8'b1010_0001;
    logic data_addr[7:0] = 8'b0;
    logic enable = 1'b1;
    logic bit_count = 7;
    logic cycle_count = 0;

    always_ff @(posedge i2c_clk) begin
        case(state)
            WAIT: begin
                if(enable) begin
                    sda <= 1'b0;
                    enable <= 1'b0;
                    state <= SEND;
                    bit_count <= 7;
                end
            end

            ACK: begin
                ack <= sda;
                data[cycle_count - 2] <= data_byte;

                if(sda == 1) begin
                    state <= WAIT;
                    sda <= 1'b0;
                end else begin
                    state <= ((cycle_count >= 2) ? SEND : RECV);
                end
            end

            RECV: begin
                data_byte[bit_count] = sda;

                if(bit_count == 0) begin
                    state <= ACK;
                    bit_count <= 7;
                end else begin
                    bit_count <= bit_count - 1;
                end
            end
        endcase

        if(ack) begin
            sda <= 1'b1;
            ack <= 1'b0;
            boot_complete <= 1'b1;
        end
    end

    always_ff @(negedge i2c_clk) begin
        case(state)
            SEND: begin
                sda <= addr[bit_count];
                if(bit_count == 0) begin
                    state <= ACK;
                    cycle_count <= cycle_count + 1;
                    sda <= 1'bZ;
                end else begin
                    bit_count <= bit_count - 1;
                end
            end
        endcase
    end

    always_ff @(posedge ram_clk) begin
        if() begin
            Ram ram(.addr(ram_addr[12:0]), .bank(ram_addr[13]));
        end
    end
endmodule: Boot
/*
    VERY VERY VERY WIP

    The DE0-Nano contains a 2Kbit Electrically Erasable PROM (EEPROM). 
    The EEPROM is configured through a 2-wire I2C serial interface. 
    The device is organized as one block of 256 x 8-bit memory.
    The I2C write and read address are 0xA0 and 0xA1, respectively.
    I2C_SCLK = PIN_F2
    I2C_SDAT = PIN_F1
*/
typedef enum {
    WAIT = 3'b000,
    START = 3'b001,
    SEND_ADDR = 3'b010,
    ACK = 3'b011,
    ACK_WAIT = 3'b100,
    RECV_DATA = 3'b101,
    STOP = 3'b110
} ControllerState;

module MemController(
    input logic clk,
    input logic data);

    logic busy = 1'b0;
    logic addr = 5'b1010_0000;
    logic addr = 5'b1010_0001;
    logic[7:0] w_data;
    logic[7:0] r_data;
    logic ack;
    ControllerState state = WAIT;
    logic sda;
    logic count <= 7;
    
    always_ff @(posedge clk) begin
        case(state)
            WAIT: begin
                if(enable) begin
                    sda <= 1'b0;
                    state <= SEND_ADDR;
                    count <= 7;
                end
            end
            SEND_ADDR: begin
                sda = addr[count];
                if(count == 0) begin
                    state <= ACK;
                end else begin
                    count <= count - 1;
                end
            end
            ACK: begin
                if(sda == 1) begin
                    state <= WAIT;
                    count <= 7;
                end else begin
                    state <= ACK_WAIT;
                end
            end
            ACK_WAIT: begin
                count <= 0;
                stop = sda;
                if(addr[0] == 0) begin
                    state <= SEND_DATA;
                end else begin
                    state <= RECV_DATA;
                end
            end
            SEND_DATA: begin
                sda = data[count];
                if(count == 7) begin
                    count <= 7;
                    state <= ACK;
                end else begin
                    count <= count + 1;
                end
            end
            RECV_DATA: begin
                if(count != 8) begin
                    data[count] = sda[count];
                    count <= count + 1;
                end else begin
                    count <= 1;
                    state <= ACK;
                end
            end
        endcase
    end

    always_ff @(negedge clk) begin
        if(state == SEND_DATA || state == RECV_DATA) begin
            if((stop == 0) & (sda == 1)) begin
                state <= WAIT;
                count <= 7;
            end
        end
    end //always_ff
endmodule: MemController
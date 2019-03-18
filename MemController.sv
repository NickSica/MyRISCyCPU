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
            WAIT:
                if(enable) begin
                    sda <= 1'b0;
                    state <= SEND_ADDR;
                    count <= 7;
                end
            SEND_ADDR:
                sda = addr[count];
                if(count == 0) begin
                    state <= ACK;
                end else begin
                    count <= count - 1;
                end
            ACK:
                if(sda == 1) begin
                    state <= WAIT;
                    count <= 7;
                end else begin
                    state <= ACK_WAIT;
                end
            ACK_WAIT:
                count <= 0;
                stop = sda;
                if(addr[0] == 0) begin
                    state <= SEND_DATA;
                end else begin
                    state <= RECV_DATA;
                end
            SEND_DATA:
                sda = data[count];
                if(count == 7) begin
                    count <= 7;
                    state <= ACK;
                end else begin
                    count <= count + 1;
                end
            RECV_DATA:
                if(count != 8) begin
                    data[count] = sda[count];
                    count <= count + 1;
                end else begin
                    count <= 1;
                    state <= ACK
                end

        endcase

        if(start & ~ack) begin
            if(count <= 8) begin
                count++;
            end else if(count <= 9) begin
                ack <= sda;
                count++;
            end else if(count <= 10) begin
                count++;
            end else if()
        end else if(ack == 1) begin
            ack <= 0;
            count <= 1;
            start <= 0;
        end
    end //always_ff

    always_ff @(negedge clk) begin
        if(state == SEND_DATA ACK_WAIT begin
            if((stop == 0) & (sda == 1)) begin
                state <= WAIT;
                count <= 7;
            end
        end
    end //always_ff

    //I2C i2c(.scl(i2c_clk), .sda(i2c_data));

endmodule: MemController
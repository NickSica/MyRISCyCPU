module CSRFile(
    input clk,
    instr_ports ports);
    
    logic[31:0] csr[11:0];

    always_ff @(posedge clk) begin
        if(!rst) begin
            if(ports.csrw_en) begin
                csr[ports.csrw_addr] = ports.csrw_data;
            end
        end //if statement
    end //always_ff

    always_comb begin
        if(rst) begin
            ports.csrr_data <= 32'b0;
        end else if(ports.csrw_en & (ports.csrr_addr == ports.csrw_addr)) begin
            ports.csrr_data <= ports.csrw_data;
        end else begin
            ports.csrr_data <= csr[ports.csrr_addr];
        end
    end //always_comb
endmodule: CSRFile
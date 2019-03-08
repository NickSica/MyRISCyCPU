module RegisterFile(
    input clk, 
    instr_ports.reg_file ports);
    
    logic[31:0] regs[0:31];

    always_ff @(posedge clk)
    begin
        if(!rst)
        begin
            if(ports.w_en && (ports.w_addr != 0)
            begin
                regs[ports.w_addr] <= ports.w_data;
            end// if2
        end //if1       
    end //always_ff

    always_comb
    begin
        if(rst || !ports.r1_en || (ports.rs1 == 0))
        begin
            ports.r1_data <= 32'b0;
        end else if(ports.w_en && (ports.rs1 == ports.w_addr))
        begin
            ports.r1_data <= ports.w_data;
        end else
            ports.r1_data <= regs[ports.rs1];
        end //if-else
    end //always_comb

    always_comb
    begin
        if(rst || !ports.r2_en || (ports.rs2 == 0))
        begin
            ports.r2_data <= 32'b0;
        end else if(ports.w_en && (ports.rs2 == ports.w_addr))
        begin
            ports.r2_data <= ports.w_data;
        end else
            ports.r2_data <= regs[ports.rs2];
        end //if-else
    end //always_comb
endmodule: RegisterFile
module IntructionFetch(input clk, instr_ports.fetch ports);
    always_ff @(posedge clk)
    begin
        // TODO: Grab Values from cache
        // retrieve value of ports.pc
        ports.instruction <= ;
        ports.asm <= 
        ports.pc <= pc + 4;
    end //always_ff
endmodule: InstructionFetch
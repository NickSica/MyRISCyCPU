module IntructionFetch(input clk, instr_ports.fetch ports);
    always_ff @(edge clk)
    begin
        // TODO: Grab Values from cache
        // retrieve value of ports.pc
        ports.instruction <= ;
        ports.asm <= 
    end //always_ff
endmodule: InstructionFetch
module I2C(
    inout logic scl, 
    inout logic sda);

    always_ff @(negedge scl) begin
        
    end
    
    always_ff @(posedge scl) begin
        
    end //always_ff

endmodule: I2C
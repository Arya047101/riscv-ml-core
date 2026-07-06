module signExtender (
    input  [11:0] imm_in,    
    output [31:0] imm_out   
);
    //Used to extebnd sign of immediate values 
    assign imm_out = {{20{imm_in[11]}}, imm_in};

endmodule
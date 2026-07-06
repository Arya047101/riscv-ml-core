module aluDecoder(
    input clk,
    input rst, 
    input [31:0] instruction;
    output reg aluOpcode 
)

//Different formats of instructions
localparam RTYPE  = 0110011;
localparam ITYPE  = 0010011;
localparam LOAD   = 0000011;
localparam STORE  = 0100011;
localparam BRANCH = 1100011;
localparam JAL    = 1101111;
localparam JALR   = 1100111;
localparam LUI    = 1101111;
localparam AUIPAC = 1101111;

always@(posedge clk) begin 
    if(!rst) begin 
        //reset 
    end 
    else begin 
        //logic 
    end 
endmodule 
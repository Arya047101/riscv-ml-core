module controlUnit (
    input        clk, 
    input        rst,
    input [31:0] instruction, 
    output reg   RegWrite, 
    output reg   MemRead, 
    output reg   MemWrite, 
    output reg   MemtoReg, 
    output reg   ALUSrc, 
    output reg   Branch, 
    output reg   Jump,
    output reg   ALUOpcode
);

//Instruction Format
reg opcode = instruction[6:0];

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
        RegWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        ALUSrc <= 0;
        Branch <= 0;
        Jump <= 0;
    end

    else begin 
        case(opcode)
            RTYPE: begin 
                //logic
            end

            ITYPE: begin
                //logic
            end

            LOAD: begin
                //logic
            end

            STORE: begin 
                //logic
            end

            BRANCH: begin 
                //logic
            end

            JAL: begin 
                //logic
            end 
            
            JALR: begin 
                //logic
            end 

            LUI: begin 
                //logic 
            end

            AUIPAC: begin 
                //logic 
            end 

            default: begin 
                //logic
            end

    end
end 

endmodule 
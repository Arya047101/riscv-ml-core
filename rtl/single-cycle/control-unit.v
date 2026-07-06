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
);

    wire [6:0] opcode = instruction[6:0];

    localparam RTYPE  = 7'b0110011;
    localparam ITYPE  = 7'b0010011;
    localparam LOAD   = 7'b0000011;
    localparam STORE  = 7'b0100011;
    localparam BRANCH = 7'b1100011;
    localparam JAL    = 7'b1101111;
    localparam JALR   = 7'b1100111;
    localparam LUI    = 7'b0110111;
    localparam AUIPC  = 7'b0010111;

    always @(posedge clk) begin 
        if (!rst) begin 
            RegWrite <= 0;
             MemRead <= 0; 
             MemWrite <= 0; 
             MemtoReg <= 0;
             ALUSrc <= 0; 
             Branch <= 0; 
             Jump <= 0; 
        end 
        
        else begin 
            RegWrite <= 0; 
            MemRead <= 0; 
            MemWrite <= 0; 
            MemtoReg <= 0;
            ALUSrc <= 0; 
            Branch <= 0; 
            Jump <= 0; 

            case(opcode)
                RTYPE:  begin 
                    RegWrite <= 1; 
                end

                ITYPE:  begin 
                    RegWrite <= 1; 
                    ALUSrc <= 1; 
                end

                LOAD:   begin 
                    RegWrite <= 1; 
                    ALUSrc <= 1; 
                    MemRead <= 1; 
                    MemtoReg <= 1; 
                end

                STORE:  begin 
                    ALUSrc <= 1; 
                    MemWrite <= 1; 
                end

                BRANCH: begin 
                    Branch <= 1; 
                    ALUOpcode <= 2'b01; 
                end

                JAL:    begin 
                    RegWrite <= 1; 
                    Jump <= 1; 
                end

                JALR:   begin 
                    RegWrite <= 1; 
                    ALUSrc <= 1; 
                    Jump <= 1; 
                end

                LUI:    begin 
                    RegWrite <= 1; 
                end

                AUIPC:  begin 
                    RegWrite <= 1; 
                    ALUSrc <= 1; 
                end
                
                default: begin end
            endcase
        end
    end 
endmodule
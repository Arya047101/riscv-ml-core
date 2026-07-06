module aluDecoder(
    input clk,
    input rst,
    input [31:0] instruction,
    output reg [3:0] aluOpcode
);

    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];
    wire       funct7 = instruction[30];

    always @(posedge clk) begin
        if (!rst) begin
            aluOpcode <= 4'b0;
        end else begin
            case (opcode)
                7'b0110011: begin // R-Type
                    case ({funct7, funct3})
                        4'b0000: aluOpcode <= 4'b0000; // ADD
                        4'b1000: aluOpcode <= 4'b0001; // SUB
                        4'b0111: aluOpcode <= 4'b0010; // AND
                        4'b0110: aluOpcode <= 4'b0011; // OR
                        4'b0100: aluOpcode <= 4'b0100; // XOR
                        4'b0010: aluOpcode <= 4'b0101; // SLT
                        4'b0001: aluOpcode <= 4'b0110; // SLL
                        4'b0101: aluOpcode <= 4'b0111; // SRL
                        4'b1101: aluOpcode <= 4'b1000; // SRA
                        default: aluOpcode <= 4'b0000;
                    endcase
                end
                7'b0010011: begin // I-Type (Immediate)
                    case (funct3)
                        3'b000: aluOpcode <= 4'b0000; // ADDI -> ADD
                        3'b111: aluOpcode <= 4'b0010; // ANDI -> AND
                        3'b110: aluOpcode <= 4'b0011; // ORI  -> OR
                        3'b100: aluOpcode <= 4'b0100; // XORI -> XOR
                        default: aluOpcode <= 4'b0000;
                    endcase
                end
                7'b0000011, 7'b0100011: aluOpcode <= 4'b0000; // LOAD/STORE -> ADD (base+offset)
                7'b1100011:             aluOpcode <= 4'b0001; // BRANCH -> SUB
                default:                aluOpcode <= 4'b0000;
            endcase
        end
    end
endmodule
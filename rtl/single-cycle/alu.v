module alu (
    input [31:0] operandA,
    input [31:0] operandB,
    input [3:0]  aluCtl,
    output reg [31:0] result,
    output reg zero
);

    localparam ADD  = 4'b0000;
    localparam SUB  = 4'b0001;
    localparam AND  = 4'b0010;
    localparam OR   = 4'b0011;
    localparam XOR  = 4'b0100;
    localparam SLT  = 4'b0101;
    localparam SLL  = 4'b0110;
    localparam SRL  = 4'b0111;
    localparam SRA  = 4'b1000;
    localparam SLTU = 4'b1001;

    always @(*) begin
        case(aluCtl)
            ADD:  result = operandA + operandB;
            SUB:  result = operandA - operandB;
            AND:  result = operandA & operandB;
            OR:   result = operandA | operandB;
            XOR:  result = operandA ^ operandB;
            SLT:  result = ($signed(operandA) < $signed(operandB)) ? 32'b1 : 32'b0;
            SLL:  result = operandA << operandB[4:0];
            SRL:  result = operandA >> operandB[4:0];
            SRA:  result = $signed(operandA) >>> operandB[4:0];
            SLTU: result = (operandA < operandB) ? 32'b1 : 32'b0;
            default: result = 32'b0;
        endcase
    end

    always @(*) begin
        zero = (result == 32'b0);
    end

endmodule
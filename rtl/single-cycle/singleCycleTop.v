module riscv_top(input clk, input rst);
    wire [31:0] pc, next_pc, instruction, readData1, readData2, alu_result, mem_data, write_back_data, imm_ext, alu_operand2;
    wire [3:0] alu_ctl;
    wire regWrite, memRead, memWrite, memtoReg, aluSrc, branch, jump;
    wire [1:0] aluOp;
    wire zero;


    pc pc_unit(.clk(clk), .rst(rst), .next_pc(next_pc), .pc(pc));

    InstructionMemory imem(.addr(pc), .readData(instruction));
    DataMemory dmem(.clk(clk), .memWrite(memWrite), .memRead(memRead), .addr(alu_result), .writeData(readData2), .readData(mem_data));

    // 3. Register File
    registerFile rf(.clk(clk), .rst(rst), .regWrite(regWrite), .readReg1(instruction[19:15]), .readReg2(instruction[24:20]), 
                    .writeReg(instruction[11:7]), .writeData(write_back_data), .readData1(readData1), .readData2(readData2));

    // 4. Control & Decode
    controlUnit ctrl(.clk(clk), .rst(rst), .instruction(instruction), .RegWrite(regWrite), .MemRead(memRead), .MemWrite(memWrite), 
                     .MemtoReg(memtoReg), .ALUSrc(aluSrc), .Branch(branch), .Jump(jump), .ALUOpcode(aluOp));
    aluDecoder alu_dec(.clk(clk), .rst(rst), .instruction(instruction), .aluOpcode(alu_ctl));
    signExtender imm_gen(.imm_in(instruction[31:20]), .imm_out(imm_ext));

    // 5. ALU & MUX
    mux2to1 alu_mux(.a(readData2), .b(imm_ext), .sel(aluSrc), .out(alu_operand2));
    alu alu_unit(.operandA(readData1), .operandB(alu_operand2), .aluCtl(alu_ctl), .result(alu_result), .zero(zero));
    mux2to1 wb_mux(.a(alu_result), .b(mem_data), .sel(memtoReg), .out(write_back_data));

    // 6. Next PC Logic (PC + 4)
    assign next_pc = pc + 4; // Add logic here for Branch/Jump

endmodule
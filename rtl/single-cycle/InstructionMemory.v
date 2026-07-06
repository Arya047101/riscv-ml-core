module InstructionMemory (
    input  [31:0] addr,
    output [31:0] readData
);

    reg [31:0] memory [0:1023]; // 1024 instructions depth

    // Initialize with machine code
    initial begin
        $readmemh("program.hex", memory);
    end

    // Asynchronous read (Instruction memory is read-only)
    assign readData = memory[addr[31:2]]; // Word aligned (divide by 4)

endmodule
module DataMemory (
    input clk,
    input memWrite,
    input memRead,
    input [31:0] addr,
    input [31:0] writeData,
    output [31:0] readData
);

    reg [31:0] memory [0:1023]; // 4KB data space

    // Synchronous write
    always @(posedge clk) begin
        if (memWrite) begin
            memory[addr[31:2]] <= writeData;
        end
    end

    // Asynchronous read
    assign readData = (memRead) ? memory[addr[31:2]] : 32'b0;

endmodule
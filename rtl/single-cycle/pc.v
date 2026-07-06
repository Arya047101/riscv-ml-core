module pc(
    input clk, 
    input rst,
    output [31:0] pc,
    output [31:0] nextpc
)

always@(posedge clk) begin 
    if(!rst) begin 
        pc <= 0;
        nextpc <= 0;
    end

    else begin 
        pc <= nextpc;
        nextpc <= pc + 4;
    end
end

endmodule 
module mac1 #(parameter PXLSIZE = 8, WGTSIZE = 8)(
    input clk, 
    input rst, 
    input [PXLSIZE-1:0] inputVector [0:783],
    input [WGTSIZE-1:0] weights [0:9][0:783], 
    input [31:0] bias [0:9],             
    output reg [31:0] op [0:9]
);

    integer i;
    reg [9:0] counter;
    reg processing_done;

    always @(posedge clk) begin 
        if (!rst) begin 
            counter <= 0;
            processing_done <= 0;
            for (i = 0; i < 10; i = i + 1) begin
                op[i] <= bias[i];
            end
        end else if (counter < 784) begin
            for (i = 0; i < 10; i = i + 1) begin
                op[i] <= op[i] + (inputVector[counter] * weights[i][counter]);
            end
            counter <= counter + 1;
        end else begin
            processing_done <= 1;
        end
    end 
endmodule
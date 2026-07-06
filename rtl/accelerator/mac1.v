module mac1 #(parameter PXLSIZE = 8, WGTSIZE =8)(
    input clk, 
    input rst, 
    input [PXLSIZE-1:0] inputVector [0:783],
    input [WGTSIZE-1:0] weights [0:9][0:783], 
    output reg [7:0] op [0:9]
);

always@(posedge clk) begin 
    if(!rst) begin 
        //reset things 
    end 

    else begin 
        

endmodule 
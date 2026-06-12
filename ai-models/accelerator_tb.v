`timescale 1ns/1ps
`include "accelerator.v"

module tb_ml_accelerator;

    //----------------------------------
    // DUT Signals
    //----------------------------------

    reg clk;
    reg rst;
    reg start;

    wire done;
    wire [3:0] prediction;

    //----------------------------------
    // Instantiate DUT
    //----------------------------------

    ml_accelerator dut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done),
        .prediction(prediction)
    );

    //----------------------------------
    // Clock
    //----------------------------------

    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end

    //----------------------------------
    // Load Image
    //----------------------------------

    integer i;

    initial begin

        //----------------------------------
        // Reset
        //----------------------------------

        rst = 1;
        start = 0;

        #20;

        rst = 0;

        //----------------------------------
        // Load image.hex
        //----------------------------------

        $readmemh(
            "output.hex",
            dut.image
        );

        $display("Image loaded.");

        //----------------------------------
        // Start accelerator
        //----------------------------------

        #20;

        start = 1;

        #10;

        start = 0;

        //----------------------------------
        // Wait for completion
        //----------------------------------

        wait(done);

        //----------------------------------
        // Display prediction
        //----------------------------------

        $display("--------------------------------");
        $display("Prediction = %0d", prediction);
        $display("--------------------------------");

        #50;

        //$finish;

    end

    integer fd;

    initial begin

        wait(done);

        fd = $fopen("prediction.txt","w");

        $fwrite(fd,"%0d",prediction);

        $fclose(fd);

        $finish;

    end

endmodule
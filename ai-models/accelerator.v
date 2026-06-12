module ml_accelerator(

    input clk,
    input rst,

    input start,

    output reg done,

    output reg [3:0] prediction

);

    //-------------------------------------------------
    // Memories
    //-------------------------------------------------

    reg [7:0] image [0:783];

    reg signed [7:0] w1 [0:12543];
    reg signed [7:0] b1 [0:15];

    reg signed [7:0] w2 [0:159];
    reg signed [7:0] b2 [0:9];

    //-------------------------------------------------
    // Activations
    //-------------------------------------------------

    reg signed [31:0] hidden [0:15];

    reg signed [31:0] logits [0:9];

    //-------------------------------------------------
    // Control
    //-------------------------------------------------

    integer neuron;
    integer pixel;

    reg signed [31:0] acc;

    reg [3:0] state;

    localparam IDLE      = 0;
    localparam L1_MAC    = 1;
    localparam L1_RELU   = 2;
    localparam L2_MAC    = 3;
    localparam ARGMAX    = 4;
    localparam FINISHED  = 5;

    //-------------------------------------------------
    // Weight Loading
    //-------------------------------------------------

    initial begin

        $readmemh("w1.hex", w1);

        $readmemh("b1.hex", b1);

        $readmemh("w2.hex", w2);

        $readmemh("b2.hex", b2);

    end

    //-------------------------------------------------
    // ReLU
    //-------------------------------------------------

    function signed [31:0] relu;

        input signed [31:0] x;

        begin

            if(x < 0)
                relu = 0;
            else
                relu = x;

        end

    endfunction

    //-------------------------------------------------
    // FSM
    //-------------------------------------------------

    integer i;

    reg signed [31:0] max_val;
    reg [3:0] max_idx;

    always @(posedge clk or posedge rst) begin

        if(rst) begin

            state <= IDLE;

            done <= 0;

            neuron <= 0;
            pixel <= 0;

            acc <= 0;

        end

        else begin

            case(state)

            //-----------------------------------------
            // WAIT
            //-----------------------------------------

            IDLE: begin

                done <= 0;

                if(start) begin

                    neuron <= 0;
                    pixel <= 0;
                    acc <= b1[0];

                    state <= L1_MAC;

                end

            end

            //-----------------------------------------
            // 784 -> 16
            //-----------------------------------------

            L1_MAC: begin

                acc <= acc +
                    $signed(image[pixel]) *
                    $signed(
                        w1[neuron*784 + pixel]
                    );

                if(pixel == 783) begin

                    hidden[neuron] <= relu(acc);

                    pixel <= 0;

                    if(neuron == 15) begin

                        neuron <= 0;

                        acc <= b2[0];

                        state <= L2_MAC;

                    end

                    else begin

                        neuron <= neuron + 1;

                        acc <= b1[neuron + 1];

                    end

                end

                else begin

                    pixel <= pixel + 1;
                end

            end

            //-----------------------------------------
            // 16 -> 10
            //-----------------------------------------

            L2_MAC: begin

                acc <= acc +
                    hidden[pixel] *
                    w2[neuron*16 + pixel];

                if(pixel == 15) begin

                    logits[neuron] <= acc;

                    pixel <= 0;

                    if(neuron == 9) begin

                        state <= ARGMAX;
                    end

                    else begin

                        neuron <= neuron + 1;

                        acc <= b2[neuron + 1];
                    end

                end

                else begin

                    pixel <= pixel + 1;
                end

            end

            //-----------------------------------------
            // ARGMAX
            //-----------------------------------------

            ARGMAX: begin

                max_val = logits[0];
                max_idx = 0;

                for(i=1;i<10;i=i+1) begin

                    if(logits[i] > max_val) begin

                        max_val = logits[i];
                        max_idx = i;

                    end

                end

                prediction <= max_idx;

                state <= FINISHED;

            end

            //-----------------------------------------
            // DONE
            //-----------------------------------------

            FINISHED: begin

                done <= 1;

            end

            endcase

        end

    end

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
//
// Create Date: 18.06.2026
// Design Name:
// Module Name: cosine_knn_top
// Description:
//////////////////////////////////////////////////////////////////////////////////

module cosine_knn_top(

    input clk,

    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,

    output done,
    output [3:0] nearest_neighbor_index,
    output [31:0] max_similarity_score

);

reg [3:0] addr;
reg [3:0] index;

wire [31:0] cosine_score;
wire [3:0] nearest_index_internal;

reg [31:0] score_mem [0:15];

reg [2:0] state;
reg [2:0] done_count;

integer i;

localparam S_ADDR  = 3'd0;
localparam S_WAIT1 = 3'd1;
localparam S_WAIT2 = 3'd2;
localparam S_WAIT3 = 3'd3;
localparam S_WAIT4 = 3'd4;
localparam S_WAIT5 = 3'd5;
localparam S_STORE = 3'd6;
localparam S_DONE  = 3'd7;

//----------------------------------------------------
// Done Logic
//----------------------------------------------------

assign done =
       (state == S_DONE) &&
       (done_count == 3'd6);

assign nearest_neighbor_index =
       (done) ? nearest_index_internal : 4'd0;

//----------------------------------------------------
// Initialization
//----------------------------------------------------

initial
begin

    state      = S_ADDR;
    addr       = 4'd0;
    index      = 4'd0;
    done_count = 3'd0;

    for(i = 0; i < 16; i = i + 1)
        score_mem[i] = 32'd0;

end

//----------------------------------------------------
// Cosine Engine
//----------------------------------------------------

bram_cosine_top COS_ENGINE(

    .clk(clk),
    .addr(addr),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .cosine_score(cosine_score)

);

//----------------------------------------------------
// 32-bit Maximum Finder
//----------------------------------------------------

max_finder_pipe MAX(

    .clk(clk),

    .d0(score_mem[0]),
    .d1(score_mem[1]),
    .d2(score_mem[2]),
    .d3(score_mem[3]),
    .d4(score_mem[4]),
    .d5(score_mem[5]),
    .d6(score_mem[6]),
    .d7(score_mem[7]),
    .d8(score_mem[8]),
    .d9(score_mem[9]),
    .d10(score_mem[10]),
    .d11(score_mem[11]),
    .d12(score_mem[12]),
    .d13(score_mem[13]),
    .d14(score_mem[14]),
    .d15(score_mem[15]),

    .max_score(max_similarity_score),
    .nearest_index(nearest_index_internal)

);

//----------------------------------------------------
// FSM
//----------------------------------------------------

always @(posedge clk)
begin

    case(state)

        //------------------------------------------------
        // Issue BRAM Address
        //------------------------------------------------

        S_ADDR:
        begin
            addr  <= index;
            state <= S_WAIT1;
        end

        //------------------------------------------------
        // Pipeline Wait States
        //------------------------------------------------

        S_WAIT1: state <= S_WAIT2;
        S_WAIT2: state <= S_WAIT3;
        S_WAIT3: state <= S_WAIT4;
        S_WAIT4: state <= S_WAIT5;
        S_WAIT5: state <= S_STORE;

        //------------------------------------------------
        // Store Score
        //------------------------------------------------

        S_STORE:
        begin

            score_mem[index] <= cosine_score;

            $display("ADDR=%0d  COSINE_SCORE=%0d",
                     index,
                     cosine_score);

            if(index == 4'd15)
            begin
                state <= S_DONE;
            end
            else
            begin
                index <= index + 1'b1;
                state <= S_ADDR;
            end

        end

        //------------------------------------------------
        // Finished
        //------------------------------------------------

        S_DONE:
        begin

            if(done_count == 3'd0)
            begin

                $display("====================================");
                $display("FINAL SCORE MEMORY DUMP");
                $display("====================================");

                $display("score_mem[0]  = %0d", score_mem[0]);
                $display("score_mem[1]  = %0d", score_mem[1]);
                $display("score_mem[2]  = %0d", score_mem[2]);
                $display("score_mem[3]  = %0d", score_mem[3]);
                $display("score_mem[4]  = %0d", score_mem[4]);
                $display("score_mem[5]  = %0d", score_mem[5]);
                $display("score_mem[6]  = %0d", score_mem[6]);
                $display("score_mem[7]  = %0d", score_mem[7]);
                $display("score_mem[8]  = %0d", score_mem[8]);
                $display("score_mem[9]  = %0d", score_mem[9]);
                $display("score_mem[10] = %0d", score_mem[10]);
                $display("score_mem[11] = %0d", score_mem[11]);
                $display("score_mem[12] = %0d", score_mem[12]);
                $display("score_mem[13] = %0d", score_mem[13]);
                $display("score_mem[14] = %0d", score_mem[14]);
                $display("score_mem[15] = %0d", score_mem[15]);

                $display("====================================");
                $display("MAX SCORE     = %0d", max_similarity_score);
                $display("MAX INDEX     = %0d", nearest_index_internal);
                $display("====================================");

            end

            if(done_count < 3'd6)
                done_count <= done_count + 1'b1;

            state <= S_DONE;

        end

        //------------------------------------------------
        // Default
        //------------------------------------------------

        default:
        begin
            state <= S_ADDR;
        end

    endcase

end

always @(posedge clk)
begin
    if(done)
    begin
        $display("FROM MAX MODULE = %h", MAX.max_score);
    end
end

endmodule

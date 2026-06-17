`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
//
// Create Date: 16.06.2026
// Design Name:
// Module Name: knn_bram_top
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
// BRAM-Based KNN Accelerator
//////////////////////////////////////////////////////////////////////////////////

module knn_bram_top(

    input clk,

    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,

    output done,
    output [3:0] nearest_index,
    output [17:0] min_distance

);

reg [3:0] addr;
reg [3:0] index;

wire [17:0] distance;
wire [3:0] nearest_index_internal;

reg [17:0] dist_mem [0:15];

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

assign done =
       (state == S_DONE) &&
       (done_count == 3'd6);

assign nearest_index =
       (done) ? nearest_index_internal : 4'd0;

initial
begin

    state      = S_ADDR;
    addr       = 4'd0;
    index      = 4'd0;
    done_count = 3'd0;

    for(i = 0; i < 16; i = i + 1)
        dist_mem[i] = 18'd0;

end

bram_distance_top DIST_ENGINE(

    .clk(clk),
    .addr(addr),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .distance(distance)

);

min_finder_pipe_16 MIN(

    .clk(clk),

    .d0(dist_mem[0]),
    .d1(dist_mem[1]),
    .d2(dist_mem[2]),
    .d3(dist_mem[3]),
    .d4(dist_mem[4]),
    .d5(dist_mem[5]),
    .d6(dist_mem[6]),
    .d7(dist_mem[7]),
    .d8(dist_mem[8]),
    .d9(dist_mem[9]),
    .d10(dist_mem[10]),
    .d11(dist_mem[11]),
    .d12(dist_mem[12]),
    .d13(dist_mem[13]),
    .d14(dist_mem[14]),
    .d15(dist_mem[15]),

    .min_distance(min_distance),
    .nearest_index(nearest_index_internal)

);

always @(posedge clk)
begin

    case(state)

        S_ADDR:
        begin
            addr  <= index;
            state <= S_WAIT1;
        end

        S_WAIT1:
        begin
            state <= S_WAIT2;
        end

        S_WAIT2:
        begin
            state <= S_WAIT3;
        end

        S_WAIT3:
        begin
            state <= S_WAIT4;
        end

        S_WAIT4:
        begin
            state <= S_WAIT5;
        end

        S_WAIT5:
        begin
            state <= S_STORE;
        end

        S_STORE:
        begin

            dist_mem[index] <= distance;

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

        S_DONE:
        begin

            if(done_count < 3'd6)
                done_count <= done_count + 1'b1;

            state <= S_DONE;

        end

        default:
        begin
            state <= S_ADDR;
        end

    endcase

end

endmodule

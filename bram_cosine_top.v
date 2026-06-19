`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
//
// Create Date: 17.06.2026
// Design Name:
// Module Name: bram_cosine_top
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
// Reads one vector from BRAM and computes Cosine Similarity Score
//////////////////////////////////////////////////////////////////////////////////

module bram_cosine_top(

    input clk,
    input [3:0] addr,

    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,

    output [31:0] cosine_score

);

wire [31:0] data;

wire [7:0] y0;
wire [7:0] y1;
wire [7:0] y2;
wire [7:0] y3;

blk_mem_gen_0 BRAM(

    .clka(clk),
    .ena(1'b1),
    .wea(1'b0),

    .addra(addr),

    .dina(32'd0),

    .douta(data)

);

unpacker UP(

    .data(data),

    .y0(y0),
    .y1(y1),
    .y2(y2),
    .y3(y3)

);

cosine_score COS(

    .clk(clk),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .y0(y0),
    .y1(y1),
    .y2(y2),
    .y3(y3),

    .cosine_score(cosine_score)

);

endmodule

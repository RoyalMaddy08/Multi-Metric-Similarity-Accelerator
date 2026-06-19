`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
//
// Create Date: 19.06.2026
// Design Name:
// Module Name: tb_similarity_accelerator
// Description:
// Testbench for Multi-Metric Similarity Accelerator
//////////////////////////////////////////////////////////////////////////////////

module tb_similarity_accelerator;

reg clk;
reg [1:0] mode;

reg [7:0] x0;
reg [7:0] x1;
reg [7:0] x2;
reg [7:0] x3;

wire done;
wire [3:0] nearest_neighbor_index;
wire [31:0] similarity_score;

//--------------------------------------------------
// DUT
//--------------------------------------------------

similarity_accelerator uut(

    .clk(clk),

    .mode(mode),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .done(done),

    .nearest_neighbor_index(nearest_neighbor_index),

    .similarity_score(similarity_score)

);

//--------------------------------------------------
// Clock
//--------------------------------------------------

always #5 clk = ~clk;

//--------------------------------------------------
// Test Sequence
//--------------------------------------------------

initial
begin

    clk = 0;

    //--------------------------------------------------
    // Query Vector
    //--------------------------------------------------

    x0 = 8'd10;
    x1 = 8'd10;
    x2 = 8'd10;
    x3 = 8'd11;

    //--------------------------------------------------
    // Euclidean Mode
    //--------------------------------------------------

    mode = 2'b00;

    wait(done);

    #20;

    $display("====================================");
    $display("EUCLIDEAN MODE");
    $display("Nearest Neighbor = %0d",
             nearest_neighbor_index);
    $display("Minimum Distance = %0d",
             similarity_score);
    $display("====================================");

    //--------------------------------------------------
    // Dot Product Mode
    //--------------------------------------------------

    mode = 2'b01;

    #20;

    $display("====================================");
    $display("DOT PRODUCT MODE");
    $display("Nearest Neighbor = %0d",
             nearest_neighbor_index);
    $display("Maximum Dot Score = %0d",
             similarity_score);
    $display("====================================");

    //--------------------------------------------------
    // Cosine Mode
    //--------------------------------------------------

    mode = 2'b10;

    #20;

    $display("====================================");
    $display("COSINE MODE");
    $display("Nearest Neighbor = %0d",
             nearest_neighbor_index);
    $display("Maximum Cosine Score = %0d",
             similarity_score);
    $display("====================================");

    //--------------------------------------------------
    // Finish
    //--------------------------------------------------

    #50;
    $finish;

end

endmodule

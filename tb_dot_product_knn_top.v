`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicu
// Engineer: Nambiar Akshay
//
// Create Date: 18.06.2026
// Design Name:
// Module Name: tb_dot_product_knn_top
// Description:
// Testbench for BRAM-Based Dot Product Search Accelerator
//////////////////////////////////////////////////////////////////////////////////

module tb_dot_product_knn_top;

reg clk;

reg [7:0] x0;
reg [7:0] x1;
reg [7:0] x2;
reg [7:0] x3;

wire done;
wire [3:0] nearest_neighbor_index;
wire [17:0] max_dot_score;

dot_product_knn_top uut(

    .clk(clk),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .done(done),

    .nearest_neighbor_index(nearest_neighbor_index),

    .max_dot_score(max_dot_score)

);

always #5 clk = ~clk;

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
    // Wait for Accelerator
    //--------------------------------------------------

    wait(done);

    #20;

    $display("====================================");
    $display("DOT PRODUCT SEARCH COMPLETED");
    $display("Query Vector          = (%0d,%0d,%0d,%0d)",
              x0,x1,x2,x3);

    $display("Nearest Neighbor IDX  = %0d",
              nearest_neighbor_index);

    $display("Maximum Dot Product   = %0d",
              max_dot_score);

    $display("====================================");

    #20;
    $finish;

end

endmodule

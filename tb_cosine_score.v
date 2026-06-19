`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 18.06.2026 13:35:12
// Design Name: 
// Module Name: tb_cosine_score
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_cosine_score;

reg clk;

reg [7:0] x0;
reg [7:0] x1;
reg [7:0] x2;
reg [7:0] x3;

reg [7:0] y0;
reg [7:0] y1;
reg [7:0] y2;
reg [7:0] y3;

wire [31:0] cosine_score_out;

cosine_score uut(

    .clk(clk),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .y0(y0),
    .y1(y1),
    .y2(y2),
    .y3(y3),

    .cosine_score(cosine_score_out)

);

always #5 clk = ~clk;

initial
begin

    clk = 0;

    //--------------------------------------------------
    // Test Vector
    //--------------------------------------------------

    x0 = 8'd1;
    x1 = 8'd2;
    x2 = 8'd3;
    x3 = 8'd4;

    y0 = 8'd1;
    y1 = 8'd2;
    y2 = 8'd3;
    y3 = 8'd4;

    //--------------------------------------------------
    // Wait for pipeline to settle
    //--------------------------------------------------

    #100;

    $display("====================================");
    $display("COSINE SCORE DEBUG");
    $display("====================================");

    $display("dot_score       = %0d", uut.dot_score);

    $display("mx_sq           = %0d", uut.mx_sq);
    $display("my_sq           = %0d", uut.my_sq);

    $display("inv_x           = %0d", uut.inv_x);
    $display("inv_y           = %0d", uut.inv_y);

    $display("norm_factor     = %0d", uut.norm_factor);

    $display("dot_score_reg   = %0d", uut.dot_score_reg);
    $display("norm_factor_reg = %0d", uut.norm_factor_reg);

    $display("------------------------------------");

    $display("cosine_score    = %0d", cosine_score_out);
    $display("expected        = 66270");

    $display("====================================");

    #20;
    $finish;

end

endmodule

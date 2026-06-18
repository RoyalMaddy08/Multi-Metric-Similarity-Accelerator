`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 11:49:58
// Design Name: 
// Module Name: tb_max_finder_pipe_16
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

module tb_max_finder_pipe_16;

reg clk;

reg [17:0] d0;
reg [17:0] d1;
reg [17:0] d2;
reg [17:0] d3;
reg [17:0] d4;
reg [17:0] d5;
reg [17:0] d6;
reg [17:0] d7;
reg [17:0] d8;
reg [17:0] d9;
reg [17:0] d10;
reg [17:0] d11;
reg [17:0] d12;
reg [17:0] d13;
reg [17:0] d14;
reg [17:0] d15;

wire [17:0] max_score;
wire [3:0] nearest_index;

max_finder_pipe_16 uut(

    .clk(clk),

    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .d8(d8),
    .d9(d9),
    .d10(d10),
    .d11(d11),
    .d12(d12),
    .d13(d13),
    .d14(d14),
    .d15(d15),

    .max_score(max_score),
    .nearest_index(nearest_index)

);

always #5 clk = ~clk;

initial
begin

    clk = 0;

    d0  = 18'd10;
    d1  = 18'd20;
    d2  = 18'd30;
    d3  = 18'd40;
    d4  = 18'd50;
    d5  = 18'd60;
    d6  = 18'd70;
    d7  = 18'd80;
    d8  = 18'd90;
    d9  = 18'd100;
    d10 = 18'd110;
    d11 = 18'd120;
    d12 = 18'd130;
    d13 = 18'd140;
    d14 = 18'd150;
    d15 = 18'd160;

    // 4 pipeline stages
    #60;

    $display("--------------------------------");
    $display("MAX SCORE     = %0d", max_score);
    $display("EXPECTED      = 160");
    $display("NEAREST INDEX = %0d", nearest_index);
    $display("EXPECTED IDX  = 15");
    $display("--------------------------------");

    #20;
    $finish;

end

endmodule

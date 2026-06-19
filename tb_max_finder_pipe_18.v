`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 20.06.2026 00:20:10
// Design Name: 
// Module Name: tb_max_finder_pipe_18
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

module tb_max_finder_pipe_18;

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

max_finder_pipe_18 uut(

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
    d1  = 18'd25;
    d2  = 18'd50;
    d3  = 18'd70;
    d4  = 18'd100;
    d5  = 18'd120;
    d6  = 18'd150;
    d7  = 18'd175;

    d8  = 18'd200;
    d9  = 18'd225;
    d10 = 18'd250;
    d11 = 18'd275;
    d12 = 18'd300;
    d13 = 18'd325;
    d14 = 18'd350;
    d15 = 18'd400;

    // 4 pipeline stages
    #50;

    $display("================================");
    $display("MAX FINDER TEST");
    $display("MAX SCORE     = %0d", max_score);
    $display("EXPECTED      = 400");
    $display("MAX INDEX     = %0d", nearest_index);
    $display("EXPECTED IDX  = 15");
    $display("================================");

    #20;
    $finish;

end

endmodule

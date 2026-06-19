`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 16.06.2026 07:18:24
// Design Name: 
// Module Name: tb_min_finder
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


module tb_min_finder_16;

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

wire [17:0] min_distance;
wire [3:0] nearest_index;

min_finder_16 uut(

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

    .min_distance(min_distance),
    .nearest_index(nearest_index)

);

initial begin

    // Distances from your waveform

    d0  = 18'd6;
    d1  = 18'd70;
    d2  = 18'd10;
    d3  = 18'd55;
    d4  = 18'd14;
    d5  = 18'd6;
    d6  = 18'd14;
    d7  = 18'd30;
    d8  = 18'd54;
    d9  = 18'd86;
    d10 = 18'd126;
    d11 = 18'd174;
    d12 = 18'd230;
    d13 = 18'd294;
    d14 = 18'd366;
    d15 = 18'd400;

    #10;

    $display("Minimum Distance = %d", min_distance);
    $display("Nearest Index    = %d", nearest_index);

    #10;
    $finish;

end

endmodule

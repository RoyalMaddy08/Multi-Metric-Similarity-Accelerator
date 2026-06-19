`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 15.06.2026 19:48:33
// Design Name: 
// Module Name: tb_euclidean
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




module tb_euclidean;

reg [7:0] x0,x1,x2,x3;
reg [7:0] y0,y1,y2,y3;

wire [17:0] distance;

euclidean uut(
    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .y0(y0),
    .y1(y1),
    .y2(y2),
    .y3(y3),

    .distance(distance)
);

initial begin

    x0 = 2;
    x1 = 3;
    x2 = 1;
    x3 = 4;

    y0 = 1;
    y1 = 5;
    y2 = 2;
    y3 = 2;

    #10;

    $display("Distance = %d", distance);

    $finish;

end

endmodule

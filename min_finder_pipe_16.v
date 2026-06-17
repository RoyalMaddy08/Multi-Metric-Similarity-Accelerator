`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 17.06.2026 09:17:18
// Design Name: 
// Module Name: min_finder_tree_16
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


module min_finder_pipe_16(

    input clk,

    input [17:0] d0,
    input [17:0] d1,
    input [17:0] d2,
    input [17:0] d3,
    input [17:0] d4,
    input [17:0] d5,
    input [17:0] d6,
    input [17:0] d7,
    input [17:0] d8,
    input [17:0] d9,
    input [17:0] d10,
    input [17:0] d11,
    input [17:0] d12,
    input [17:0] d13,
    input [17:0] d14,
    input [17:0] d15,

    output reg [17:0] min_distance,
    output reg [3:0] nearest_index

);

reg [17:0] s1_dist [0:7];
reg [3:0]  s1_idx  [0:7];
always @(posedge clk)
begin

    {s1_dist[0],s1_idx[0]} <=
        (d0 <= d1) ? {d0,4'd0} : {d1,4'd1};

    {s1_dist[1],s1_idx[1]} <=
        (d2 <= d3) ? {d2,4'd2} : {d3,4'd3};

    {s1_dist[2],s1_idx[2]} <=
        (d4 <= d5) ? {d4,4'd4} : {d5,4'd5};

    {s1_dist[3],s1_idx[3]} <=
        (d6 <= d7) ? {d6,4'd6} : {d7,4'd7};

    {s1_dist[4],s1_idx[4]} <=
        (d8 <= d9) ? {d8,4'd8} : {d9,4'd9};

    {s1_dist[5],s1_idx[5]} <=
        (d10 <= d11) ? {d10,4'd10} : {d11,4'd11};

    {s1_dist[6],s1_idx[6]} <=
        (d12 <= d13) ? {d12,4'd12} : {d13,4'd13};

    {s1_dist[7],s1_idx[7]} <=
        (d14 <= d15) ? {d14,4'd14} : {d15,4'd15};

end 

reg [17:0] s2_dist [0:3];
reg [3:0]  s2_idx  [0:3];
always @(posedge clk)
begin

    {s2_dist[0],s2_idx[0]} <=
        (s1_dist[0] <= s1_dist[1]) ?
        {s1_dist[0],s1_idx[0]} :
        {s1_dist[1],s1_idx[1]};

    {s2_dist[1],s2_idx[1]} <=
        (s1_dist[2] <= s1_dist[3]) ?
        {s1_dist[2],s1_idx[2]} :
        {s1_dist[3],s1_idx[3]};

    {s2_dist[2],s2_idx[2]} <=
        (s1_dist[4] <= s1_dist[5]) ?
        {s1_dist[4],s1_idx[4]} :
        {s1_dist[5],s1_idx[5]};

    {s2_dist[3],s2_idx[3]} <=
        (s1_dist[6] <= s1_dist[7]) ?
        {s1_dist[6],s1_idx[6]} :
        {s1_dist[7],s1_idx[7]};

end 

reg [17:0] s3_dist [0:1];
reg [3:0]  s3_idx  [0:1];
always @(posedge clk)
begin

    {s3_dist[0],s3_idx[0]} <=
        (s2_dist[0] <= s2_dist[1]) ?
        {s2_dist[0],s2_idx[0]} :
        {s2_dist[1],s2_idx[1]};

    {s3_dist[1],s3_idx[1]} <=
        (s2_dist[2] <= s2_dist[3]) ?
        {s2_dist[2],s2_idx[2]} :
        {s2_dist[3],s2_idx[3]};

end 

always @(posedge clk)
begin

    if(s3_dist[0] <= s3_dist[1])
    begin
        min_distance  <= s3_dist[0];
        nearest_index <= s3_idx[0];
    end
    else
    begin
        min_distance  <= s3_dist[1];
        nearest_index <= s3_idx[1];
    end

end 
endmodule

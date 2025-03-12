`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2025 15:28:45
// Design Name: 
// Module Name: ssd_counter
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
module ssd_counter(clk,reset, anode,segment);
input clk,reset;
output reg [7:0]anode;
output reg [6:0]segment;
reg [26:0]clk_count;
reg [3:0]seg_count;
parameter counttill = 50000000-1;// 50000000-1
reg clk_1sec ;

always @(posedge clk or posedge reset)begin
if(reset==1)begin
    clk_count <= 0;
    clk_1sec <=0;
end
else if(clk_count == counttill)begin
    clk_1sec <=~clk_1sec;
    clk_count <=0;    
end 
else
    clk_count <= clk_count+1;
end

always @(posedge clk_1sec or posedge reset)begin
if(reset==1||seg_count ==4'b1001)begin
    seg_count <= 0;
end
else        
    seg_count <= seg_count+1;   
end

always@(*)
begin
    case(seg_count)
    4'b0000 : segment = 7'b1000000;
    4'b0001 : segment = 7'b1111001;
    4'b0010 : segment = 7'b0100100;
    4'b0011 : segment = 7'b0110000;
    4'b0100 : segment = 7'b0011001;
    4'b0101 : segment = 7'b0010010;
    4'b0110 : segment = 7'b0000010;
    4'b0111 : segment = 7'b1111000;
    4'b1000 : segment = 7'b0000000;
    4'b1001 : segment = 7'b0010000;
    default : segment = 7'b1111111;  
    endcase
end

always @(*)begin
    anode = 8'b11111110;
end

endmodule

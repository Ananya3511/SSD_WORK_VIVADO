`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2025 20:35:47
// Design Name: 
// Module Name: IN_OUT_test
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
module IN_OUT_test(in_clk,count,reset);
input in_clk,reset; 
output reg [15:0]count;
reg [26:0] counter =0;
parameter max_count = (50000000-1);
always@(posedge in_clk or posedge reset)begin
if (reset==1)begin
count <= 0;
counter <=0;
end
else if(counter == max_count)begin
counter <=0;
count <= count+1;
end
else if(count ==15)
count <= 0;
else
counter <= counter+1;
end

endmodule

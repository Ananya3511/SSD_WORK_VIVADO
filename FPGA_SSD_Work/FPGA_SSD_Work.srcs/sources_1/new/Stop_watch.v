`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2025 18:13:06
// Design Name: 
// Module Name: Stop_watch
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

module Stop_watch(clk,reset,anode,segment,stop);
input clk,reset,stop;
output reg [0:7] anode;
output reg [6:0] segment; 

reg [19:0] millisec_counter;

reg clk_milli;

parameter one_millisec = 500000 - 1;
always@(posedge clk or posedge reset)begin
if(reset )begin
    millisec_counter <=0;
    clk_milli <=0;
end
else begin
    if( millisec_counter == one_millisec)begin
    clk_milli <= ~clk_milli;
    millisec_counter <=0;
    end
    else
    millisec_counter <= millisec_counter +1;
end
end

reg [6:0] millisec,sec,min;
reg [4:0]hr;
always @(posedge clk_milli or posedge reset)begin
if(reset)begin
    millisec <=0;
    sec <=0;
    min <=0;
    hr  <=0;
end
else begin
    if(stop == 1)begin
    min <= min;
    sec <= sec;
    millisec <= millisec;
    hr <= hr;
    end
    else begin
    case ({hr ==99,min == 59, sec == 59, millisec == 99})
    4'b1111: begin 
            min <= 0;
            sec <= 0;
            millisec <= 0;
            hr <=0;

            end
    4'b0111: begin 
            hr <= hr +1;
            min <= 0;
            sec <= 0;
            millisec <= 0;
            end
    4'b0011: begin 
            min <= min +1;
            sec <= 0;
            millisec <= 0;
            end
   4'b0001: begin 
            sec <= sec +1;
            millisec <= 0;
            end     
                      
    default: begin  millisec <= millisec + 1;end
    endcase
    end
end
end

reg [2:0] display_anode;
reg [3:0] display_digit;
reg [14:0]count;

always @(posedge clk or posedge reset) begin
    if(reset==1)begin
    count<=0;
    display_anode <= 0;
    end
    else begin 
        if(count==10000)begin
           count<=0;
           display_anode <= display_anode + 1;
           if(display_anode ==7)
              display_anode<=0;
        end
              else 
              count<=count+1;                   
       end
end

always @(*) begin
    case (display_anode)
        3'd0: begin anode = 8'b11111110; display_digit = millisec % 10; end
        3'd1: begin anode = 8'b11111101; display_digit = millisec / 10; end
        3'd2: begin anode = 8'b11111011; display_digit = sec % 10; end
        3'd3: begin anode = 8'b11110111; display_digit = sec / 10; end
        3'd4: begin anode = 8'b11101111; display_digit = min % 10; end
        3'd5: begin anode = 8'b11011111; display_digit = min / 10; end
        3'd6: begin anode = 8'b10111111; display_digit = hr % 10; end
        3'd7: begin anode = 8'b01111111; display_digit = hr / 10; end
        default: begin anode = 8'b11111111; display_digit = 4'd0; end
    endcase
end


always @(*) begin
    case (display_digit)
        4'd0: segment = 7'b1000000;
        4'd1: segment = 7'b1111001;
        4'd2: segment = 7'b0100100;
        4'd3: segment = 7'b0110000;
        4'd4: segment = 7'b0011001;
        4'd5: segment = 7'b0010010;
        4'd6: segment = 7'b0000010;
        4'd7: segment = 7'b1111000;
        4'd8: segment = 7'b0000000;
        4'd9: segment = 7'b0010000;
        default: segment = 7'b1111111;
    endcase
end
endmodule

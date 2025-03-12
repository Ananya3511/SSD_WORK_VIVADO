module Digita_clk(clk,reset,anode,segment);

input clk, reset;             
output reg [0:7] anode;
output reg [6:0] segment; 
reg [26:0] sec_counter;
reg [5:0] seconds, minutes;
reg [4:0] hours;
reg clk_1s;

parameter COUNT_1SEC = 5_00_00_000  - 1; //50000000 - 1

always @(posedge clk or posedge reset) begin
if (reset) begin
    sec_counter <= 0;
    clk_1s <= 0;
end 
else if(sec_counter == COUNT_1SEC)begin
    clk_1s <=~clk_1s;
    sec_counter <= 0;
end
else 
    sec_counter <= sec_counter + 1;    
end

always @(posedge clk_1s or posedge reset) begin
if (reset) begin
    hours <= 0;
    minutes <= 0;
    seconds <= 0;
end 

else begin
    case ({hours == 23, minutes == 59, seconds == 59})
    3'b111: begin 
            hours <= 0;
            minutes <= 0;
            seconds <= 0;
            end
    3'b011: begin 
            hours <= hours + 1;
            minutes <= 0;
            seconds <= 0;
            end
    3'b001: begin 
            minutes <= minutes + 1;
            seconds <= 0;
            end
    default: begin  seconds <= seconds + 1;end
    endcase
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
        if(count==10_000)begin
           count<=0;
           display_anode <= display_anode + 1;
           if(display_anode ==5)
              display_anode<=0;
        end
              else 
              count<=count+1;                   
       end
end

always @(*) begin
    case (display_anode)
        3'd0: begin anode = 8'b11111110; display_digit = seconds % 10; end
        3'd1: begin anode = 8'b11111101; display_digit = seconds / 10; end
        3'd2: begin anode = 8'b11111011; display_digit = minutes % 10; end
        3'd3: begin anode = 8'b11110111; display_digit = minutes / 10; end
        3'd4: begin anode = 8'b11101111; display_digit = hours % 10; end
        3'd5: begin anode = 8'b11011111; display_digit = hours / 10; end
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



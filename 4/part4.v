module fullspeed(CLOCK_50,pulse);
input CLOCK_50;
output pulse;
reg [25:0]counter;
always@(posedge CLOCK_50)
begin
if(pulse)
counter<=0;
else
counter<=counter+1'b1;
end
assign pulse=(counter==26'D1);
endmodule


module oneHz(CLOCK_50,pulse);
input CLOCK_50;
output pulse;
reg [25:0]counter;
always@(posedge CLOCK_50)
begin
if(pulse)
counter<=0;
else
counter<=counter+1'b1;
end
assign pulse=(counter==26'D49999999);
endmodule


module halfHz(CLOCK_50,pulse);
input CLOCK_50;
output pulse;
reg [26:0]counter;
always@(posedge CLOCK_50)
begin
if(pulse)
counter<=0;
else
counter<=counter+1'b1;
end
assign pulse=(counter==27'D99999999);
                        
endmodule


module quarterHz(CLOCK_50,pulse);
input CLOCK_50;
output pulse;
reg [27:0]counter;
always@(posedge CLOCK_50)
begin
if(pulse)
counter<=0;
else
counter<=counter+1'b1;
end
assign pulse=(counter==28'D199999999);
endmodule




module bit3Tff(clk,Q);
input clk;
output [2:0]Q;
wire [2:0]A;
reg [2:0]counter;
always@(posedge clk)
begin
if(A)
counter<=0;
else
counter<=counter+1'b1;
end
assign A=(counter==3'b101);
assign Q=counter;
endmodule






module showDecimal0(a,hex);
input [2:0]a;
output reg [6:0]hex;
always@*
 case(a)
 3'b000: hex = 7'b0111000;//L
 3'b001: hex = 7'b1111001;//E
 3'b010: hex = 7'b1110111;//A
 3'b011: hex = 7'b1110001;//F
 3'b100: hex = 7'b1111101;//6
 3'b101: hex = 7'b0000111;//7
 default  hex = 7'b0000000;


 endcase
endmodule


module showDecimal1(a,hex);
input [2:0]a;
output reg [6:0]hex;
always@*
 case(a)
 3'b000: hex = 7'b1111001;//E
 3'b001: hex = 7'b1110111;//A
 3'b010: hex = 7'b1110001;//F
 3'b011: hex = 7'b1111101;//6
 3'b100: hex = 7'b0000111;//7
 3'b101: hex = 7'b0111000;//L
 default  hex = 7'b0000000;
 endcase
endmodule


module showDecimal2(a,hex);
input [2:0]a;
output reg [6:0]hex;
always@*
 case(a)
 3'b000: hex = 7'b1110111;//A
 3'b001: hex = 7'b1110001;//F
 3'b010: hex = 7'b1111101;//6
 3'b011: hex = 7'b0000111;//7
 3'b100: hex = 7'b0111000;//L
 3'b101: hex = 7'b1111001;//E
 default  hex = 7'b0000000;
 endcase
endmodule


module showDecimal3(a,hex);
input [2:0]a;
output reg [6:0]hex;
always@*
 case(a)
 3'b000: hex = 7'b1110001;//F
 3'b001: hex = 7'b1111101;//6
 3'b010: hex = 7'b0000111;//7
 3'b011: hex = 7'b0111000;//L
 3'b100: hex = 7'b1111001;//E
 3'b101: hex = 7'b1110111;//A
 default  hex = 7'b0000000;
 endcase
endmodule


module showDecimal4(a,hex);
input [2:0]a;
output reg [6:0]hex;
always@*
 case(a)
 3'b000: hex = 7'b1111101;//6
 3'b001: hex = 7'b0000111;//7
 3'b010: hex = 7'b0111000;//L
 3'b011: hex = 7'b1111001;//E
 3'b100: hex = 7'b1110111;//A
 3'b101: hex = 7'b1110001;//F
 default  hex = 7'b0000000;
 endcase
endmodule


module showDecimal5(a,hex);
input [2:0]a;
output reg [6:0]hex;
always@*
 case(a)
 3'b000: hex = 7'b0000111;//7
 3'b001: hex = 7'b0111000;//L
 3'b010: hex = 7'b1111001;//E
 3'b011: hex = 7'b1110111;//A
 3'b100: hex = 7'b1110001;//F
 3'b101: hex = 7'b1111101;//6
 default  hex = 7'b0000000;
 endcase
endmodule




module part4(SW,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,CLOCK_50);
input [1:0]SW;
input CLOCK_50;
output [6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
wire pulsefull,pulse1,pulsehalf,pulsequarter;
wire [2:0]Q;
wire [6:0]H0,H1,H2,H3,H4,H5;
fullspeed z1(CLOCK_50,pulsefull);
oneHz z2(CLOCK_50,pulse1);
halfHz z3(CLOCK_50,pulsehalf);
quarterHz z4(CLOCK_50,pulsequarter);
reg pulse;
always@(pulse1,pulsehalf,pulsequarter,SW[0],SW[1])
begin
if(~SW[1]&~SW[0])
pulse<=pulsefull;
else if(~SW[1]&SW[0])
pulse<=pulse1;
else if(SW[1]&~SW[0])
pulse<=pulsehalf;
else if(SW[1]&SW[0])
pulse<=pulsequarter;
end
bit3Tff u1(pulse,Q);
showDecimal0 y0(Q,H0[6:0]);
showDecimal1 y1(Q,H1[6:0]);
showDecimal2 y2(Q,H2[6:0]);
showDecimal3 y3(Q,H3[6:0]);
showDecimal4 y4(Q,H4[6:0]);
showDecimal5 y5(Q,H5[6:0]);
assign HEX0=~H0;
assign HEX1=~H1;
assign HEX2=~H2;
assign HEX3=~H3;
assign HEX4=~H4;
assign HEX5=~H5;
endmodule
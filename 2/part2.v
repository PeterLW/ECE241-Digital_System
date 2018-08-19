
module Dff(input D,clock,output reg Q);
always@(posedge clock)
Q<=D;
endmodule

module seg3(data,h1,h2,h3,h4);
input [3:0]data;
output reg [6:0]h1,h2,h3,h4;
always@(*)
begin
case(data)
4'b0001:
begin
h1=7'b00110000;
h2=7'b00010000;
h2=7'b00010000;
h4=7'b01001000;
end

4'b1000:
begin
h4=7'b00110000;
h1=7'b00010000;
h2=7'b00010000;
h3=7'b01001000;
end
4'b0100:
begin
h3=7'b00110000;
h4=7'b00010000;
h1=7'b00010000;
h2=7'b01001000;
end
4'b0010:
begin
h2=7'b00110000;
h3=7'b00010000;
h4=7'b00010000;
h1=7'b01001000;
end
endcase
end

endmodule


module part2(KEY,Q,HEX0,HEX1,HEX2,HEX3);
input [1:0]KEY;
output [3:0]Q;
output [6:0]HEX0,HEX1,HEX2,HEX3;
assign Q[0]=1'b0;
assign Q[1]=1'b0;
assign Q[2]=1'b0;
assign Q[3]=1'b1; 
wire [6:0]x1,x2,x3,x4;

Dff a1(Q[0],KEY[0],Q[1]);
Dff a2(Q[1],KEY[0],Q[2]);
Dff a3(Q[2],KEY[0],Q[3]);
Dff a4(Q[3],KEY[0],Q[0]);

seg3 F(Q,x1,x2,x3,x4);

assign HEX0=x4;
assign HEX1=x3;
assign HEX2=x2;
assign HEX3=x1;

endmodule


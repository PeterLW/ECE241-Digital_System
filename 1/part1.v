module TFF2(T,clk,reset,Q);
input T,clk,reset;
output reg Q;
always@(posedge clk,negedge reset)
begin
if(~reset)
Q<=1'b0;
else if(T)
Q<=!Q;
end
endmodule

module seg2(data,H);
input [3:0]data;
output reg [6:0]H;
always@(*)
begin
case(data)
4'b0000:H=7'b1000000;
4'b0001:H=7'b1111001;
4'b0010:H=7'b0100100;
4'b0011:H=7'b0110000;
4'b0100:H=7'b0011001;
4'b0101:H=7'b0010010;
4'b0110:H=7'b0000010;
4'b0111:H=7'b1111000;
4'b1000:H=7'b0000000;
4'b1001:H=7'b0010000;
4'b1010:H=7'b0001000;
4'b1011:H=7'b0000011;
4'b1100:H=7'b1000110;
4'b1101:H=7'b0100001;
4'b1110:H=7'b0000110;
4'b1111:H=7'b0001110;
default H=7'b1111111;
endcase
end
endmodule

//module subcct(input T,clk,reset,output out);
//wire w;
//TFF2 U(T,clk,reset,w);
//assign out=w&T;
//endmodule

module part1(input [1:0]SW,KEY,output [6:0]HEX0,HEX1);

wire [7:0] w;
wire [6:0]h1,h2;
wire [7:0]q;

TFF2 u1(SW[1],KEY[0],SW[0],w[0]);
assign q[0]=SW[0]&w[0];

TFF2 u2(q[0],KEY[0],SW[0],w[1]);
assign q[1]=q[0]&w[1];

TFF2 u3(q[1],KEY[0],SW[0],w[2]);
assign q[2]=q[1]&w[2];

TFF2 u4(q[2],KEY[0],SW[0],w[3]);
assign q[3]=q[2]&w[3];

TFF2 u5(q[3],KEY[0],SW[0],w[4]);
assign q[4]=q[3]&w[4];

TFF2 u6(q[4],KEY[0],SW[0],w[5]);
assign q[5]=q[4]&w[5];

TFF2 u7(q[5],KEY[0],SW[0],w[6]);
assign q[6]=q[5]&w[6];

TFF2 u8(q[6],KEY[0],SW[0],w[7]);
assign q[7]=q[6]&w[7];

seg2 v1(w[3:0],h1);
seg2 v2(w[6:4],h2);
assign HEX0=h1;
assign HEX1=h2;

endmodule


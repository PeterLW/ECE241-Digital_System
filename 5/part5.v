module reg8(D,reset,clock,Q);
input [7:0]D;
input reset,clock;
output reg [7:0]Q;

always@(posedge clock,negedge reset)
if(!reset)
Q<=0;
else
Q<=D;
endmodule

module Dff2(input D,clock,reset,output reg Q);

always@(posedge clock,negedge reset)
if(!reset)
Q<=0;
else
Q<=D;
endmodule

module adder8(input[7:0]a,b,input Cin,output[7:0]sum,output Cout);

assign {Cout,sum}=a+b+Cin;

endmodule

module part5(SW,KEY,LEDR);//key0=reset,key1=clk,overflow=ledr8
input [7:0]SW;
input [1:0]KEY;
output [8:0]LEDR;

wire [7:0]regis,Sout,LEDR2;
wire Co;


reg8 u1(SW,KEY[0],KEY[1],regis);
adder8 u2(regis,LEDR2,1'b0,Sout,Co);
Dff2 u3(Co,KEY[0],KEY[1],LEDR[8]);
reg8 u4(Sout,KEY[0],KEY[1],LEDR2);

assign LEDR[7:0]=LEDR2;

endmodule


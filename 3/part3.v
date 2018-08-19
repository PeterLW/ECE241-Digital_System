module hexseg(data,H);
input [3:0]data;
output reg [6:0]H;
always@(*)
begin
case(data)
4'b0000:H=7'b1000000;//Give value to H[7] to H[0] one by one
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

module counter_26bit(S,K,Q);
input [1:0]S;//this input is for enable and clear s[0] is clear while s[1] is enable
input [1:0]K;
output reg [25:0]Q;
wire Enable,Clear;
assign Clock=K[0];
assign Enable=S[1];
assign Clear=S[0];

always@(negedge Clear,posedge Clock)
if(Clear==0)
Q<=0;
else if(Enable==1)
Q<=Q+1;

endmodule

module counter_27bit(S,K,Q);
input [1:0]S;//this input is for enable and clear s[0] is clear while s[1] is enable
input [1:0]K;
output reg [26:0]Q;
wire Enable,Clear;
assign Clock=K[0];
assign Enable=S[1];
assign Clear=S[0];

always@(negedge Clear,posedge Clock)
if(Clear==0)
Q<=0;
else if(Enable==1)
Q<=Q+1;

endmodule

module counter_28bit(S,K,Q);
input [1:0]S;//this input is for enable and clear s[0] is clear while s[1] is enable
input [1:0]K;
output reg [27:0]Q;
wire Enable,Clear;
assign Clock=K[0];
assign Enable=S[1];
assign Clear=S[0];

always@(negedge Clear,posedge Clock)
if(Clear==0)
Q<=0;
else if(Enable==1)
Q<=Q+1;

endmodule
//////////above are the RateDividers
module counter_4bit(E,S,K,Q);
input S,E;
input [1:0]K;
output reg [3:0]Q;
wire Enable,Clear;
assign Clock=K[0];
assign Enable=E;
assign Clear=S;

always@(negedge Clear,posedge Clock)
if(Clear==0)
Q<=0;
else if(Enable==1)
Q<=Q+1;

endmodule
//////////////////////////////
module part3(SW,CLOCK_50,HEX0);
//recall module counter_26bit(S,K,Q); s[0] is clear s[1] is enable
input [3:0]SW;
input CLOCK_50;
output [6:0]HEX0;
wire [80:0]Q;
wire [4:0]w;
wire [3:0]data;
counter_26bit c0(SW[3:2],CLOCK_50,Q[25:0]);//SW[3]is enable SW[2]is active-low clear
counter_27bit c1(SW[3:2],CLOCK_50,Q[52:26]);
counter_28bit c2(SW[3:2],CLOCK_50,Q[80:53]);
assign w[0]=~SW[1]&~SW[0];
assign w[1]=~SW[1]&SW[0]&Q[25]&Q[24]&Q[23]&Q[22]&Q[21]&Q[20]
&Q[19]&Q[18]&Q[17]&Q[16]&Q[15]&Q[14]&Q[13]&Q[12]&Q[11]&Q[10]&Q[9]&Q[8]&Q[7]&Q[6]&Q[5]&Q[4]&Q[3]&Q[2]&Q[1]&Q[0];
assign w[2]=SW[1]&~SW[0]&Q[52]&Q[51]&Q[50]&Q[49]&Q[48]&Q[47]
&Q[46]&Q[45]&Q[44]&Q[43]&Q[42]&Q[41]&Q[40]&Q[39]&Q[38]&Q[37]&Q[36]&Q[35]&Q[34]&Q[33]&Q[32]&Q[31]&Q[30]
&Q[29]&Q[28]&Q[27]&Q[26];
assign w[3]=SW[1]&SW[0]&Q[80]&Q[79]&Q[78]&Q[77]&Q[76]&Q[75]
&Q[74]&Q[73]&Q[72]&Q[71]&Q[70]&Q[69]&Q[68]&Q[67]&Q[66]&Q[65]&Q[64]&Q[63]&Q[62]&Q[61]&Q[60]&Q[59]&Q[58]
&Q[57]&Q[56]&Q[55]&Q[54]&Q[53];
assign w[4]=w[3]|w[2]|w[1]|w[0];
counter_4bit c3(w[4],SW[2],CLOCK_50,data);//recall module counter_4bit(E,S,K,Q); E enable, S clear, K clock,Q output

hexseg h0(data,HEX0);
endmodule

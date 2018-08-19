module sketch//QSIM前的修改：把所有14改成1 countdelay由10000000改为1 将inital mushroom的位置改为了 0 15 原来是30和45

 (
  CLOCK_50,      // On Board 50 MHz
  KEY,       // Push Button[3:0]
  SW,        // DPDT Switch[17:0]
  VGA_CLK,         // VGA Clock
  VGA_HS,       // VGA H_SYNC
  VGA_VS,       // VGA V_SYNC
  VGA_BLANK,      // VGA BLANK
  VGA_SYNC,      // VGA SYNC
  VGA_R,         // VGA Red[9:0]
  VGA_G,        // VGA Green[9:0]
  VGA_B,         // VGA Blue[9:0]
 //THIS IS TO SIMULATE FSM
  xx,
  yy,
  currentstate,
  color,
  countx,
  county,
  countx2,
  county2,
  countxg,
  countyg,
  realx,
  realy,
  realxt,
  realyt,
  currentstatet,
  startt,
  donet,
  countcasetrap,
  HEX0,
  HEX1,
  HEX2,
  HEX3,
  HEX4,
  HEX5,
  HEX6,
  HEX7,
  giveasecond,
  countsecond
 );

 input   CLOCK_50;    // 50 MHz
 input [3:0] KEY;     // Button[3:0]
 input [2:0] SW;      // Switches[0:0]
 output   VGA_CLK;       // VGA Clock
 output   VGA_HS;     // VGA H_SYNC
 output   VGA_VS;     // VGA V_SYNC
 output   VGA_BLANK;    // VGA BLANK
 output   VGA_SYNC;    // VGA SYNC
 output [9:0] VGA_R;       // VGA Red[9:0]
 output [9:0] VGA_G;      // VGA Green[9:0]
 output [9:0] VGA_B;       // VGA Blue[9:0]


 reg [7:0]mark;
 wire [7:0]markwire;
 assign markwire=mark;
 reg writeEn;
 output reg[7:0]xx;
 output reg[6:0]yy;
 output reg[7:0] realx;
 output reg[6:0] realy;
 output [6:0]HEX0;
 output [6:0]HEX1;
 output [6:0]HEX2;
 output [6:0]HEX3;
 output [6:0]HEX4;
 output [6:0]HEX5; 
 output [6:0]HEX6;
 output [6:0]HEX7;
 assign HEX2=7'b1111111;
 assign HEX3=7'b1111111;
 assign HEX6=7'b1111111;
 assign HEX7=7'b1111111;

   ///////////////////////////////////////////////////////////////////////////FSM

 output reg [3:0]countx;
 output reg [3:0]county;
 output reg [3:0]countx2;
 output reg [3:0]county2;
 reg [25:0] countdelay;
 reg [25:0] countcleardelay;
 reg [7:0] countclearx;
 reg [6:0] countcleary;
 output reg [3:0]currentstate;
 reg [3:0]nextstate;
 reg start;
 output reg startt;
 reg startb;
 reg startt2;
 assign resetn=SW[0];
 wire [2:0]colorwire;
 wire [2:0]colorwire1;
 wire [2:0]colorwire2;
 wire [2:0]colorwire3;
 wire [2:0]colorwire4;//trap2
 wire [2:0]colorwire5;//clear
 wire [6:0]hexh0;
 wire [6:0]hexh1;
 wire [6:0]hexh2;
 wire [6:0]hexh3;
 
 wire [7:0]addresswire;
 wire [7:0]addresswire1;
 wire [7:0]addresswire2;
 wire [7:0]addresswire3;
 wire [7:0]addresswire4;//trap2
 wire [14:0]addresswire5;//clear
 reg [2:0] colorq;
 reg [7:0] maddress;
 reg [14:0] clearaddress;
 assign HEX5=hexh3;
 assign HEX4=hexh2;
 assign HEX1=hexh1;
 assign HEX0=hexh0;
 output reg [2:0]color;
 wire [7:0]timewire;
 output reg [25:0]giveasecond;
 reg timeup;
 output reg [7:0]countsecond;
 assign timewire=countsecond;
 initial timeup=0;
 initial countsecond=8'b00111011;//59
 
 always@(posedge CLOCK_50)
 begin
 if(giveasecond<26'b11111111111111111111111111)
 giveasecond<=giveasecond+1;
 else
 begin
 giveasecond<=0;
 countsecond<=countsecond-1;
	if(countsecond==0)
	timeup<=1;
 end
 end

decimalseg d1(markwire,hexh1,hexh0);
decimalseg d2(timewire,hexh3,hexh2);
Mario m(
	addresswire,
	CLOCK_50,
	data,
	wren,
	colorwire);
	
Mushroom m1(
	addresswire1,
	CLOCK_50,
	data,
	wren,
	colorwire1);

Trap t(
	addresswire2,
	CLOCK_50,
	data,
	wren,
	colorwire2);

MushroomBlue m2(
	addresswire3,
	CLOCK_50,
	data,
	wren,
	colorwire3);	
Trap t2(
	addresswire4,
	CLOCK_50,
	data,
	wren,
	colorwire4);
Gameover g(
	addresswire5,
	CLOCK_50,
	data,
	wren,
	colorwire5);
	

assign addresswire=maddress;
assign addresswire1=gaddress;
assign addresswire2=taddress;
assign addresswire3=baddress;
assign addresswire4=t2address;
assign addresswire5=clearaddress;

 parameter idle=4'b0000, erasex=4'b0001, erasey=4'b0010, move=4'b0011, drawx=4'b0100,drawy=4'b0101, 
			  delay=4'b0110,inputcol=4'b0111,check=4'b1000,check2=4'b1001,check3=4'b1010,check4=4'b1011,
			  clearx=4'b1100,cleary=4'b1101,inputclear=4'b1110,delayclear=4'b1111;
 initial currentstate=4'b0000;
 
 always@(*)
 begin
 case (currentstate)
 idle:
 begin
 if(!KEY[3])
 nextstate=erasex;
 else if(!KEY[2])
 nextstate=erasex;
 else if(!KEY[1])
 nextstate=erasex;
 else if(!KEY[0])
 nextstate=erasex;

 else
 nextstate=idle;
 end

 erasex:
 begin
 if(countx<14)//2'b10=2 这里其实是画3*3 并不是2*2的方块 想一想是为什么 去看一下lab7 part2 同样的道理
 nextstate=erasex;
 else
 nextstate=erasey;
 end
 erasey:

 begin
 if(county<14)//2'b10=2 这里其实是画3*3 并不是2*2的方块 想一想是为什么 去看一下lab7 part2 同样的道理
 nextstate=erasex;
 else
 nextstate=move;
 end

 move:
 begin
 if(realx==realxg&&realy==realyg)
 nextstate=check;
 else if(realx==realxt&&realy==realyt)
 nextstate=check2;
 else if(realx==realxb&&realy==realyb)
 nextstate=check3;
 else if(realx==realxt2&&realy==realyt2)
 nextstate=check4;
 else if((realx==0&&realy==105)||(realx==105&&realy==30)||(realx==90&&realy==105)||timeup==1)
 nextstate=inputclear;
 else nextstate=inputcol;
 end
 
 
 inputclear:
 begin
 nextstate=clearx;
 end

 clearx:
 begin
 if(countclearx<159)
 nextstate=inputclear;
 else
 nextstate=cleary;
 end
 
 cleary:
 begin
 if(countcleary<119)
 nextstate=clearx;
 else
 nextstate=delayclear;
 end
 
 delayclear:
 if(countcleardelay==100)
 nextstate=idle;
 else
 nextstate=delayclear;
 
 
 check://check red mushroom
 begin
 if(done==0)
 nextstate=check;
 else
 nextstate=inputcol;
 end

 check2://check trap
 begin
 if(donet==0)
 nextstate=check2;
 else
 nextstate=inputcol;
 end
 
 check3://check blue mushroom
 begin
 if(doneb==0)
 nextstate=check3;
 else
 nextstate=inputcol;
 end
 
 check4:
 if(donet2==0)
 nextstate=check4;
 else
 nextstate=inputcol;
 
 
 inputcol:
 begin
 nextstate=drawx;
 end

 drawx:
 begin
 if(countx2<14)
 nextstate=inputcol;
 else
 nextstate=drawy;
 end
 
 drawy:
 begin
 if(county2<14)
 nextstate=drawx;
 else
 nextstate=delay;
 end

 delay:
 if(countdelay==10000000)
 nextstate=idle;
 else
 nextstate=delay;
 
 default:
 nextstate=idle;

endcase

end

/////////////////directly above is the code for state assignment

/////////////////directly below is the code for FLIP FLOP


always@(posedge CLOCK_50)//FF for the first FSM

begin
 currentstate<=nextstate;
 if(done==1) start<=0;//如果done=1说明第二个FSM已经做好事情了 已经画好了新的蘑菇。那么第一个FSM可以继续做事情 移动马里奥
 if(donet==1) startt<=0;
 if(doneb==1) startb<=0;
 if(donet2==1) startt2<=0;
 
 case(currentstate)
 idle:
 begin
 countdelay<=0;
 countx<=0;
 county<=0;
 countx2<=0;
 county2<=0;
 maddress<=0;
 end

 erasex:
 countx<=countx+1;

 erasey:
 begin
 countx<=0;
 county<=county+1;
 end

 move:
 begin
 if(realx==realxg&&realy==realyg) 
 begin
 start<=1;
 mark<=mark+1;
 end
 else if(realx==realxt&&realy==realyt) 
 begin
 startt<=1;
 mark<=mark-1;
 end
 else if(realx==realxb&&realy==realyb) 
 begin
 startb<=1;
 mark<=mark+2;
 end
 else if(realx==realxt2&&realy==realyt2)
 begin
 startt2<=1;
 mark<=mark-1;
 end
 else begin 
 start<=0;
 startt<=0;
 startb<=0;
 end
 
 countx<=0;
 county<=0;
 //All these numbers indicating the feasible movment fot Mario
 if(!KEY[3]&&((realx==0&&realy==15)||(realx==0&&realy==30)||(realx==0&&realy==45)||(realx==0&&realy==60
 )||(realx==0&&realy==75)||(realx==0&&realy==90)||(realx==15&&realy==105)||(realx==30&&realy==30)
 ||(realx==30&&realy==45)||(realx==30&&realy==60)||(realx==30&&realy==75)||(realx==45&&realy==15)
 ||(realx==45&&realy==105)||(realx==60&&realy==30)||(realx==60&&realy==75)||(realx==60&&realy==90)||(realx==75&&realy==15)
 ||(realx==75&&realy==90)||(realx==90&&realy==30)||(realx==90&&realy==45)||(realx==90&&realy==60)
 ||(realx==105&&realy==15)||(realx==105&&realy==105)||(realx==120&&realy==75)||(realx==135&&realy==30)||(realx==135&&realy==45)
 ||(realx==135&&realy==60)||(realx==135&&realy==75)||(realx==135&&realy==90)||(realx==135&&realy==105))) 
 
 realy<=realy-15;// UP
 /////////////////////////////////////////////
 if(!KEY[2]&&((realx==0&&realy==0)||(realx==0&&realy==15)||(realx==0&&realy==30)||(realx==0&&realy==45
 )||(realx==0&&realy==60)||(realx==0&&realy==75)||(realx==0&&realy==90)||(realx==15&&realy==90)||(realx==30&&realy==15)
 ||(realx==30&&realy==30)||(realx==30&&realy==45)||(realx==30&&realy==60)||(realx==45&&realy==0)
 ||(realx==45&&realy==90)||(realx==60&&realy==15)||(realx==60&&realy==60)||(realx==60&&realy==75)||(realx==75&&realy==0)
 ||(realx==75&&realy==75)||(realx==90&&realy==15)||(realx==90&&realy==30)||(realx==90&&realy==45)||(realx==90&&realy==90)
 ||(realx==105&&realy==0)||(realx==105&&realy==15)||(realx==105&&realy==90)||(realx==120&&realy==60)||(realx==135&&realy==15)||(realx==135&&realy==30)
 ||(realx==135&&realy==45)||(realx==135&&realy==60)||(realx==135&&realy==75)||(realx==135&&realy==90))) 
 
 realy<=realy+15;// DOWN
 //////////////////////////////////////////////
 if(!KEY[1]&&((realx==15&&realy==0)||(realx==15&&realy==30)||(realx==15&&realy==90)||(realx==15&&realy==105
 )||(realx==30&&realy==30)||(realx==30&&realy==105)||(realx==45&&realy==15)||(realx==45&&realy==60)||(realx==45&&realy==105)
 ||(realx==60&&realy==15)||(realx==60&&realy==60)||(realx==60&&realy==90)||(realx==75&&realy==15)
 ||(realx==75&&realy==75)||(realx==75&&realy==90)||(realx==90&&realy==15)||(realx==90&&realy==45)||(realx==90&&realy==90)
 ||(realx==105&&realy==15)||(realx==105&&realy==60)||(realx==105&&realy==90)||(realx==105&&realy==105)
 ||(realx==120&&realy==60)||(realx==120&&realy==105)||(realx==135&&realy==60)||(realx==135&&realy==75)||(realx==135&&realy==105))) 
 
 realx<=realx-15;//LEFT
 
 //////////////////////////////////////////////////////////
 if(!KEY[0]&&((realx==0&&realy==0)||(realx==0&&realy==30)||(realx==0&&realy==90)||(realx==15&&realy==30)||(realx==15&&realy==105)||(realx==30&&realy==15)||(realx==30&&realy==60)||(realx==30&&realy==105)
 ||(realx==45&&realy==15)||(realx==45&&realy==60)||(realx==45&&realy==90)||(realx==60&&realy==15)
 ||(realx==60&&realy==75)||(realx==60&&realy==90)||(realx==75&&realy==15)||(realx==75&&realy==45)||(realx==75&&realy==90)
 ||(realx==90&&realy==15)||(realx==90&&realy==30)||(realx==90&&realy==60)||(realx==90&&realy==90)
 ||(realx==105&&realy==60)||(realx==105&&realy==105)||(realx==120&&realy==60)||(realx==120&&realy==75)||(realx==120&&realy==105))) 
 
 realx<=realx+15;//RIGHT
 
 end
 
 clearx:
 begin
 countclearx<=countclearx+1;
 clearaddress<=clearaddress+1;
 end
 
 cleary: begin
 countclearx<=0;
 countcleary<=countcleary+1;
 end
 
 delayclear:
 countcleardelay<=countcleardelay+1'b1;
 
 drawx:
 begin
 countx2<=countx2+1;
 maddress<=maddress+1;
 end
 
 drawy: begin
 countx2<=0;
 county2<=county2+1;
 end

 delay:
 countdelay<=countdelay+1'b1;
 endcase
 end


 /////////////directly below is the code for the output

 always@(*)
 begin
 
	case(currentstate)
	idle:
	begin
	xx=realx;
	yy=realy;
	writeEn=0;
	color=3'bxxx;//xxx待改回
	end

	erasex:
	begin
	xx=realx+countx;
	yy=realy+county;
	color=3'b111;
	writeEn=1;
	end
	
	erasey:
	begin
	xx=realx;
	yy=realy+county;//+1;
	writeEn=0;
	color=3'bxxx;
	end


	move:  
	begin
	xx=realx;
	yy=realy;
	writeEn=0;
	color=3'bxxx;
	end
 
 	clearx:
	begin
	xx=countclearx;
	yy=countcleary;
	color=colorwire5;//should be colorwire
	writeEn=1;
	end

	cleary:
	begin
	xx=0;
	yy=county2;
	writeEn=0;
	color=3'bxxx;
	end
 
 
	drawx:
	begin
	xx=realx+countx2;
	yy=realy+county2;
	color=colorwire;//should be colorwire
	writeEn=1;
	end

	drawy:
	begin
	xx=realx;
	yy=realy+county2;
	writeEn=0;
	color=3'bxxx;
	end

	default:
	begin
	xx=8'bxxxxxxxx;
	yy=7'bxxxxxxx;
	writeEn=0;
	color=3'bxxx;
	end
 
 endcase//////////////////////////////////////////////////////////////////below is the output for the second FSM
 
case(currentstateg)
	
	drawxg:
	begin
	xx=realxg+countxg;
	yy=realyg+countyg;
	color=colorwire1;///////待改成RAM
	writeEn=1;
	end

	drawyg:
	begin
	xx=realxg;
	yy=realyg+countyg;
	writeEn=0;
	color=3'bxxx;
	end
endcase
	
	/////////////////////
case(currentstatet)
	
	drawxt:
	begin
	xx=realxt+countxt;
	yy=realyt+countyt;
	color=colorwire2;///////待改成RAM
	writeEn=1;
	end

	drawyt:
	begin
	xx=realxt;
	yy=realyt+countyt;
	writeEn=0;
	color=3'bxxx;
	end
endcase

case(currentstateb)
	
	drawxb:
	begin
	xx=realxb+countxb;
	yy=realyb+countyb;
	color=colorwire3;///////待改成RAM
	writeEn=1;
	end

	drawyb:
	begin
	xx=realxb;
	yy=realyb+countyb;
	writeEn=0;
	color=3'bxxx;
	end
endcase
////////////////////////////////////////////////////////trap2
case(currentstatet2)
	
	drawxt2:
	begin
	xx=realxt2+countxt2;
	yy=realyt2+countyt2;
	color=colorwire4;///////待改成RAM
	writeEn=1;
	end

	drawyt2:
	begin
	xx=realxt2;
	yy=realyt2+countyt2;
	writeEn=0;
	color=3'bxxx;
	end
endcase

end
 
 reg[7:0]realxg;
 reg[6:0]realyg;
 output reg [3:0]countxg;
 output reg [3:0]countyg;
 initial realxg=45;//45////////////////////////////////////////////////////////////////
 initial realyg=60;//60///////////////////////////////////////////////////////////////////////////
 reg [7:0]gaddress;
 reg [3:0]countcase;
 initial countcase=0;
 reg done;
 reg[2:0]currentstateg;
 reg[2:0]nextstateg;
 initial currentstateg=3'b000;
 parameter idle2=3'b000,prep=3'b001,drawxg=3'b011,drawyg=3'b100,donestate=3'b101,inputcolg=3'b010;

 always@(*)
 begin
 case(currentstateg)
 idle2:
 if(start==1) nextstateg=prep;
 else nextstateg=idle2;

 prep:
 nextstateg=inputcolg;
 
 inputcolg:
 nextstateg=drawxg;
 
 drawxg:
 begin
 if(countxg<14)
 nextstateg=inputcolg;
 else
 nextstateg=drawyg;
 end
 
 drawyg:
 begin
 if(countyg<14)
 nextstateg=drawxg;
 else
 nextstateg=donestate;
 end

 donestate:
 if(start==0&&done==0)
 nextstateg=idle2;
 else nextstateg=donestate;
 
 default:
 nextstateg=idle2;
 endcase 
 end
 
 always@(posedge CLOCK_50)
 begin
 currentstateg<=nextstateg;
 if(start==0) done<=0;
 case(currentstateg)
 idle2:
 begin
 countxg<=0;
 countyg<=0;
 done<=0;
 gaddress<=0;// countcase清零勿忘记
 
 end
 
 prep:
 begin
 case(countcase)
 0:
  begin
  realxg<=45;
  realyg<=15;
  end
 1:
  begin
  realxg<=75;
  realyg<=45;
  end  
 2:
  begin
  realxg<=105;
  realyg<=60;
  end  
 3:
  begin
  realxg<=75;
  realyg<=90;
  end  
 4:
  begin
  realxg<=135;
  realyg<=15;
  end
 5:
  begin
  realxg<=0;
  realyg<=105;
  end
 6:
  begin
  realxg<=135;
  realyg<=90;
  end
 7:
  begin
  realxg<=0;
  realyg<=45;
  end
 8:
  begin
  realxg<=90;
  realyg<=15;
  end
 9:
  begin
  realxg<=15;
  realyg<=30;
  end
 10:
  begin
  realxg<=0;
  realyg<=0;
  end
 11:
  begin
  realxg<=135;
  realyg<=45;
  end
 12:
  begin
  realxg<=60;
  realyg<=30;
  end
 13:
  begin
  realxg<=60;
  realyg<=75;
  end
 14:
  begin
  realxg<=30;
  realyg<=30;
  end
 15:
  begin
  realxg<=105;
  realyg<=105;
  end
 
 endcase
 //需要加更多的case
 countcase<=countcase+1;
 end
 ///////////////////////////////////
 drawxg:
 begin
 countxg<=countxg+1;
 gaddress<=gaddress+1;
 end
 
 drawyg: 
 begin
 countxg<=0;
 countyg<=countyg+1;
 end

 donestate:
 begin
 done<=1;
 if(start==0) done<=0;
 end
 endcase
 end
////////////////////////
//below is the FSM for the trap//////////////////////////////////////////////////////////////////////////////////////
 output reg[7:0]realxt;
 output reg[6:0]realyt;
 reg [3:0]countxt;
 reg [3:0]countyt;
 initial realxt=30;//30
 initial realyt=45;//45
 reg [7:0]taddress;
 output reg [2:0]countcasetrap;
 initial countcasetrap=0;
 output reg donet;
 output reg[2:0]currentstatet;
 reg[2:0]nextstatet;
 initial currentstatet=3'b000;
 parameter idle3=3'b000,prept=3'b001,drawxt=3'b011,drawyt=3'b100,donestatet=3'b101,inputcolt=3'b010;

 always@(*)
 begin
 case(currentstatet)
 idle3:
 if(startt==1) nextstatet=prept;
 else nextstatet=idle3;

 prept:
 nextstatet=inputcolt;
 
 inputcolt:
 nextstatet=drawxt;
 
 drawxt:
 begin
 if(countxt<14)
 nextstatet=inputcolt;
 else
 nextstatet=drawyt;
 end
 
 drawyt:
 begin
 if(countyt<14)
 nextstatet=drawxt;
 else
 nextstatet=donestatet;
 end

 donestatet:
 if(startt==0&&donet==0)
 nextstatet=idle3;
 else nextstatet=donestatet;
 
 default:
 nextstatet=idle3;
 endcase 
 end
 
 always@(posedge CLOCK_50)
 begin
 currentstatet<=nextstatet;
 if(startt==0) donet<=0;
 case(currentstatet)
 idle3:
 begin
 countxt<=0;
 countyt<=0;
 donet<=0;
 taddress<=0;// countcase清零勿忘记
 
 end
 
 prept:
 begin
 case(countcasetrap)
 0:
  begin
  realxt<=90;	
  realyt<=30;
  end
 1:
  begin
  realxt<=135;
  realyt<=60;
  end  
 2:
  begin
  realxt<=105;
  realyt<=90;
  end  
 3:
  begin
  realxt<=45;
  realyt<=90;
  end  
 4:
  begin
  realxt<=60;
  realyt<=15;
  end
 5:
  begin
  realxt<=120;
  realyt<=75;
  end
 6:
  begin
  realxt<=60;
  realyt<=60;
  end
 7:
  begin
  realxt<=0;
  realyt<=60;
  end
 
 endcase
 //需要加更多的case
 countcasetrap<=countcasetrap+1;
 end
 ///////////////////////////////////
 drawxt:
 begin
 countxt<=countxt+1;
 taddress<=taddress+1;
 end
 
 drawyt: 
 begin
 countxt<=0;
 countyt<=countyt+1;
 end

 donestatet:
 begin
 donet<=1;
 if(startt==0) donet<=0;
 end
 endcase
 end
 
 ////////////////////////below is the FSM for the BLUE MUSHROOM//////////////////////////////////

 reg[7:0]realxb;
 reg[6:0]realyb;
 reg [3:0]countxb;
 reg [3:0]countyb;
 initial realxb=120;//30
 initial realyb=60;//45
 reg [7:0]baddress;
 reg [1:0]countcaseblue;
 initial countcaseblue=0;
 reg doneb;
 reg[2:0]currentstateb;
 reg[2:0]nextstateb;
 initial currentstateb=3'b000;
 parameter idle4=3'b000,prepb=3'b001,drawxb=3'b011,drawyb=3'b100,donestateb=3'b101,inputcolb=3'b010;

 always@(*)
 begin
 case(currentstateb)
 idle4:
 if(startb==1) nextstateb=prepb;
 else nextstateb=idle4;

 prepb:
 nextstateb=inputcolb;
 
 inputcolb:
 nextstateb=drawxb;
 
 drawxb:
 begin
 if(countxb<14)
 nextstateb=inputcolb;
 else
 nextstateb=drawyb;
 end
 
 drawyb:
 begin
 if(countyb<14)
 nextstateb=drawxb;
 else
 nextstateb=donestateb;
 end

 donestateb:
 if(startb==0&&doneb==0)
 nextstateb=idle4;
 else nextstateb=donestateb;
 
 default:
 nextstateb=idle4;
 endcase 
 end
 
 always@(posedge CLOCK_50)
 begin
 currentstateb<=nextstateb;
 if(startb==0) doneb<=0;
 case(currentstateb)
 idle4:
 begin
 countxb<=0;
 countyb<=0;
 doneb<=0;
 baddress<=0;// countcase清零勿忘记
 
 end
 
 prepb:
 begin
 case(countcaseblue)
 0:
  begin
  realxb<=105;	
  realyb<=0;
  end
 1:
  begin
  realxb<=15;
  realyb<=105;
  end  
 2:
  begin
  realxb<=30;
  realyb<=75;
  end  
 3:
  begin
  realxb<=15;
  realyb<=0;
  end  
 
 endcase
 //需要加更多的case
 countcaseblue<=countcaseblue+1;
 end
 ///////////////////////////////////
 drawxb:
 begin
 countxb<=countxb+1;
 baddress<=baddress+1;
 end
 
 drawyb: 
 begin
 countxb<=0;
 countyb<=countyb+1;
 end

 donestateb:
 begin
 doneb<=1;
 if(startb==0) doneb<=0;
 end
 endcase
 end
/////////////////////////////////////////////////////////////////////////////
 reg[7:0]realxt2;
 reg[6:0]realyt2;
 reg [3:0]countxt2;
 reg [3:0]countyt2;
 initial realxt2=135;//30
 initial realyt2=75;//45
 reg [7:0]t2address;
 reg [2:0]countcasetrap2;
 initial countcasetrap2=0;
 reg donet2;
 reg[2:0]currentstatet2;
 reg[2:0]nextstatet2;
 initial currentstatet2=3'b000;
 parameter idle5=3'b000,prept2=3'b001,drawxt2=3'b011,drawyt2=3'b100,donestatet2=3'b101,inputcolt2=3'b010;

 always@(*)
 begin
 case(currentstatet2)
 idle5:
 if(startt2==1) nextstatet2=prept2;
 else nextstatet2=idle5;

 prept2:
 nextstatet2=inputcolt2;
 
 inputcolt2:
 nextstatet2=drawxt2;
 
 drawxt2:
 begin
 if(countxt2<14)
 nextstatet2=inputcolt2;
 else
 nextstatet2=drawyt2;
 end
 
 drawyt2:
 begin
 if(countyt2<14)
 nextstatet2=drawxt2;
 else
 nextstatet2=donestatet2;
 end

 donestatet2:
 if(startt2==0&&donet2==0)
 nextstatet2=idle5;
 else nextstatet2=donestatet2;
 
 default:
 nextstatet2=idle5;
 endcase 
 end
 
 always@(posedge CLOCK_50)
 begin
 currentstatet2<=nextstatet2;
 if(startt2==0) donet2<=0;
 case(currentstatet2)
 idle5:
 begin
 countxt2<=0;
 countyt2<=0;
 donet2<=0;
 t2address<=0;// countcase清零勿忘记
 
 end
 
 prept2:
 begin
 case(countcasetrap2)
 0:
  begin
  realxt2<=45;	
  realyt2<=105;
  end
 1:
  begin
  realxt2<=30;
  realyt2<=60;
  end  
 2:
  begin
  realxt2<=45;
  realyt2<=0;
  end  
 3:
  begin
  realxt2<=0;
  realyt2<=90;
  end  
 4:
  begin
  realxt2<=135;
  realyt2<=30;
  end
 5:
  begin
  realxt2<=90;
  realyt2<=60;
  end
 6:
  begin
  realxt2<=30;
  realyt2<=15;
  end
 7:
  begin
  realxt2<=0;
  realyt2<=30;
  end
 
 endcase
 //需要加更多的case
 countcasetrap2<=countcasetrap2+1;
 end
 ///////////////////////////////////
 drawxt2:
 begin
 countxt2<=countxt2+1;
 t2address<=t2address+1;
 end
 
 drawyt2: 
 begin
 countxt2<=0;
 countyt2<=countyt2+1;
 end

 donestatet2:
 begin
 donet2<=1;
 if(startt2==0) donet2<=0;
 end
 endcase
 end
 
 
 vga_adapter VGA(

   .resetn(resetn),

   .clock(CLOCK_50),

   .colour(color),

   .x(xx),

   .y(yy),

   .plot(writeEn),

   /* Signals for the DAC to drive the monitor. */

   .VGA_R(VGA_R),

   .VGA_G(VGA_G),

   .VGA_B(VGA_B),

   .VGA_HS(VGA_HS),

   .VGA_VS(VGA_VS),

   .VGA_BLANK(VGA_BLANK),

   .VGA_SYNC(VGA_SYNC),

   .VGA_CLK(VGA_CLK));

  defparam VGA.RESOLUTION = "160x120";

  defparam VGA.MONOCHROME = "FALSE";

  defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;

  defparam VGA.BACKGROUND_IMAGE = "Map.mif";

 endmodule
 

 
module decimalseg(data,H0,H1);

input [7:0]data;
output reg [6:0]H0;
output reg [6:0]H1;

always@(*)

begin
case(data)
8'b00000000://0
begin
H0=7'b1000000;
H1=7'b1000000;
end

8'b00000001://1
begin
H0=7'b1000000;
H1=7'b1111001;
end

8'b00000010://2
begin
H0=7'b1000000;
H1=7'b0100100;
end

8'b00000011://3
begin
H0=7'b1000000;
H1=7'b0110000;
end

8'b00000100://4
begin
H0=7'b1000000;
H1=7'b0011001;
end
8'b00000101://5
begin
H0=7'b1000000;
H1=7'b0010010;
end
8'b00000110://6
begin
H0=7'b1000000;
H1=7'b0000010;
end
8'b00000111://7
begin
H0=7'b1000000;
H1=7'b1111000;
end
8'b00001000://8
begin
H0=7'b1000000;
H1=7'b0000000;
end
8'b00001001://9
begin
H0=7'b1000000;
H1=7'b0010000;
end




8'b00001010://10
begin
H0=7'b1111001;
H1=7'b1000000;
end
8'b00001011://11
begin
H0=7'b1111001;
H1=7'b1111001;
end
8'b00001100://12
begin
H0=7'b1111001;
H1=7'b0100100;
end
8'b00001101://13
begin
H0=7'b1111001;
H1=7'b0110000;
end
8'b00001110://14
begin
H0=7'b1111001;
H1=7'b0011001;
end
8'b00001111://15
begin
H0=7'b1111001;
H1=7'b0010010;
end
8'b00010000://16
begin
H0=7'b1111001;
H1=7'b0000010;
end
8'b00010001://17
begin
H0=7'b1111001;
H1=7'b1111000;
end
8'b00010010://18
begin
H0=7'b1111001;
H1=7'b0000000;
end
8'b00010011://19
begin
H0=7'b1111001;
H1=7'b0010000;
end



8'b00010100://20
begin
H0=7'b0100100;
H1=7'b1000000;
end
8'b00010101://21
begin
H0=7'b0100100;
H1=7'b1111001;
end
8'b00010110://22
begin
H0=7'b0100100;
H1=7'b0100100;
end
8'b00010111://23
begin
H0=7'b0100100;
H1=7'b0110000;
end
8'b00011000://24
begin
H0=7'b0100100;
H1=7'b0011001;
end
8'b00011001://25
begin
H0=7'b0100100;
H1=7'b0010010;
end
8'b00011010://26
begin
H0=7'b0100100;
H1=7'b0000010;
end
8'b00011011://27
begin
H0=7'b0100100;
H1=7'b1111000;
end
8'b00011100://28
begin
H0=7'b0100100;
H1=7'b0000000;
end
8'b00011101://29
begin
H0=7'b0100100;
H1=7'b0010000;
end
8'b00011110://30
begin
H0=7'b0110000;
H1=7'b1000000;
end
/////////////////////////////////////////////////////////////////////////31-60
8'b00011111://31
begin
H0=7'b0110000;
H1=7'b1111001;
end
8'b00100000://32
begin
H0=7'b0110000;
H1=7'b0100100;
end
8'b00100001://33
begin
H0=7'b0110000;
H1=7'b0110000;
end
8'b00100010://34
begin
H0=7'b0110000;
H1=7'b0011001;
end
8'b00100011://35
begin
H0=7'b0110000;
H1=7'b0010010;
end
8'b00100100://36
begin
H0=7'b0110000;
H1=7'b0000010;
end
8'b00100101://37
begin
H0=7'b0110000;
H1=7'b1111000;
end
8'b00100110://38
begin
H0=7'b0110000;
H1=7'b0000000;
end
8'b00100111://39
begin
H0=7'b0110000;
H1=7'b0010000;
end

8'b00101000://40
begin
H0=7'b0011001;
H1=7'b1000000;
end
8'b00101001://41
begin
H0=7'b0011001;
H1=7'b1111001;
end
8'b00101010://42
begin
H0=7'b0011001;
H1=7'b0100100;
end
8'b00101011://43
begin
H0=7'b0011001;
H1=7'b0110000;
end
8'b00101100://44
begin
H0=7'b0011001;
H1=7'b0011001;
end
8'b00101101://45
begin
H0=7'b0011001;
H1=7'b0010010;
end
8'b00101110://46
begin
H0=7'b0011001;
H1=7'b0000010;
end
8'b00101111://47
begin
H0=7'b0011001;
H1=7'b1111000;
end
8'b00110000://48
begin
H0=7'b0011001;
H1=7'b0000000;
end
8'b00110001://49
begin
H0=7'b0011001;
H1=7'b0010000;
end

8'b00110010://50
begin
H0=7'b0010010;
H1=7'b1000000;
end
8'b00110011://51
begin
H0=7'b0010010;
H1=7'b1111001;
end
8'b00110100://52
begin
H0=7'b0010010;
H1=7'b0100100;
end
8'b00110101://53
begin
H0=7'b0010010;
H1=7'b0110000;
end
8'b00110110://54
begin
H0=7'b0010010;
H1=7'b0011001;
end
8'b00110111://55
begin
H0=7'b0010010;
H1=7'b0010010;
end
8'b00111000://56
begin
H0=7'b0010010;
H1=7'b0000010;
end
8'b00111001://57
begin
H0=7'b0010010;
H1=7'b1111000;
end
8'b00111010://58
begin
H0=7'b0010010;
H1=7'b0000000;
end
8'b00111011://59
begin
H0=7'b0010010;
H1=7'b0010000;
end
8'b00111100://60
begin
H0=7'b0000010;
H1=7'b1000000;
end
/////////////////////////////////////////////////////////////////////////////default case
default:
begin
H0=7'b1000000;
H1=7'b1000000;
end
endcase
end

endmodule

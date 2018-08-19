module sketch
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
  LEDR  //THIS IS TO SIMULATE FSM
 );
 input   CLOCK_50;    // 50 MHz
 input [3:0] KEY;     // Button[3:0]
 input [17:0] SW;      // Switches[0:0]
 output   VGA_CLK;       // VGA Clock 
 output   VGA_HS;     // VGA H_SYNC
 output   VGA_VS;     // VGA V_SYNC
 output   VGA_BLANK;    // VGA BLANK
 output   VGA_SYNC;    // VGA SYNC
 output [9:0] VGA_R;       // VGA Red[9:0]
 output [9:0] VGA_G;      // VGA Green[9:0]
 output [9:0] VGA_B;       // VGA Blue[9:0]
 output [4:0] LEDR;
 

 // Create the color, x, y and writeEn wires that are inputs to the controller.
 
 wire [7:0] x;
 wire [6:0] y;
 reg writeEn;
 assign x=SW[7:0];
 assign y=SW[14:8];
 reg[7:0]xx;
 reg[6:0]yy;
   ///////////////////////////////////////////////////////////////////////////FSM
 reg [7:0]countx1;
 reg [6:0]county1;
 reg [2:0]countx2;
 reg [2:0]county2;
 reg [2:0]currentstate;
 reg [2:0]nextstate;
 wire[2:0]inputcolor;
 assign inputcolor=SW[17:15];
 reg [2:0]color;
 wire up;
 wire down;
 wire left;
 wire rigth;
 assign up = KEY[3];
 assign down=KEY[2]; 
 assign left=KEY[1];
 assign right=KEY[0];
 initial currentstate=3'b000;
 
 parameter I=3'b000, UP=3'b001, DOWN=3'b010, LEFT=3'b011, RIGHT=3'b100;
 
 always@(*)
 case (currentstate)
   I:
	 if(!KEY[3]) nextstate=UP; 
    else if(!KEY[2]) nextstate=DOWN;
	 else if(!KEY[1]) nextstate=LEFT;
    else if(!KEY[0]) nextstate=RIGHT;
	 
   UP:
	 if(countx1<8'b10011111||county1<7'b1110111||countx2<3'b001||county2<3'b001) nextstate=UP;//159 119 2 2 
	 else if(!KEY[3]) nextstate=UP; 
    else if(!KEY[2]) nextstate=DOWN;
	 else if(!KEY[1]) nextstate=LEFT;
    else if(!KEY[0]) nextstate=RIGHT;
	 
   DOWN:
	if(countx1<8'b10011111||county1<7'b1110111||countx2<3'b001||county2<3'b001) nextstate=DOWN;//如果用等于，最后面counter部分，会直接设成把所有的countx设成0，会一直停在同一个state
	else if(!KEY[3]) nextstate=UP;                                                             //明天去问下TA
    else if(!KEY[2]) nextstate=DOWN;
	 else if(!KEY[1]) nextstate=LEFT;
    else if(!KEY[0]) nextstate=RIGHT;
	 
   LEFT:
	 if(countx1<8'b10011111||county1<7'b1110111||countx2<3'b001||county2<3'b001) nextstate=LEFT;
	 else if(!KEY[3]) nextstate=UP; 
    else if(!KEY[2]) nextstate=DOWN;
	 else if(!KEY[1]) nextstate=LEFT;
    else if(!KEY[0]) nextstate=RIGHT;
	 
   RIGHT:
	 if(countx1<8'b10011111||county1<7'b1110111||countx2<3'b001||county2<3'b001) nextstate=RIGHT;
	 else if(!KEY[3]) nextstate=UP; 
    else if(!KEY[2]) nextstate=DOWN;
	 else if(!KEY[1]) nextstate=LEFT;
    else if(!KEY[0]) nextstate=RIGHT;
  endcase
//////////////////////////////////////////////////////////////////////////////////define output

 always@(posedge CLOCK_50)
 case(currentstate)
 
 UP:begin//clear all pixels
 if(countx1<8'b10011111||county1<7'b1110111)//159 120
 begin
   xx<=countx1;
   yy<=county1;
   color<=3'b000;
	writeEn<=1;
	end
	
	
	
else if(county1==7'b1110111)

if(yy>0)
begin//draw the 2*2 square
xx<=xx;//有问题，这两行code只能执行一次，
yy<=yy-1;//可是放在这里，在画方块的时候每次都会多往上移动一个位置
   xx<=xx+countx2;
   yy<=yy+county2;
color<=inputcolor;
writeEn<=1;
  end
  
  end
  
 DOWN:begin
 
  if(countx1<8'b10011111||county1<7'b1110111)
  begin
   xx<=countx1;
   yy<=county1;
   color<=3'b000;
	writeEn<=1;
	end
	
else if(yy<7'b1110111)
begin
xx<=xx;
yy<=yy+1;
   xx<=xx+countx2;
   yy<=yy+county2;
color<=inputcolor;
writeEn<=1;
  end
  
  end
  
 LEFT:begin
 
  if(countx1<8'b10011111||county1<7'b1110111)
  begin
   xx<=countx1;
   yy<=county1;
   color<=3'b000;
	writeEn<=1;
	end
	
else if(xx>0)
begin
xx<=xx-1;
yy<=yy;
   xx<=xx+countx2;
   yy<=yy+county2;
color<=inputcolor;
writeEn<=1;
  end
  
  end
  
 RIGHT:begin
 
  if(countx1<8'b10011111||county1<7'b1110111)
  begin
   xx<=countx1;
   yy<=county1;
   color<=3'b000;
	writeEn<=1;
	end
	
else if(xx<8'b10011111)
begin
xx<=xx+1;
yy<=yy;
   xx<=xx+countx2;
   yy<=yy+county2;
color<=inputcolor;
writeEn<=1;
  end
  end
 endcase
 ////////////////////////////////////////////////////////////////////////////Counterx1
 
 always@(posedge CLOCK_50)
 begin
 
  currentstate<=nextstate;
  if(currentstate==UP||currentstate==DOWN||currentstate==LEFT||currentstate==RIGHT)
  begin
  
 if(countx1==8'b10011111&&county1==7'b1110111&&countx2==3'b001&&county2==3'b001)
 begin
 countx1<=0;
 county1<=0;
 countx2<=0;
 county2<=0;
 end
 
    if(countx1<8'b10011111) countx1<=countx1+1;
	 else if(county1<7'b1110111)
	 begin
	 countx1<=0;
	 county1<=county1+1;
	 end
	 
	 end
	 
	 if(countx2<3'b001) countx2<=countx2+1;
	 else if(county2<3'b001) 
	 begin
	 countx2<=0;
	 county2<=county2+1;
	 end
	 
	end
 ///////////////////////////////////////////////////////////////////////////////
 
 //assign the states to the LEDRs for examination
 assign LEDR=nextstate;
 
 // Create an Instance of a VGA controller - there can be only one!
 // Define the number of colours as well as the initial background
 // image file (.MIF) for the controller.
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
  defparam VGA.BACKGROUND_IMAGE = "display.mif";
  
   
 // Put your code here. Your code should produce signals x,y,color and writeEn
 // for the VGA controller, in addition to any other functionality your design may require.
 endmodule
 
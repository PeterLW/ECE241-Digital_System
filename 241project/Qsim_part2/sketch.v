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
 
 //wire [7:0] x;
 //wire [6:0] y;
 reg writeEn;
 //assign x=SW[7:0];
 //assign y=SW[14:8];
 reg[7:0]xx;
 reg[6:0]yy;
 reg[7:0] realx;
 reg[7:0] realy;
   ///////////////////////////////////////////////////////////////////////////FSM
 reg [1:0]countx;
 reg [1:0]county;
 reg [1:0]countx2;
 reg [1:0]county2;
 reg [2:0]currentstate;
 reg [2:0]nextstate;
 assign resetn=SW[0];
 //wire[2:0]inputcolor;
 //assign inputcolor=SW[17:15];
 reg [2:0]color;
 wire up;
 wire down;
 wire left;
 wire rigth;
 assign up = !KEY[3];
 assign down=!KEY[2]; 
 assign left=!KEY[1];
 assign right=!KEY[0];
 reg select;
 //wire done;
 //wire ups,downs,lefts,rights;
 //wire [7:0]tempx;
 //wire [6:0]tempy;
 initial currentstate=3'b000;
 
 parameter idle=3'b000, erasex=3'b001, erasey=3'b010, move=3'b011, drawx=3'b100,drawy=3'b101;
 
 always@(posedge CLOCK_50)begin
 case(currentstate)
 
 idle:
 begin
 
 xx<=realx;
 yy<=realy;
 if(up) begin
 select=up;
 nextstate=erasex;
 end
 
 if(down) begin
 select=down;
 nextstate=erasex;
 end
 
 if(left) begin 
 select=left;
 nextstate=erasex;
 end
 
 if(right) begin
 select=right;
 nextstate=erasex;
 end
 
 end
 
 erasex:
 begin
 if(countx<2'b10) begin
 xx<=xx+countx;
 //yy<=yy+county;
 color<=3'b000;
 writeEn<=1;
 countx<=countx+1;
 nextstate=erasex;
 end
 if(countx==2'b10)begin
 countx<=0;
 nextstate=erasey;
 end
 end
 
 erasey:
 begin
 county<=county+1;
 if(county<2'b10) 
 begin
 yy<=county;
 nextstate=erasex;
 end
 if(county==2'b10) begin
 countx<=0;
 county<=0;
 nextstate=move;
 end
 end
 
 move:
 begin
 if(select==up&&realy>0) realy<=realy-1;
 if(select==down&&realy<7'b1110111) realy<=realy+1;
 if(select==left&&realx>0) realx<=realx-1;
 if(select==right&&realx<8'b10011111) realx<=realx+1;
 xx<=realx;
 yy<=realy;
 nextstate=drawx;
 end
 
 drawx:
 begin
 if(countx2<2'b10) 
 begin
 xx<=xx+countx2;
 yy<=county2;
 color<=3'b111;
 writeEn<=1;
 countx2<=countx2+1;
 nextstate=drawx;
 end
 if(countx2==2'b10) begin
 countx2<=0;
 nextstate=drawy;
 end
 end
 
 drawy: begin
 county2<=county2+1;
 if(county2<2'b10) begin
 yy<=county2;
 nextstate=drawx;
 end
 if(county2==2'b10) begin
 countx2<=0;
 county2<=0;
 nextstate=idle;
 end
end
 
 endcase
 end

 /*always@(posedge CLOCK_50)
 begin
  currentstate<=nextstate;
  
  if(currentstate==erasex)begin
  if(countx<2'b10)countx<=countx+1;
  else countx<=0;
  end
  
  if(currentstate==drawx)begin
  if(countx2<2'b10)countx2<=countx2+1;
  else countx2<=0;
  end
  
  if(currentstate==erasey)begin
  if(county<2'b10)county<=county+1;
  else county<=0;
  end
  
  if(currentstate==drawy)begin
  if(county<2'b10)county2<=county2+1;
  else county2<=0;
  end
end*/
 ///////////////////////////////////////////////////////////////////////////////
 
 //assign the states to the LEDRs for examination

 
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
 
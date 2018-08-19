module snake_vga_control
	(
	 CLK, RSTn, x_sig, y_sig, Ready_Sig, x0, y0, x1, y1,
	 x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8,
	 x9, y9, x10, y10, x11, y11, x12, y12, x13, y13, x14, y14, x15, y15,
	 Red_Sig, Green_Sig, Blue_Sig
	);
	input RSTn;
	inout CLK;
	input Ready_Sig;
	input [10:0]x0;
	input [10:0]y0;		
	input [10:0]x1;
	input [10:0]y1;
	input [10:0]x2;
	input [10:0]y2;
	input [10:0]x3;
	input [10:0]y3;
	input [10:0]x4;
	input [10:0]y4;	
	input [10:0]x5;
	input [10:0]y5;	
	input [10:0]x6;
	input [10:0]y6;	
	input [10:0]x7;
	input [10:0]y7;	
	input [10:0]x8;
	input [10:0]y8;	
	input [10:0]x9;
	input [10:0]y9;	
	input [10:0]x10;
	input [10:0]y10;	
	input [10:0]x11;
	input [10:0]y11;	
	input [10:0]x12;
	input [10:0]y12;	
	input [10:0]x13;
	input [10:0]y13;	
	input [10:0]x14;
	input [10:0]y14;
	input [10:0]x15;
	input [10:0]y15;						
	input [10:0]x_sig;
	input [10:0]y_sig;
	output Red_Sig;
	output Green_Sig;
	output Blue_Sig;
	
	 /**********************************/ 
     reg isready;
     reg move_ready0;
     reg move_ready1;
     reg move_ready2;
     reg move_ready3;
     reg move_ready4;
     reg move_ready5;
     reg move_ready6;
     reg move_ready7;
     reg move_ready8;
     reg move_ready9;
     reg move_ready10;
     reg move_ready11;
     reg move_ready12;
     reg move_ready13;
     reg move_ready14;
     reg move_ready15;     
          	      
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          isready <= 1'b0;
		  else if(((x_sig>11'd10&&x_sig<11'd20)&&(y_sig>11'd10&&y_sig<11'd310))||((x_sig>11'd290&&x_sig<11'd300)&&(y_sig>11'd10&&y_sig<11'd310))||((x_sig>11'd10&&x_sig<11'd300)&&(y_sig>11'd10&&y_sig<11'd20))||((x_sig>11'd10&&x_sig<11'd300)&&(y_sig>11'd300&&y_sig<11'd310)))
		  isready <= 1'b1;	
		  else 
		  isready <= 1'b0;	
		  
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready0 <= 1'b0;	 	
          else if((x_sig>x0&&x_sig<x0+11'd6)&&(y_sig>y0&&y_sig<y0+11'd6))
          move_ready0 <= 1'b1;
          else
          move_ready0 <= 1'b0;
          
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready1 <= 1'b0;	 	
          else if((x_sig>x1&&x_sig<x1+11'd6)&&(y_sig>y1&&y_sig<y1+11'd6))
          move_ready1 <= 1'b1;
          else
          move_ready1 <= 1'b0;  
      
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready2 <= 1'b0;	 	
          else if((x_sig>x2&&x_sig<x2+11'd6)&&(y_sig>y2&&y_sig<y2+11'd6))
          move_ready2 <= 1'b1;
          else
          move_ready2 <= 1'b0;    
                  
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready3 <= 1'b0;	 	
          else if((x_sig>x3&&x_sig<x3+11'd6)&&(y_sig>y3&&y_sig<y3+11'd6))
          move_ready3 <= 1'b1;
          else
          move_ready3 <= 1'b0;  	
          
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready4 <= 1'b0;	 	
          else if((x_sig>x4&&x_sig<x4+11'd6)&&(y_sig>y4&&y_sig<y4+11'd6))
          move_ready4 <= 1'b1;
          else
          move_ready4 <= 1'b0;
          
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready5 <= 1'b0;	 	
          else if((x_sig>x5&&x_sig<x5+11'd6)&&(y_sig>y5&&y_sig<y5+11'd6))
          move_ready5 <= 1'b1;
          else
          move_ready5 <= 1'b0; 
     
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready6 <= 1'b0;	 	
          else if((x_sig>x6&&x_sig<x6+11'd6)&&(y_sig>y6&&y_sig<y6+11'd6))
          move_ready6 <= 1'b1;
          else
          move_ready6 <= 1'b0;
         
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready7 <= 1'b0;	 	
          else if((x_sig>x7&&x_sig<x7+11'd6)&&(y_sig>y7&&y_sig<y7+11'd6))
          move_ready7 <= 1'b1;
          else
          move_ready7 <= 1'b0;
        
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready8 <= 1'b0;	 	
          else if((x_sig>x8&&x_sig<x8+11'd6)&&(y_sig>y8&&y_sig<y8+11'd6))
          move_ready8 <= 1'b1;
          else
          move_ready8 <= 1'b0;  
          
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready9 <= 1'b0;	 	
          else if((x_sig>x9&&x_sig<x9+11'd6)&&(y_sig>y9&&y_sig<y9+11'd6))
          move_ready9 <= 1'b1;
          else
          move_ready9 <= 1'b0;    
                  
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready10 <= 1'b0;	 	
          else if((x_sig>x10&&x_sig<x10+11'd6)&&(y_sig>y10&&y_sig<y10+11'd6))
          move_ready10 <= 1'b1;
          else
          move_ready10 <= 1'b0;  	
          
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready11 <= 1'b0;	 	
          else if((x_sig>x11&&x_sig<x11+11'd6)&&(y_sig>y11&&y_sig<y11+11'd6))
          move_ready11 <= 1'b1;
          else
          move_ready11 <= 1'b0;
          
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready12 <= 1'b0;	 	
          else if((x_sig>x12&&x_sig<x12+11'd6)&&(y_sig>y12&&y_sig<y12+11'd6))
          move_ready12 <= 1'b1;
          else
          move_ready12 <= 1'b0; 
     
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready13 <= 1'b0;	 	
          else if((x_sig>x13&&x_sig<x13+11'd6)&&(y_sig>y13&&y_sig<y13+11'd6))
          move_ready13 <= 1'b1;
          else
          move_ready13 <= 1'b0;
         
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready14 <= 1'b0;	 	
          else if((x_sig>x14&&x_sig<x14+11'd6)&&(y_sig>y14&&y_sig<y14+11'd6))
          move_ready14 <= 1'b1;
          else
          move_ready14 <= 1'b0;
        
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
          move_ready15 <= 1'b0;	 	
          else if((x_sig>x15&x_sig<x15+11'd6)&&(y_sig>y15&&y_sig<y15+11'd6))
          move_ready15 <= 1'b1;
          else
          move_ready15 <= 1'b0;                                            	            	          	      	
	/************************************/
		
	 assign Red_Sig = (((Ready_Sig)&&(isready))||((Ready_Sig)&&(move_ready1))||((Ready_Sig)&&(move_ready2))||((Ready_Sig)&&(move_ready3))||((Ready_Sig)&&(move_ready4))||
	 ((Ready_Sig)&&(move_ready5))||((Ready_Sig)&&(move_ready0))||((Ready_Sig)&&(move_ready6))||((Ready_Sig)&&(move_ready7))||((Ready_Sig)&&(move_ready8))||
	 ((Ready_Sig)&&(move_ready9))||((Ready_Sig)&&(move_ready10))||((Ready_Sig)&&(move_ready11))||((Ready_Sig)&&(move_ready12))||((Ready_Sig)&&(move_ready13))||
	 ((Ready_Sig)&&(move_ready14))||((Ready_Sig)&&(move_ready15))) ? 1'b1 : 1'b0;
	 assign Green_Sig = 1'b0;
	 assign Blue_Sig = 1'b0;
	 
	/***********************************/
	 

endmodule
	
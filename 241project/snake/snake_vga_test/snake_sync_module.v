module snake_sync_module
(
     clk, rst_n,
	 VSYNC_Sig, HSYNC_Sig, Ready_Sig,
	 scan_x, scan_y
);

     input clk;
	 input rst_n;
	 output Ready_Sig;
	 output VSYNC_Sig;
	 output HSYNC_Sig;
	 output [10:0]scan_x;
	 output [10:0]scan_y;
	 
	 /********************************/
	 
	 reg [10:0]Count_H;

	 always @ ( posedge clk or negedge rst_n )
	     if( !rst_n )
			Count_H <= 11'd0;
		 else if( Count_H == 11'd1056 )
			Count_H <= 11'd0;
		 else 
			Count_H <= Count_H + 1'b1;
    
	 /********************************/
	 
	 reg [10:0]Count_V;
		 
	 always @ ( posedge clk or negedge rst_n )
	     if( !rst_n )
		    Count_V <= 11'd0;
	     else if( Count_V == 11'd628 )
		    Count_V <= 11'd0;
	     else if( Count_H == 11'd1056 )
		    Count_V <= Count_V + 1'b1;
	
	 /********************************/
	 
	 reg isReady;
	 
	 always @ ( posedge clk or negedge rst_n )
	     if( !rst_n )
		    isReady <= 1'b0;
         else if( ( Count_H >= 11'd216 && Count_H < 11'd1017 ) && 
			        ( Count_V >= 11'd27 && Count_V < 11'd627 ) )
		    isReady <= 1'b1;
		 else
		    isReady <= 1'b0;
		    
	 /*********************************/
	 
	 assign VSYNC_Sig = ( Count_V <= 11'd4 ) ? 1'b0 : 1'b1;
	 assign HSYNC_Sig = ( Count_H <= 11'd128 ) ? 1'b0 : 1'b1;
	 assign Ready_Sig = isReady;	 
	 assign scan_x = isReady ? (Count_H-11'd217) : 11'd0;
	 assign scan_y = isReady ? (Count_V-11'd28) : 11'd0;
endmodule

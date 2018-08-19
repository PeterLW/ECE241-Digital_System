module win_vga_control_module
(
     CLK, RSTn,win_sig,
	 Ready_Sig, Column_Addr_Sig, Row_Addr_Sig,
	 Red_Rom_Data,Rom_Addr,
	 Red_Sig, Green_Sig, Blue_Sig
);
     input CLK;
	 input RSTn;
	 input Ready_Sig;
	 input win_sig;
	 input [10:0]Column_Addr_Sig;
	 input [10:0]Row_Addr_Sig;
	 
	 input [255:0]Red_Rom_Data;
	 output [7:0]Rom_Addr;
	 
	 output Red_Sig;
	 output Green_Sig;
	 output Blue_Sig;
	 
	 
	 /**********************************/
	 
	 reg [7:0]m;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
				m <= 8'd0; 
		  else if( Ready_Sig && Row_Addr_Sig < 256 )
		      m <= Row_Addr_Sig[7:0];
		  else
		      m <= 7'd0;
	
    reg [7:0]n;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      n <= 8'd0;
		  else if( Ready_Sig && Column_Addr_Sig < 256 )
		      n <= Column_Addr_Sig[7:0];
		  else 
		      n <= 8'd0;
				
	/************************************/
	
     assign Rom_Addr = m;
	
	 assign Red_Sig = (win_sig&&Ready_Sig) ? Red_Rom_Data[8'd255-n] : 1'b0;
	 assign Green_Sig = 1'b0;
	 assign Blue_Sig = 1'b0;
	 
	/***********************************/
	 

endmodule

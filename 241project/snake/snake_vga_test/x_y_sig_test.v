module x_y_sig_test
	(
	x_sig,y_sig,clk,rst_n,VSYNC_Sig, HSYNC_Sig
	);
	
	input clk;
	input rst_n;
	input VSYNC_Sig;
	input HSYNC_Sig;
	output [10:0]x_sig;
	output [10:0]y_sig;
	
	reg [10:0]x_reg;
	reg [10:0]y_reg;
		
	always @ ( posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			x_reg<=11'd0;
		else if((x_reg == 11'd1000)||(!VSYNC_Sig))
			x_reg<=11'd0;
		else 
			x_reg<=x_reg+11'd1;
	end
	
	always @ ( posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			y_reg<=11'd0;
		else if((y_reg == 11'd1000)||(!HSYNC_Sig))
			y_reg<=11'd0;
		else 
			y_reg<=y_reg+11'd1;
	end			
	
	assign x_sig = x_reg;
	assign y_sig = y_reg;

endmodule	
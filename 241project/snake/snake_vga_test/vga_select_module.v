module vga_select_module 
	(
	input ready_VSYNC_Sig,
	input ready_HSYNC_Sig,
	input ready_VGA_red,
	input ready_VGA_green,
	input ready_VGA_blue,
	input win_VSYNC_Sig,
	input win_HSYNC_Sig,
	input win_VGA_red,
	input win_VGA_green,
	input win_VGA_blue,
	input over_VSYNC_Sig,
	input over_HSYNC_Sig,
	input over_VGA_red,
	input over_VGA_green,
	input over_VGA_blue,
	input s_VSYNC_Sig,
	input s_HSYNC_Sig,
	input s_VGA_red,
	input s_VGA_green,
	input s_VGA_blue,
	input ready_sig,
	input win_sig,
	input over_sig,
	input start,
	output VSYNC_Sig_out,
	output HSYNC_Sig_out,
	output VGA_red_out,
	output VGA_green_out,
	output VGA_blue_out
	);
	
	reg VSYNC_Sig;
	reg HSYNC_Sig;
	reg VGA_red;
	reg VGA_green;
	reg VGA_blue;	
	
	always @ (ready_sig or win_sig or over_sig or start)
		  begin
			case({ready_sig,win_sig,over_sig,start})
				4'b1000:
					begin
						VSYNC_Sig = ready_VSYNC_Sig; 
						HSYNC_Sig = ready_HSYNC_Sig;
						VGA_red = ready_VGA_red;
						VGA_green = ready_VGA_green;
						VGA_blue = ready_VGA_blue; 
					end
				4'b0100:
					begin
						VSYNC_Sig = win_VSYNC_Sig; 
						HSYNC_Sig = win_HSYNC_Sig;
						VGA_red = win_VGA_red;
						VGA_green = win_VGA_green;
						VGA_blue = win_VGA_blue; 						
					end				
				4'b0010:
					begin
						VSYNC_Sig = over_VSYNC_Sig; 
						HSYNC_Sig = over_HSYNC_Sig;
						VGA_red = over_VGA_red;
						VGA_green = over_VGA_green;
						VGA_blue = over_VGA_blue; 									
					end				
				4'b0001:
					begin
						VSYNC_Sig = s_VSYNC_Sig; 
						HSYNC_Sig = s_HSYNC_Sig;
						VGA_red = s_VGA_red;
						VGA_green = s_VGA_green;
						VGA_blue = s_VGA_blue; 									
					end			
				default:
					begin
						VSYNC_Sig = ready_VSYNC_Sig; 
						HSYNC_Sig = ready_HSYNC_Sig;
						VGA_red = ready_VGA_red;
						VGA_green = ready_VGA_green;
						VGA_blue = ready_VGA_blue; 						
					end
			endcase
		end
		
	assign	VSYNC_Sig_out = VSYNC_Sig; 
	assign  HSYNC_Sig_out = HSYNC_Sig;
	assign	VGA_red_out = VGA_red;
	assign	VGA_green_out = VGA_green;
	assign	VGA_blue_out = VGA_blue; 		

endmodule					
						
						
									

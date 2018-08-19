module snake_vga_test
	(
	clk,rst_n,Red_Sig,Green_Sig,Blue_Sig,
	up,down,left,right,enter,
	HSYNC_Sig,VSYNC_Sig,buzz
	);
	
	input clk;
	input rst_n;
	input up;
	input down;
	input left;
	input right;	
	input enter;
	output Red_Sig;
	output Green_Sig;
	output Blue_Sig;
	output HSYNC_Sig;
	output VSYNC_Sig;
	output buzz;
	
	wire CLK_40M;
	
	pll_module U0
	(
		.inclk0(clk),
		.c0(CLK_40M)
	);
	
	wire [10:0]scan_x;
	wire [10:0]scan_y;
	wire s_Ready_Sig;	
	wire [10:0]x0;
	wire [10:0]y0;
	wire [10:0]x1;
	wire [10:0]y1;	
	wire [10:0]x2;
	wire [10:0]y2;		
	wire [10:0]x3;
	wire [10:0]y3;
	wire [10:0]x4;
	wire [10:0]y4;
	wire [10:0]x5;
	wire [10:0]y5;
	wire [10:0]x6;
	wire [10:0]y6;
	wire [10:0]x7;
	wire [10:0]y7;
	wire [10:0]x8;
	wire [10:0]y8;
	wire [10:0]x9;
	wire [10:0]y9;		
	wire [10:0]x10;
	wire [10:0]y10;
	wire [10:0]x11;
	wire [10:0]y11;
	wire [10:0]x12;
	wire [10:0]y12;
	wire [10:0]x13;
	wire [10:0]y13;
	wire [10:0]x14;
	wire [10:0]y14;
	wire [10:0]x15;
	wire [10:0]y15;				
	wire s_Red_Sig;
	wire s_Green_Sig;
	wire s_Blue_Sig;
	wire s_VSYNC_Sig;
	wire s_HSYNC_Sig;
	
	snake_vga_control U1
	(
		.RSTn(rst_n),
		.CLK(CLK_40M),
		.Ready_Sig(s_Ready_Sig), 	
		.x0(x0),
		.y0(y0),
		.x1(x1),
		.y1(y1),
		.x2(x2),
		.y2(y2),
		.x3(x3),
		.y3(y3),
		.x4(x4),
		.y4(y4),
		.x5(x5),
		.y5(y5),
		.x6(x6),
		.y6(y6),
		.x7(x7),
		.y7(y7),
		.x8(x8),
		.y8(y8),	
		.x9(x9),
		.y9(y9),
		.x11(x11),
		.y11(y11),
		.x12(x12),
		.y12(y12),
		.x13(x13),
		.y13(y13),
		.x14(x14),
		.y14(y14),
		.x10(x10),
		.y10(y10),
		.x15(x15),
		.y15(y15),							
		.x_sig(scan_x), 
		.y_sig(scan_y),
		.Red_Sig(s_Red_Sig), 
		.Green_Sig(s_Green_Sig), 
		.Blue_Sig(s_Blue_Sig)
	);
	
	snake_sync_module U2
	(
		.clk(CLK_40M), 
		.rst_n(rst_n), 
		.scan_x(scan_x),
		.scan_y(scan_y),
		.Ready_Sig(s_Ready_Sig),
		.VSYNC_Sig(s_VSYNC_Sig), 
		.HSYNC_Sig(s_HSYNC_Sig)
	);
	
	wire start;
	wire win;
	wire over;
	wire ready_sig;
	wire win_sig;
	wire over_sig;
	
	moving_snake U3
	(
		.clk(CLK_40M),
		.rst_n(rst_n),
		.up(up),
		.down(down),
		.left(left),
		.right(right),
		.start(start),
		.o_win(win),
		.o_over(over),
		.x0(x0),
		.y0(y0),
		.x1(x1),
		.y1(y1),
		.x2(x2),
		.y2(y2),
		.x3(x3),
		.y3(y3),
		.x4(x4),
		.y4(y4),
		.x5(x5),
		.y5(y5),
		.x6(x6),
		.y6(y6),
		.x7(x7),
		.y7(y7),
		.x8(x8),
		.y8(y8),
		.x9(x9),
		.y9(y9),
		.x11(x11),
		.y11(y11),
		.x12(x12),
		.y12(y12),
		.x13(x13),
		.y13(y13),
		.x14(x14),
		.y14(y14),
		.x10(x10),
		.y10(y10),
		.x15(x15),
		.y15(y15)				
	);
	
	snake_game_process U4
	(
		.clk(CLK_40M),
		.rst_n(rst_n),
		.enter(enter),
		.over(over),
		.win(win),
	    .ready_sig(ready_sig),
	    .win_sig(win_sig),
	    .over_sig(over_sig),
	    .start(start)
	);
	
	wire Ready_Sig_r;
	wire [10:0]Column_Addr_Sig_r;
	wire [10:0]Row_Addr_Sig_r;
	wire r_VSYNC_Sig;
	wire r_HSYNC_Sig;
	wire r_Red_Sig;
	wire r_Green_Sig;
	wire r_Blue_Sig;
	
	ready_sync_module U5
	(
		.CLK(CLK_40M), 
		.RSTn(rst_n),
		.VSYNC_Sig(r_VSYNC_Sig), 
		.HSYNC_Sig(r_HSYNC_Sig), 
		.Ready_Sig(Ready_Sig_r),
		.Column_Addr_Sig(Column_Addr_Sig_r), 
		.Row_Addr_Sig(Row_Addr_Sig_r)
	); 
	
	wire [255:0]Red_Rom_Data_r;
	wire [7:0]Rom_Addr_r;
	
	ready_vga_control_module U6
	(
		.CLK(CLK_40M),
		.RSTn(rst_n),
		.ready_sig(ready_sig),
		.Ready_Sig(Ready_Sig_r), 
		.Column_Addr_Sig(Column_Addr_Sig_r), 
		.Row_Addr_Sig(Row_Addr_Sig_r),
		.Red_Rom_Data(Red_Rom_Data_r),
		.Rom_Addr(Rom_Addr_r),
		.Red_Sig(r_Red_Sig), 
		.Green_Sig(r_Green_Sig), 
		.Blue_Sig(r_Blue_Sig)	
	);
	
	ready_rom U7
	(
		.address(Rom_Addr_r),
		.clock(CLK_40M),
		.q(Red_Rom_Data_r)
	); 
	
	wire Ready_Sig_w;
	wire [10:0]Column_Addr_Sig_w;
	wire [10:0]Row_Addr_Sig_w;
	wire w_VSYNC_Sig;
	wire w_HSYNC_Sig;
	
	win_sync_module U8
	(
	    .CLK(CLK_40M), 
	    .RSTn(rst_n),
		.VSYNC_Sig(w_VSYNC_Sig), 
		.HSYNC_Sig(w_HSYNC_Sig), 
		.Ready_Sig(Ready_Sig_w),
		.Column_Addr_Sig(Column_Addr_Sig_w), 
		.Row_Addr_Sig(Row_Addr_Sig_w)
	); 
	
	wire [255:0]Red_Rom_Data_w;
	wire [7:0]Rom_Addr_w;
	wire w_Red_Sig;
	wire w_Green_Sig;
	wire w_Blue_Sig;
	
	win_vga_control_module U9
	(
		.CLK(CLK_40M), 
		.RSTn(rst_n),
		.win_sig(win_sig),
		.Ready_Sig(Ready_Sig_w), 
		.Column_Addr_Sig(Column_Addr_Sig_w), 
		.Row_Addr_Sig(Row_Addr_Sig_w),
		.Red_Rom_Data(Red_Rom_Data_w),
		.Rom_Addr(Rom_Addr_w),
		.Red_Sig(w_Red_Sig), 
		.Green_Sig(w_Green_Sig), 
		.Blue_Sig(w_Blue_Sig)
	); 
	
	win_rom U10
	(
		.address(Rom_Addr_w),
		.clock(CLK_40M),
		.q(Red_Rom_Data_w)	
	);

	wire Ready_Sig_o;
	wire [10:0]Column_Addr_Sig_o;
	wire [10:0]Row_Addr_Sig_o;
	wire o_VSYNC_Sig;
	wire o_HSYNC_Sig;
		
	over_sync_module U11
	(
	    .CLK(CLK_40M), 
	    .RSTn(rst_n),
		.VSYNC_Sig(o_VSYNC_Sig), 
		.HSYNC_Sig(o_HSYNC_Sig), 
		.Ready_Sig(Ready_Sig_o),
		.Column_Addr_Sig(Column_Addr_Sig_o), 
		.Row_Addr_Sig(Row_Addr_Sig_o)	
	); 

	wire [255:0]Red_Rom_Data_o;
	wire [6:0]Rom_Addr_o;
	wire o_Red_Sig;
	wire o_Green_Sig;
	wire o_Blue_Sig;
		
	over_vga_control_module U12
	(
		.CLK(CLK_40M), 
		.RSTn(rst_n),
		.over_sig(over_sig),
		.Ready_Sig(Ready_Sig_o), 
		.Column_Addr_Sig(Column_Addr_Sig_o), 
		.Row_Addr_Sig(Row_Addr_Sig_o),
		.Red_Rom_Data(Red_Rom_Data_o),
		.Rom_Addr(Rom_Addr_o),
		.Red_Sig(o_Red_Sig), 
		.Green_Sig(o_Green_Sig), 
		.Blue_Sig(o_Blue_Sig)	
	);
	
	over_rom U13
	(
		.address(Rom_Addr_o),
		.clock(CLK_40M),
		.q(Red_Rom_Data_o)		
	);  
	
	
	vga_select_module U14
	(
		.win_VSYNC_Sig( w_VSYNC_Sig ),
	    .win_HSYNC_Sig( w_HSYNC_Sig ),
	    .win_VGA_red( w_Red_Sig ),
	    .win_VGA_green( w_Green_Sig ),
	    .win_VGA_blue( w_Blue_Sig ),
	    .over_VSYNC_Sig( o_VSYNC_Sig ),
	    .over_HSYNC_Sig( o_HSYNC_Sig ),
	    .over_VGA_red( o_Red_Sig ),
	    .over_VGA_green( o_Green_Sig ),
	    .over_VGA_blue( o_Blue_Sig ),
	    .ready_VSYNC_Sig( r_VSYNC_Sig ),
	    .ready_HSYNC_Sig( r_HSYNC_Sig ),
	    .ready_VGA_red( r_Red_Sig ),
	    .ready_VGA_green( r_Green_Sig ),
		.ready_VGA_blue( r_Blue_Sig ),
		.s_VSYNC_Sig( s_VSYNC_Sig ),
		.s_HSYNC_Sig( s_HSYNC_Sig ),
		.s_VGA_red( s_Red_Sig ),
		.s_VGA_green( s_Green_Sig ),
		.s_VGA_blue( s_Blue_Sig ),
		.ready_sig( ready_sig ),
		.win_sig( win_sig ),
		.over_sig( over_sig ),
		.start( start ),
		.VSYNC_Sig_out( VSYNC_Sig ),
		.HSYNC_Sig_out( HSYNC_Sig ),
		.VGA_red_out( Red_Sig ),
		.VGA_green_out( Green_Sig ),
		.VGA_blue_out( Blue_Sig )
	); 
	 assign buzz = 1'b1;
	 
endmodule	 
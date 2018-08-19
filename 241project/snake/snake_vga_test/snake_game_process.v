module snake_game_process
	(clk,rst_n,enter,over,win,
	ready_sig,win_sig,over_sig,start
	);
	input clk;
	input rst_n;
	input enter;
	input over;
	input win;
	output start;
	output ready_sig;
	output win_sig;
	output over_sig;

	parameter ready = 4'b0001,game = 4'b0010,game_over = 4'b0100,wining = 4'b1000;
	reg [3:0] game_current_process,game_next_process;
	reg ready_sig;
	reg win_sig;
	reg over_sig;
	reg start;
	
	always @(posedge clk or negedge rst_n)
	begin	
		if(!rst_n)
			game_current_process <= ready;
		else
			game_current_process <= game_next_process;
	end
	
	always @(game_current_process or over or enter or win)
	begin
		case(game_current_process)
			ready:
			begin
				ready_out;
				if(!enter)
					game_next_process = game;
				else
					game_next_process = ready;
			end
			game:
			begin
				game_out;
				if(over)
					game_next_process = game_over;
				else if(win)
					game_next_process = wining;
				else
					game_next_process = game;
			end
			wining:
			begin
				win_out;
				if(!enter)
				game_next_process = ready;
				else
				game_next_process = wining;
			end
			game_over:
			begin
				over_out;
				if(!enter)
				game_next_process = ready;
				else
				game_next_process = game_over;
			end
			default:
			begin
				ready_out;
				game_next_process = ready;
			end	
		endcase
	end
	
	task ready_out;
    {ready_sig,start,win_sig,over_sig} = 4'b1000;
    endtask   
    
	task game_out;
    {ready_sig,start,win_sig,over_sig} = 4'b0100;
	endtask
	
	task win_out;
    {ready_sig,start,win_sig,over_sig} = 4'b0010;
	endtask
	
	task over_out;
    {ready_sig,start,win_sig,over_sig} = 4'b0001;
	endtask
	
endmodule
	
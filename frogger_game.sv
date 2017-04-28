module	frogger_game ( input [9:0] BallX, BallY, 
												DrawX, DrawY, 
												BallS,
								input logic [0:15][0:16][0:5] frog_font,
								input logic [0:15][0:24][0:5] firetruck_font,
								input logic [0:13][0:18][0:5] bus_font,
								input logic [0:15][0:22][0:5] motorcycle_font,
								input logic [0:8][0:26][0:5] shortlog_font,
								input logic [0:8][0:49][0:5] mediumlog_font,
								input logic [0:8][0:72][0:5] longlog_font,	
								input Clk,
								output [0:5] colorcode
								);

// try to match the color code with the actual RGB values 
//color code match: 
//# 0 white  (fffff)
//# 1 black  (0000)
//# 2 green (27b212)
//# 3 red (d80222)
//# 4 light blue (5db1f0)
//# 5 yellow (F1FF0A)
//# 6 grey (b2b2b0)
//# 7 orange (f27a00)
//# 8 brown (663300)


// const varables used to draw 
parameter [9:0] frog_width=17;  
parameter [9:0] frog_height=16;  

parameter [9:0] firetruck_width=25;  
parameter [9:0] firetruck_height=16;  

parameter [9:0] bus_width=19;  
parameter [9:0] bus_height=14;  

parameter [9:0] motorcycle_width=16;  
parameter [9:0] motorcycle_height=23;  

parameter [9:0] log_height=9; 
parameter [9:0] shortlog_width=27;  
parameter [9:0] mediumlog_width=50;  
parameter [9:0] longlog_width=73;  

// draw things based on different conditions 
always_comb
	begin
				
		if( DrawX >= BallX &&  DrawX < BallX + frog_width  && DrawY >= BallY && DrawY < BallY + frog_height )	
				begin 
					colorcode = frog_font[DrawY-BallY][DrawX-BallX]	;	
				end
		else 	
				begin 
					colorcode = 6'b000110 ; 
				end 
	end 

	
	
endmodule

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
//# 9 purple (8600b3)
//# 10 dark_blue (000066)

// ********** group 1 - const variables  *********** 
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


// ************ group 2 - varibles that will change values based on clock cycles ******* 
int time_width = 200 ;



// ********** now we begain to draw different things  *********** 
// draw things based on different conditions 
always_comb
	begin
				
		//*********** #1 draw the frog  ****************** 
		if( DrawX >= BallX &&  DrawX < BallX + frog_width  && DrawY >= BallY && DrawY < BallY + frog_height )	
				begin 
					colorcode = frog_font[DrawY-BallY][DrawX-BallX]	;	
				end
		
		//*********** #2 draw the two purple lines **************** 
		else if ( (( DrawY >= 240 ) && ( DrawY <= 269 )) ||  ( (DrawY >= 420) && (DrawY <=449))    ) 
				begin 	
				   colorcode = 6'b001001 ;							
				end 
		
		
	   //********** #3 draw the green time bar ********************* 		
		 else if ( DrawX >= 430 && DrawX < 430 + time_width && DrawY >= 460 && DrawY < 475 ) 
				begin 	
					 colorcode = 6'b000010 ;			
				end 
		
	
		 // draw the white marks lines on the road 
		 /*
		 else if ( (( DrawX >= 0 ) && ( DrawX <= 64 )) ||  ( (DrawX >= 128) && (DrawX <=192)) || ( (DrawX >= 256) && (DrawX <=320))  ||  ( (DrawX >= 384) && (DrawX <=448))  ||  ( (DrawX >= 512) && (DrawX <=576))	) 	 
				 if ((( DrawY >= 306 ) && ( DrawY <= 308 )) || (( DrawY >= 346 ) && ( DrawY <= 348 )) || (( DrawY >= 388 ) && ( DrawY <= 390 ))   )
					begin 
						// draw the white line 
						ball_on = 1'b0;
						purple_line_on = 1'b0;
						grass_on = 1'b0 ;
						water_on = 1'b0 ;
						font_on = 1'b0;
						sprite_addr = 10'b0; 
						line_on = 1'b1 ; 
						time_bar_on = 1'b0;	
					end 
				 else if (DrawX >= 240) 	
					begin 	
						// background color 
						ball_on = 1'b0;
						purple_line_on = 1'b0;
						grass_on = 1'b0 ;
						water_on = 1'b0 ;
						font_on = 1'b0;
						sprite_addr = 10'b0 ;
						line_on = 1'b0 ;
					   time_bar_on = 1'b0;		
					end 
				 else 	
						// water color 
					begin 
						ball_on = 1'b0;
						purple_line_on = 1'b0;
						grass_on = 1'b0 ; 
						water_on = 1'b1 ;
						font_on = 1'b0;
						sprite_addr = 10'b0 ; 
						line_on = 1'b0 ;	
						time_bar_on = 1'b0;	
					end 
			*/
		
		  //********** #4 draw the top part green grass  ********************* 	
		 else if ( (( DrawY >= 50 ) && ( DrawY <= 100 )) )	
				if (DrawY >= 60)
						// water 
						if ( (( DrawX >= 50 ) && ( DrawX <= 110 )) ||  ( (DrawX >= 170) && (DrawX <=230)) || ( (DrawX >= 290) && (DrawX <=350))  ||  ( (DrawX >= 410) && (DrawX <=470))  ||  ( (DrawX >= 530) && (DrawX <=590))	) 
							begin 
								colorcode = 6'b000110 ;
							end 
						// grass 
						else 
							begin 
								colorcode = 6'b000010 ;
							end 
				// grass 				
				else 
					begin 
						colorcode = 6'b000010;
					end 
		   
		 //********** #5 draw water on the top part of screen  ********************* 	
		  else if ( (( DrawY >= 0 ) && ( DrawY < 240 )) )
				begin 
					colorcode = 6'b000110 ;
				end 
		
		//********** default grey background *************************
		else 	
				begin 
					colorcode = 6'b000110 ; 
				end 
	end 

	
	
endmodule

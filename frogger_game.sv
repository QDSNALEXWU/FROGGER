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
								input logic [0:15][0:15][0:5] Oneshell_font,
                   		input logic [0:15][0:32][0:5] Twoshell_font,
                   		input logic [0:15][0:49][0:5] Threeshell_font, 
                   		input logic [0:12][0:26][0:5] gator_font,
                   		input logic [0:23][0:26][0:5] vader_font, 
								input logic [0:11][0:27][0:5] policecar_font,
								input logic [0:15][0:7][0:5] heart_font, 	
							   input logic [0:13][0:24][0:5] truck_font,   	
								input logic [0:17][0:22][0:5] skull_font, 
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
//# 11 white (ffff)
//# 12 light green (70f248)


//  the window is 640 wide , 480 height
// ********** group 1 - const variables  *********** 
// const varables used to draw 

// 258 - 420  road area  
parameter [9:0] frog_width=17;  
parameter [9:0] frog_height=16;  

parameter [9:0] firetruck_width=25;  
parameter [9:0] firetruck_height=16;  
int firetruckX = 440; 
int firetruckY = 270;   

parameter [9:0] bus_width=19;  
parameter [9:0] bus_height=14;  
int busX= 440; 
int busY = 300;     

parameter [9:0] motorcycle_width=23;  
parameter [9:0] motorcycle_height=16;  
int motorcycleX = 440; 
int motorcycleY = 330;    

parameter [9:0] policecar_width=28;  
parameter [9:0] policecar_height=12;  
int policecarX = 440; 
int policecarY = 360;   

parameter [9:0] truck_width=25;  
parameter [9:0] truck_height=14;  
int truckX = 440; 
int truckY = 390;   

parameter [9:0] heart_width=8;  
parameter [9:0] heart_height=16;  

int heartY = 455 ; 
int heart1X = 30 ; 
int heart2X = 45 ; 
int heart3X = 60 ; 

// 100 - 240  water area 
parameter [9:0] shortlog_height=9; 
parameter [9:0] shortlog_width=27;  

parameter [9:0] mediumlog_height=9; 
parameter [9:0] mediumlog_width=50;  
int mediumlogX = 440; 
int mediumlogY = 120;  

parameter [9:0] longlog_height=9; 
parameter [9:0] longlog_width=73;  
int longlogX = 440; 
int longlogY = 150;  

parameter [9:0] gator_height = 13;  
parameter [9:0] gator_width = 27; 
int gatorX = 440; 
int gatorY = 180;  

parameter [9:0] twoshell_width = 33;  
parameter [9:0] twoshell_height = 16; 
int twoshellX = 440; 
int twoshellY = 210;  

parameter [9:0] threeshell_width = 50;  
parameter [9:0] threeshell_height = 16; 
int threeshellX = 390; 
int threeshellY = 210;  

parameter [9:0] vader_width = 24;  
parameter [9:0] vader_height = 27; 


// ************ group 2 - varibles that will change values based on clock cycles ******* 
int time_width = 200 ;


always_ff @ (posedge Clk)
	begin
		time_width = time_width - 1 ;

	end 
// ********** now we begain to draw different things  *********** 
// draw things based on different conditions 
always_comb
	begin
		
		// decrease time 
		//time_width = time_width - 2 ; 
	   
		
		//*********** draw the frog  ****************** 
		if( DrawX >= BallX &&  DrawX < BallX + frog_width  && DrawY >= BallY && DrawY < BallY + frog_height && frog_font[DrawY-BallY][DrawX-BallX] != 6'b000000  )	
				begin 
					colorcode = frog_font[DrawY-BallY][DrawX-BallX]	;	
				end
		
	  //*********** draw the policecar  ****************** 
		else if( DrawX >= policecarX &&  DrawX < policecarX + policecar_width && DrawY >= policecarY && DrawY < policecarY + policecar_height && policecar_font[DrawY-policecarY][DrawX-policecarX] != 6'b000000 )	
				begin 
					colorcode = policecar_font[DrawY-policecarY][DrawX-policecarX];
				end	
		
		
		//*********** draw the firetruck  ****************** 
		else if( DrawX >= firetruckX &&  DrawX < firetruckX + firetruck_width && DrawY >= firetruckY && DrawY < firetruckY + firetruck_height && firetruck_font[DrawY-firetruckY][DrawX-firetruckX] != 6'b000000 )	
				begin 
					colorcode = firetruck_font[DrawY-firetruckY][DrawX-firetruckX]	;	
				end	
		
		//*********** draw the bus ****************** 
		else if( DrawX >= busX &&  DrawX < busX + bus_width && DrawY >= busY && DrawY < busY + bus_height  && bus_font[DrawY-busY][DrawX-busX] != 6'b000000  )	
				begin 
					colorcode = bus_font[DrawY-busY][DrawX-busX]	;	
				end	
		
		//*********** draw the truck ****************** 
		else if( DrawX >= truckX &&  DrawX < truckX + truck_width && DrawY >= truckY && DrawY < truckY + truck_height  && truck_font[DrawY-truckY][DrawX-truckX] != 6'b000000  )	
				begin 
					colorcode = truck_font[DrawY-truckY][DrawX-truckX];	
				end	
			
		//*********** draw the motorcycle ****************** 
		else if( DrawX >= motorcycleX &&  DrawX < motorcycleX + motorcycle_width && DrawY >= motorcycleY && DrawY < motorcycleY + motorcycle_height && motorcycle_font[DrawY-motorcycleY][DrawX-motorcycleX] != 6'b000000  )	
				begin 
					colorcode = motorcycle_font[DrawY-motorcycleY][DrawX-motorcycleX]	;	
				end	

			
	   else if( DrawX >= mediumlogX &&  DrawX < mediumlogX + mediumlog_width && DrawY >= mediumlogY && DrawY < mediumlogY + mediumlog_height && mediumlog_font[DrawY-mediumlogY][DrawX-mediumlogX] != 6'b000000 )	
			 begin 
					colorcode = mediumlog_font[DrawY-mediumlogY][DrawX-mediumlogX];
			 end	
									
		 else if( DrawX >= longlogX &&  DrawX < longlogX + longlog_width && DrawY >= longlogY && DrawY < longlogY + longlog_height && longlog_font[DrawY-longlogY][DrawX-longlogX] != 6'b000000 )	
			 begin 
					colorcode = longlog_font[DrawY-longlogY][DrawX-longlogX];
			 end	
									
	    else if( DrawX >= twoshellX &&  DrawX < twoshellX + twoshell_width && DrawY >= twoshellY && DrawY < twoshellY + twoshell_height && Twoshell_font[DrawY-twoshellY][DrawX-twoshellX] != 6'b000000 )	
			 begin 
					colorcode = Twoshell_font[DrawY-twoshellY][DrawX-twoshellX];
			 end	
														
		 else if( DrawX >= threeshellX &&  DrawX < threeshellX + threeshell_width && DrawY >= threeshellY && DrawY < threeshellY + threeshell_height && Threeshell_font[DrawY-threeshellY][DrawX-threeshellX] != 6'b000000 )	
			 begin 
					colorcode = Threeshell_font[DrawY-threeshellY][DrawX-threeshellX];
			 end	
								
		//*********** draw the two purple lines **************** 
		else if ( (( DrawY >= 240 ) && ( DrawY <= 258 )) ||  ( (DrawY >= 420) && (DrawY <=438))    ) 
				begin 	
				   colorcode = 6'b001001 ;							
				end 
		
	   //********** draw the green time bar ********************* 		
		 else if ( DrawX >= 430 && DrawX < 430 + time_width && DrawY >= 455 && DrawY < 470 ) 
				begin 	
					 colorcode = 6'b000010 ;			
				end 
	    
		 //********** draw hearts ********************* 		
		 else if ( DrawX >= heart1X && DrawX <  heart1X + heart_width && DrawY >= heartY && DrawY < heartY + heart_height && heart_font[DrawY-heartY][DrawX-heart1X] != 6'b000000  ) 
				begin 	
					 colorcode = 6'b000011  ;			
				end 
		 
		 else if ( DrawX >= heart2X && DrawX <  heart2X + heart_width && DrawY >= heartY && DrawY < heartY + heart_height && heart_font[DrawY-heartY][DrawX-heart2X] != 6'b000000 ) 
				begin 	
					 colorcode = 6'b000011  ;			
				end 
		
		 else if ( DrawX >= heart3X && DrawX <  heart2X + heart_width && DrawY >= heartY && DrawY < heartY + heart_height && heart_font[DrawY-heartY][DrawX-heart3X] != 6'b000000   ) 
				begin 	
					 colorcode = 6'b000011  ;			
				end 
	
		  //********** draw the top part green grass  ********************* 	
		 else if ( (( DrawY >= 50 ) && ( DrawY <= 100 )) )	
				if (DrawY >= 60)
						// water 
						if ( (( DrawX >= 50 ) && ( DrawX <= 110 )) ||  ( (DrawX >= 170) && (DrawX <=230)) || ( (DrawX >= 290) && (DrawX <=350))  ||  ( (DrawX >= 410) && (DrawX <=470))  ||  ( (DrawX >= 530) && (DrawX <=590))	) 
							begin 
								colorcode = 6'b001010 ;
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
		   
		 //********** draw water on the top part of screen  ********************* 	
		  else if ( (( DrawY >= 0 ) && ( DrawY < 240 )) )
				begin 
					colorcode = 6'b001010 ;
				end 
		
		//********** default grey background *************************
		else 	
				begin 
					colorcode = 6'b001101 ; 
				end 
	end 

	
	
endmodule

//********************************************************
//try to match the color code with the actual RGB values 
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
//# 13 dark grey (404040)
//# 14 light brown (ffa64d)
//**********************************************
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
								input logic [0:11][0:13][0:5] heart_font, 	
							   	input logic [0:13][0:24][0:5] truck_font,   	
								input logic [0:17][0:22][0:5] skull_font,
								input logic [0:13][0:13][0:5] S_font,  
    							input logic [0:13][0:13][0:5] C_font,  
    							input logic [0:13][0:13][0:5] O_font, 
    							input logic [0:13][0:13][0:5] R_font,  
    							input logic [0:13][0:13][0:5] E_font,  
    							input logic [0:13][0:13][0:5] T_font, 
    							input logic [0:13][0:13][0:5] I_font,
    							input logic [0:13][0:13][0:5] M_font,  
								input Clk,
								output [0:5] colorcode
								);

//  the window is 640 wide , 480 height
// ********** group 1 - const variables  *********** 
// const varables used to draw 

// 258 - 420  road area  
parameter [9:0] frog_width=17;  
parameter [9:0] frog_height=16;  


// ****************************** ROW1 ***************************************
/////////////////// firetruck - right to left /////////////////////////////////   
parameter [9:0] firetruck_width=25;  
parameter [9:0] firetruck_height=16;  
int firetruckY = 270; 
int firetruck1X = 440; 
int firetruck2X = 400; 
int firetruck3X = 360;   



// ****************************** ROW2 ***************************************
///////////////////// bus - left to right(flip) /////////////////////////////// 
parameter [9:0] bus_width=19;  
parameter [9:0] bus_height=14;  
int busY = 300; 
int busX= 440; 
    



// ****************************** ROW3 ***************************************
///////////////////// motorcycle - right to left /////////////////////////////// ROW3
parameter [9:0] motorcycle_width=23;  
parameter [9:0] motorcycle_height=16;  
int motorcycleY = 330; 
int motorcycle1X = 440; 
int motorcycle2X = 400; 
int motorcycle3X = 360;    




// ****************************** ROW4 ***************************************
/////////////////// policecar - left to right(flip) ////////////////////////////// ROW4
parameter [9:0] policecar_width=28;  
parameter [9:0] policecar_height=12;  
int policecarY = 360;  
int policecarX = 440; 
 




// ****************************** ROW5 ***************************************
////////////////////// truck - right to left ///////////////////////////////////// ROW5
parameter [9:0] truck_width=25;  
parameter [9:0] truck_height=14;  
int truckY = 390;   
int truck1X = 440; 
int truck2X = 400; 
int truck3X = 360; 

 
////////////////////// heart /////////////////////////////////////////////////////
parameter [9:0] heart_width=14;  
parameter [9:0] heart_height=12;  

int heartY = 455 ; 
int heart1X = 30 ; 
int heart2X = 50 ; 
int heart3X = 80 ; 


/////////////////// text font ////////////////////
// 430 
parameter [9:0] text_width=14;  
parameter [9:0] text_height=14;  

int TimeY = 455 ; 
int Time1x = 330 ; 
int Time2x = 350 ; 
int Time3x = 370 ; 
int Time4x = 390 ; 

int ScoreY = 30 ; 
int Score1x = 30 ; 
int Score2x = 60 ; 
int Score3x = 90 ; 
int Score4x = 120 ;
int Score5x = 150 ;



// *****************************************************************
// 100 - 240  water area 
parameter [9:0] shortlog_height=9; 
parameter [9:0] shortlog_width=27;  

parameter [9:0] mediumlog_height=9; 
parameter [9:0] mediumlog_width=50;  
 

parameter [9:0] longlog_height=9; 
parameter [9:0] longlog_width=73;  


parameter [9:0] gator_height = 13;  
parameter [9:0] gator_width = 27; 

parameter [9:0] twoshell_width = 33;  
parameter [9:0] twoshell_height = 16; 


parameter [9:0] threeshell_width = 50;  
parameter [9:0] threeshell_height = 16; 



// *********************  ROW 1 ********************************* // 
int threeshellX = 390; 
int threeshellY = 210; 




// *********************  ROW 2 ********************************* // 
int twoshellX = 440; 
int twoshellY = 210;  
int mediumlogX = 440; 
int mediumlogY = 120; 
int longlogX = 440; 
int longlogY = 150;  
int gatorX = 440; 
int gatorY = 180;   



// *********************  ROW 3 ********************************* // 











// *********************  score ********************************* //
// 3210
logic digit0 [0:13][0:13][0:5] ;
logic digit1 [0:13][0:13][0:5] ;
logic digit2 [0:13][0:13][0:5] ;
logic digit3 [0:13][0:13][0:5] ;

digitfont digit_instace1 ( .Clk, .digit(0), .font(digit0)); 
digitfont digit_instace1 ( .Clk, .digit(0), .font(digit1)); 
digitfont digit_instace1 ( .Clk, .digit(0), .font(digit2)); 
digitfont digit_instace1 ( .Clk, .digit(0), .font(digit3)); 

int DigitY = 30 ; 
int Digit1x = 180 ; 
int Digit2x = 210 ; 
int Digit3x = 240 ; 
int Digit4x = 270 ;





parameter [9:0] vader_width = 27;  
parameter [9:0] vader_height = 24; 
int vaderY = 30 ; 
int vader1x = 180 ; 
int vader2x = 210 ; 
int vader3x = 240 ; 
int vader4x = 270 ;
int vader5x = 270 ;



//#########################################################################################
// *****************************************************************************
// ****************************  collision detection ***************************
// ****************************************************************************	

/*always_ff@(posedge Clk)
begin



end*/


//#########################################################################################
// *****************************************************************************
// ****************************  draw things **********************************
// ****************************************************************************	
always_comb
	begin
		
		// decrease time 
   
		
		//*********** draw the frog  ****************** 
		if( DrawX >= BallX &&  DrawX < BallX + frog_width  && DrawY >= BallY && DrawY < BallY + frog_height && frog_font[DrawY-BallY][DrawX-BallX] != 6'b000000  )	
				begin 
					colorcode = frog_font[DrawY-BallY][DrawX-BallX]	;	
				end
		
	  	

		//*********** draw the firetruck  ****************** 
		else if( DrawX >= firetruck1X &&  DrawX < firetruck1X + firetruck_width && DrawY >= firetruckY && DrawY < firetruckY + firetruck_height && firetruck_font[DrawY-firetruckY][DrawX-firetruck1X] != 6'b000000 )	
				begin 
					colorcode = firetruck_font[DrawY-firetruckY][DrawX-firetruck1X]	;	
				end	
		
		
		else if( DrawX >= firetruck2X &&  DrawX < firetruck2X + firetruck_width && DrawY >= firetruckY && DrawY < firetruckY + firetruck_height && firetruck_font[DrawY-firetruckY][DrawX-firetruck2X] != 6'b000000 )	
				begin 
					colorcode = firetruck_font[DrawY-firetruckY][DrawX-firetruck2X]	;	
				end	
		

		else if( DrawX >= firetruck3X &&  DrawX < firetruck3X + firetruck_width && DrawY >= firetruckY && DrawY < firetruckY + firetruck_height && firetruck_font[DrawY-firetruckY][DrawX-firetruck3X] != 6'b000000 )	
				begin 
					colorcode = firetruck_font[DrawY-firetruckY][DrawX-firetruck3X]	;	
				end	


		//*********** draw the bus ******************  flip 
		else if( DrawX >= busX &&  DrawX < busX + bus_width && DrawY >= busY && DrawY < busY + bus_height  && bus_font[DrawY-busY][bus_width-DrawX-busX] != 6'b000000  )	
				begin 
					colorcode = bus_font[DrawY-busY][bus_width-DrawX-busX]	;	
				end	
		

		//*********** draw the motorcycle ****************** 
		else if( DrawX >= motorcycle1X &&  DrawX < motorcycle1X + motorcycle_width && DrawY >= motorcycleY && DrawY < motorcycleY + motorcycle_height && motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle1X] != 6'b000000  )	
				begin 
					colorcode = motorcycle_font[DrawY-motorcycleY][DrawX-motorcycleX]	;	
				end	


		else if( DrawX >= motorcycle2X &&  DrawX < motorcycle2X + motorcycle_width && DrawY >= motorcycleY && DrawY < motorcycleY + motorcycle_height && motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle2X] != 6'b000000  )	
				begin 
					colorcode = motorcycle_font[DrawY-motorcycleY][DrawX-motorcycleX]	;	
				end			


		else if( DrawX >= motorcycle3X &&  DrawX < motorcycle3X + motorcycle_width && DrawY >= motorcycleY && DrawY < motorcycleY + motorcycle_height && motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle3X] != 6'b000000  )	
				begin 
					colorcode = motorcycle_font[DrawY-motorcycleY][DrawX-motorcycleX]	;	
				end		



	  	//*********** draw the policecar  ****************** flip
		else if( DrawX >= policecarX &&  DrawX < policecarX + policecar_width && DrawY >= policecarY && DrawY < policecarY + policecar_height && policecar_font[DrawY-policecarY][ policecar_width - DrawX-policecarX] != 6'b000000 )	
				begin 
					colorcode = policecar_font[DrawY-policecarY][DrawX-policecarX];
				end			

		


		//*********** draw the truck **************************** 
		else if( DrawX >= truck1X &&  DrawX < truck1X + truck_width && DrawY >= truckY && DrawY < truckY + truck_height  && truck_font[DrawY-truckY][DrawX-truck1X] != 6'b000000  )	
				begin 
					colorcode = truck_font[DrawY-truckY][DrawX-truck1X];	
				end	
			

		else if( DrawX >= truck2X &&  DrawX < truck2X + truck_width && DrawY >= truckY && DrawY < truckY + truck_height  && truck_font[DrawY-truckY][DrawX-truck2X] != 6'b000000  )	
				begin 
					colorcode = truck_font[DrawY-truckY][DrawX-truck2X];	
				end			

		
		else if( DrawX >= truck3X &&  DrawX < truck3X + truck_width && DrawY >= truckY && DrawY < truckY + truck_height  && truck_font[DrawY-truckY][DrawX-truck3X] != 6'b000000  )	
				begin 
					colorcode = truck_font[DrawY-truckY][DrawX-truck3X];	
				end			


		//*********** draw the medium logs *********************** 
	    else if( DrawX >= mediumlogX &&  DrawX < mediumlogX + mediumlog_width && DrawY >= mediumlogY && DrawY < mediumlogY + mediumlog_height && mediumlog_font[DrawY-mediumlogY][DrawX-mediumlogX] != 6'b000000 )	
			 begin 
					colorcode = mediumlog_font[DrawY-mediumlogY][DrawX-mediumlogX];
			 end	
									
		




		//*********** draw the long logs *********************** 		 
		else if( DrawX >= longlogX &&  DrawX < longlogX + longlog_width && DrawY >= longlogY && DrawY < longlogY + longlog_height && longlog_font[DrawY-longlogY][DrawX-longlogX] != 6'b000000 )	
			 begin 
					colorcode = longlog_font[DrawY-longlogY][DrawX-longlogX];
			 end	
									
	    




	
		//*********** draw the two shells *********************** 
	    else if( DrawX >= twoshellX &&  DrawX < twoshellX + twoshell_width && DrawY >= twoshellY && DrawY < twoshellY + twoshell_height && Twoshell_font[DrawY-twoshellY][DrawX-twoshellX] != 6'b000000 )	
			 begin 
					colorcode = Twoshell_font[DrawY-twoshellY][DrawX-twoshellX];
			 end	
														
		





		//*********** draw the threee shells *********************** 		 
		else if( DrawX >= threeshellX &&  DrawX < threeshellX + threeshell_width && DrawY >= threeshellY && DrawY < threeshellY + threeshell_height && Threeshell_font[DrawY-threeshellY][DrawX-threeshellX] != 6'b000000 )	
			 begin 
					colorcode = Threeshell_font[DrawY-threeshellY][DrawX-threeshellX];
			 end	
								
	    




		//*********** draw the two text **************** 		 

	    // S - C - O - R - E
		else if( DrawX >= Score1x &&  DrawX < Score1X + text_width && DrawY >= ScoreY && DrawY < ScoreY + text_height && S_font[DrawY-ScoreY][DrawX-Score1X] != 6'b000000 )	
			 begin 
					colorcode =  S_font[DrawY-ScoreY][DrawX-Score1X];
			 end			 
		
		else if( DrawX >= Score2x &&  DrawX < Score2X + text_width && DrawY >= ScoreY && DrawY < ScoreY + text_height && C_font[DrawY-ScoreY][DrawX-Score2X] != 6'b000000 )	
			 begin 
					colorcode =  C_font[DrawY-ScoreY][DrawX-Score2X];
			 end
		
		else if( DrawX >= Score3x &&  DrawX < Score3X + text_width && DrawY >= ScoreY && DrawY < ScoreY + text_height && O_font[DrawY-ScoreY][DrawX-Score3X] != 6'b000000 )	
			 begin 
					colorcode =  O_font[DrawY-ScoreY][DrawX-Score3X];
			 end

		else if( DrawX >= Score4x &&  DrawX < Score4X + text_width && DrawY >= ScoreY && DrawY < ScoreY + text_height && R_font[DrawY-ScoreY][DrawX-Score4X] != 6'b000000 )	
			 begin 
					colorcode =  R_font[DrawY-ScoreY][DrawX-Score4X];
			 end

		else if( DrawX >= Score5x &&  DrawX < Score5X + text_width && DrawY >= ScoreY && DrawY < ScoreY + text_height && E_font[DrawY-ScoreY][DrawX-Score5X] != 6'b000000 )	
			 begin 
					colorcode =  E_font[DrawY-ScoreY][DrawX-Score5X];
			 end		 

	    // T - I - M - E 		 
		else if( DrawX >= Time1x &&  DrawX < Time1X + text_width && DrawY >= TimeY && DrawY < TimeY + text_height && T_font[DrawY-TimeY][DrawX-Time1X] != 6'b000000 )	
			 begin 
					colorcode =  T_font[DrawY-TimeY][DrawX-Time1X];
			 end			 
		
		else if( DrawX >= Time2x &&  DrawX < Time2X + text_width && DrawY >= TimeY && DrawY < TimeY + text_height && I_font[DrawY-TimeY][DrawX-Time2X] != 6'b000000 )	
			 begin 
					colorcode =  I_font[DrawY-TimeY][DrawX-Time1X];
			 end

		else if( DrawX >= Time3x &&  DrawX < Time3X + text_width && DrawY >= TimeY && DrawY < TimeY + text_height && M_font[DrawY-TimeY][DrawX-Time3X] != 6'b000000 )	
			 begin 
					colorcode =  M_font[DrawY-TimeY][DrawX-Time3X];
			 end

		else if( DrawX >= Time4x &&  DrawX < Time4X + text_width && DrawY >= TimeY && DrawY < TimeY + text_height && E_font[DrawY-TimeY][DrawX-Time4X] != 6'b000000 )	
			 begin 
					colorcode =  E_font[DrawY-TimeY][DrawX-Time4X];
			 end
		
		// DIGIT 0000 	

		else if( Digit1x >= Time1x &&  Digit1x < Time1X + text_width && DigitY >= TimeY && DigitY < TimeY + text_height && digit0[DigitY-TimeY][Digit1x-Time1X] != 6'b000000 )	
			 begin 
					colorcode =  digit0[DigitY-TimeY][Digit1x-Time1X];
			 end			 
		
		else if( Digit2x >= Time2x &&  Digit2x < Time2X + text_width && DigitY >= TimeY && DigitY < TimeY + text_height && digit1[DigitY-TimeY][Digit2x-Time2X] != 6'b000000 )	
			 begin 
					colorcode =  digit1[DigitY-TimeY][Digit2x-Time1X];
			 end

		else if( Digit3x >= Time3x &&  Digit3x < Time3X + text_width && DigitY >= TimeY && DigitY < TimeY + text_height && digit2[DigitY-TimeY][Digit3x-Time3X] != 6'b000000 )	
			 begin 
					colorcode =  digit2[DigitY-TimeY][Digit3x-Time3X];
			 end

		else if( Digit4x >= Time4x &&  Digit4x < Time4X + text_width && DigitY >= TimeY && DigitY < TimeY + text_height && T_font[DigitY-TimeY][Digit4x-Time4X] != 6'b000000 )	
			 begin 
					colorcode =  E_font[DigitY-TimeY][Digit4x-Time4X];
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
	    
		 

		 //********** draw 3 hearts ********************* 		
		 else if ( DrawX >= heart1X && DrawX <  heart1X + heart_width && DrawY >= heartY && DrawY < heartY + heart_height && heart_font[DrawY-heartY][DrawX-heart1X] != 6'b000000  ) 
				begin 	
					 colorcode = heart_font[DrawY-heartY][DrawX-heart1X] ;			
				end 
		 
		 else if ( DrawX >= heart2X && DrawX <  heart2X + heart_width && DrawY >= heartY && DrawY < heartY + heart_height && heart_font[DrawY-heartY][DrawX-heart2X] != 6'b000000 ) 
				begin 	
					 colorcode = heart_font[DrawY-heartY][DrawX-heart2X]  ;			
				end 
		
		 else if ( DrawX >= heart3X && DrawX <  heart2X + heart_width && DrawY >= heartY && DrawY < heartY + heart_height && heart_font[DrawY-heartY][DrawX-heart3X] != 6'b000000   ) 
				begin 	
					 colorcode = heart_font[DrawY-heartY][DrawX-heart3X]  ;			
		 
		 //********** draw the top part green grass and 5 vaders ********************* 	
		 else if ( (( DrawY >= 50 ) && ( DrawY <= 100 )) )	
				if (DrawY >= 60)
						// water 
						if ( (( DrawX >= 50 ) && ( DrawX <= 110 )) ||  ( (DrawX >= 170) && (DrawX <=230)) || ( (DrawX >= 290) && (DrawX <=350))  ||  ( (DrawX >= 410) && (DrawX <=470))  ||  ( (DrawX >= 530) && (DrawX <=590))	) 
							begin 
								
								//draw the 5 vaders ( 27 wide , 24 high ) 
								int vaderY = 30 ; 
int vader1x = 180 ; 
int vader2x = 210 ; 
int vader3x = 240 ; 
int vader4x = 270 ;
int vader5x = 270 ;	

								if


								else 			
									begin 
									colorcode = 6'b001010 ;
									end 




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

//#########################################################################################
// ****************************************************************************
// **************************** Animation *************************************
// ****************************************************************************	

logic clk_1Hz ;
int time_width = 180 ; 

SlowClock clock_generator(.*);

// 1s clock cycle
always_ff@(posedge clk_1Hz)
begin
	
	time_width <= counter - 1 ;
	if( time_width == 0 ) 
		begin 
			time_width <= 200 ;
		end  

	// left shift - decrease
	firetruck1X <= firetruck1X - 1 ;
	//firetruck2X <= firetruck2X - 1 ; 
	//firetruck3X <= firetruck3X - 1 ; 

	if( firetruck1X == 0 ) 
		begin 
			time_width <= 440 ;
		end
	


end
	
endmodule

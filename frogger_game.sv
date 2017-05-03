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
								input logic [0:15][0:26][0:5] shortlog_font,
								input logic [0:15][0:49][0:5] mediumlog_font,
								input logic [0:15][0:72][0:5] longlog_font,	
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
								input logic [3:0] ten,
               					input logic [3:0] hundred,
                				input logic [3:0] thousand,  
								input logic [2:0] lives,
								input Clk,
								output [0:5] colorcode,
								output collision ,
								output in_water , 
								output success,
								output [2:0] shift 
								);

// shift 
//  0 not shift  3'b000
//  1 left shift  3'b001
//  2 right  3'b010


//  the window is 640 wide , 480 height
// ********** group 1 - const variables  *********** 
// const varables used to draw 

// 258 - 420  road area  
parameter [9:0] frog_width=17;  
parameter [9:0] frog_height=16;  


// ****** all the Y varibles
int firetruckY = 342; 
int busY = 323;
int motorcycleY = 302;
int policecarY = 284;  
int truckY = 263; 
int hearts_count = 3 ;


int vaders_count = 0 ; 
int vader1 = 0
int vader2 = 0
int vader3 = 0
int vader4 = 0
int vader5 = 0 

// ****************************** ROW1 ***************************************
/////////////////// firetruck - right to left /////////////////////////////////   
parameter [9:0] firetruck_width=25;  
parameter [9:0] firetruck_height=16;  
//int firetruckY = 270; 
int firetruck1X = 440; 
int firetruck2X = 400; 
int firetruck3X = 280;   
int firetruck4X = 200; 
int firetruck5X = 100;   


// ****************************** ROW2 ***************************************
///////////////////// bus - left to right(flip) /////////////////////////////// 
parameter [9:0] bus_width=19;  
parameter [9:0] bus_height=14;  
//int busY = 300; 
int bus1X= 440; 
int bus2X= 400; 
int bus3X= 300; 
int bus4X= 180; 
int bus5X= 60;     


// ****************************** ROW3 ***************************************
///////////////////// motorcycle - right to left /////////////////////////////// ROW3
parameter [9:0] motorcycle_width=23;  
parameter [9:0] motorcycle_height=16;  
//int motorcycleY = 330; 
int motorcycle1X = 440; 
int motorcycle2X = 400; 
int motorcycle3X = 300;    
int motorcycle4X = 250; 
int motorcycle5X = 120;   



// ****************************** ROW4 ***************************************
/////////////////// policecar - left to right(flip) ////////////////////////////// ROW4
parameter [9:0] policecar_width=28;  
parameter [9:0] policecar_height=12;  
//int policecarY = 360;  
int policecar1X = 440; 
int policecar2X = 60;
int policecar3X = 380;
int policecar4X = 600;
int policecar5X = 560;
 
// ****************************** ROW5 ***************************************
////////////////////// truck - right to left ///////////////////////////////////// ROW5
parameter [9:0] truck_width=25;  
parameter [9:0] truck_height=14;  
//int truckY = 390;   
int truck1X = 440; 
int truck2X = 380; 
int truck3X = 300; 
int truck4X = 150; 
int truck5X = 90; 


 
////////////////////// heart /////////////////////////////////////////////////////
parameter [9:0] heart_width=14;  
parameter [9:0] heart_height=12;  

int heartY = 400 ; 
int heart1X = 100 ; 
int heart2X = 120 ; 
int heart3X = 140 ; 


/////////////////// text font ////////////////////
// 430 
parameter [9:0] text_width=14;  
parameter [9:0] text_height=14;  

int TimeY = 400 ; 
int Time1X = 330 ; 
int Time2X = 350 ; 
int Time3X = 370 ; 
int Time4X = 390 ; 

int ScoreY = 80 ; 
int Score1X = 40 ; 
int Score2X = 60 ; 
int Score3X = 80 ; 
int Score4X = 100 ;
int Score5X = 120 ;

// *****************************************************************
// 100 - 240  water area 
parameter [9:0] shortlog_height=16; 
parameter [9:0] shortlog_width=27;  

parameter [9:0] mediumlog_height=16; 
parameter [9:0] mediumlog_width=50;  
 

parameter [9:0] longlog_height=16; 
parameter [9:0] longlog_width=73;  


parameter [9:0] gator_height = 13;  
parameter [9:0] gator_width = 27; 

parameter [9:0] twoshell_width = 33;  
parameter [9:0] twoshell_height = 16; 


parameter [9:0] threeshell_width = 50;  
parameter [9:0] threeshell_height = 16; 




// *********************  ROW 1 ********************************* // 
int row1Y = 162 ;		
int row1gator = 20 ;
int row1longlog = 120 ;
int row1shortlog = 300 ;
int row1mediumlog = 360 ;
int row1twoshell = 200 ;
int row1threeshell = 442 ;

// *********************  ROW 2 ********************************* // 
int row2Y = 182 ;   
int row2gator = 188 ;
int row2longlog = 310 ;
int row2shortlog = 60 ;
int row2mediumlog = 498 ;
int row2twoshell = 136 ;
int row2threeshell = 250 ;

// *********************  ROW 3 ********************************* // 
int row3Y = 202 ;
int row3gator = 410;
int row3longlog = 10 ;
int row3shortlog = 120 ;
int row3mediumlog = 498 ;
int row3twoshell = 188 ;
int row3threeshell = 310 ;


// *********************  ROW 4 ********************************* // 
int row4Y = 222 ;
int row4gator = 38 ;
int row4longlog = 128 ;
int row4shortlog = 250 ;
int row4mediumlog = 323 ;
int row4twoshell = 502 ;
int row4threeshell = 410 ;

// *********************  score ********************************* //
// 3210
logic [0:13][0:13][0:5] digit0 ;
logic [0:13][0:13][0:5] digit1 ;
logic [0:13][0:13][0:5] digit2 ;
logic [0:13][0:13][0:5] digit3 ;

digitfont digit_instace1 ( .Clk, .digit(4'b0000), .font(digit0)); 
digitfont digit_instace2 ( .Clk, .digit(thousand), .font(digit1)); 
digitfont digit_instace3 ( .Clk, .digit(hundred), .font(digit2)); 
digitfont digit_instace4 ( .Clk, .digit(ten), .font(digit3)); 

int DigitY = 80 ; 
int Digit0X = 150 ; 
int Digit1X = 170 ; 
int Digit2X = 190 ; 
int Digit3X = 210 ;

parameter [9:0] vader_width = 27;  
parameter [9:0] vader_height = 24; 
int vaderY = 130 ; 
int vader1X = 65 ; 
int vader2X = 185 ; 
int vader3X = 305 ; 
int vader4X = 425 ;
int vader5X = 545 ;	


always_ff@(posedge Clk)
begin
	if (vaders_count == 5)
		begin 
			success == 1'b1 ; 
			vaders_count == 0 ;
			vader1 = 0 ;
			vader2 = 0 ;
			vader3 = 0 ;
			vader4 = 0 ;
			vader5 = 0 ;  
		end 	

	else 
		begin 
			success == 1'b0 ; 	
		end 
end 

//#########################################################################################
// *****************************************************************************
// ****************************  collision detection ***************************
// ****************************************************************************	

always_ff@(posedge Clk)
begin
       // fire trucks 
	   if( BallX >= firetruck1X && BallX < firetruck1X + firetruck_width && BallY >= firetruckY && BallY < firetruckY + firetruck_height && firetruck_font[BallY-firetruckY][BallX-firetruck1X] != 6'b000000 )	
				begin 
					collision <= 1'b1; 
				end	
		else if( BallX >= firetruck2X &&  BallX < firetruck2X + firetruck_width && BallY >= firetruckY && BallY < firetruckY + firetruck_height && firetruck_font[BallY-firetruckY][BallX-firetruck2X] != 6'b000000 )	
				begin 
					collision <= 1'b1; 
				end	
		else if( BallX >= firetruck3X &&  BallX < firetruck3X + firetruck_width && BallY >= firetruckY && BallY < firetruckY + firetruck_height && firetruck_font[BallY-firetruckY][BallX-firetruck3X] != 6'b000000 )	
				begin 
					collision <= 1'b1; 
				end	
		else if( BallX >= firetruck4X &&  BallX < firetruck4X + firetruck_width && BallY >= firetruckY && BallY < firetruckY + firetruck_height && firetruck_font[BallY-firetruckY][BallX-firetruck4X] != 6'b000000 )	
				begin 
					collision <= 1'b1; 
				end			
		else if( BallX >= firetruck5X &&  BallX < firetruck5X + firetruck_width && BallY >= firetruckY && BallY < firetruckY + firetruck_height && firetruck_font[BallY-firetruckY][BallX-firetruck5X] != 6'b000000 )	
				begin 
					collision <= 1'b1; 
				end	
		/////////////////////////////////// BUS //////////////////////////////////////////////////
		else if( BallX >= bus1X &&  BallX < bus1X + bus_width && BallY >= busY && BallY < busY + bus_height  && bus_font[BallY-busY][BallX-bus1X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end 
				
		else if( BallX >= bus2X &&  BallX < bus2X + bus_width && BallY >= busY && BallY < busY + bus_height  && bus_font[BallY-busY][BallX-bus2X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end 

		else if( BallX >= bus3X &&  BallX < bus3X + bus_width && BallY >= busY && BallY < busY + bus_height  && bus_font[BallY-busY][BallX-bus3X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end 

		else if( BallX >= bus4X &&  BallX < bus4X + bus_width && BallY >= busY && BallY < busY + bus_height  && bus_font[BallY-busY][BallX-bus4X] != 6'b000000  )	
				begin 
					collision <= 1'b1;
				end 
	
		else if( BallX >= bus5X &&  BallX < bus5X + bus_width && BallY >= busY && BallY < busY + bus_height  && bus_font[BallY-busY][BallX-bus5X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;
				end 
				
		///////////////////////////////////// Motorcycle /////////////////////////////////////////////////
		
		else if( BallX >= motorcycle1X &&  BallX < motorcycle1X + motorcycle_width && BallY >= motorcycleY && BallY < motorcycleY + motorcycle_height && motorcycle_font[BallY-motorcycleY][BallX-motorcycle1X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end	


		else if( BallX >= motorcycle2X &&  BallX < motorcycle2X + motorcycle_width && BallY >= motorcycleY && BallY < motorcycleY + motorcycle_height && motorcycle_font[BallY-motorcycleY][BallX-motorcycle2X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;
				end			


		else if( BallX >= motorcycle3X &&  BallX < motorcycle3X + motorcycle_width && BallY >= motorcycleY && BallY < motorcycleY + motorcycle_height && motorcycle_font[BallY-motorcycleY][BallX-motorcycle3X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end		

		else if( BallX >= motorcycle4X &&  BallX < motorcycle4X + motorcycle_width && BallY >= motorcycleY && BallY < motorcycleY + motorcycle_height && motorcycle_font[BallY-motorcycleY][BallX-motorcycle4X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end	
		
		else if( BallX >= motorcycle5X &&  BallX < motorcycle5X + motorcycle_width && BallY >= motorcycleY && BallY < motorcycleY + motorcycle_height && motorcycle_font[BallY-motorcycleY][BallX-motorcycle5X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end	

		/////////////////////////////////// POLICECAR /////////////////////////////////////////////////////////////////		

		else if( BallX >= policecar1X &&  BallX < policecar1X + policecar_width && BallY >= policecarY && BallY < policecarY + policecar_height && policecar_font[BallY-policecarY][BallX-policecar1X] != 6'b000000 )	
				begin 
					collision <= 1'b1 ;
				end			

		else if( BallX >= policecar2X &&  BallX < policecar2X + policecar_width && BallY >= policecarY && BallY < policecarY + policecar_height && policecar_font[BallY-policecarY][BallX-policecar2X] != 6'b000000 )	
				begin 
					collision <= 1'b1 ;
				end	
		else if( BallX >= policecar3X &&  BallX < policecar3X + policecar_width && BallY >= policecarY && BallY < policecarY + policecar_height && policecar_font[BallY-policecarY][BallX-policecar3X] != 6'b000000 )	
				begin 
					collision <= 1'b1 ;
				end	
				
		else if( BallX >= policecar4X &&  BallX < policecar4X + policecar_width && BallY >= policecarY && BallY < policecarY + policecar_height && policecar_font[BallY-policecarY][BallX-policecar4X] != 6'b000000 )	
				begin 
					collision <= 1'b1 ;
				end	
		else if( BallX >= policecar5X &&  BallX < policecar5X + policecar_width && BallY >= policecarY && BallY < policecarY + policecar_height && policecar_font[BallY-policecarY][BallX-policecar5X] != 6'b000000 )	
				begin 
					collision <= 1'b1 ;
				end							
		
		///////////////////////////////////// TRUCK /////////////////////////////////////////////////////////////////	
	
		else if( BallX >= truck1X &&  BallX < truck1X + truck_width && BallY >= truckY && BallY < truckY + truck_height  && truck_font[BallY-truckY][BallX-truck1X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end	
			

		else if( BallX >= truck2X &&  BallX < truck2X + truck_width && BallY >= truckY && BallY < truckY + truck_height  && truck_font[BallY-truckY][BallX-truck2X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end			

		
		else if( BallX >= truck3X &&  BallX < truck3X + truck_width && BallY >= truckY && BallY < truckY + truck_height  && truck_font[BallY-truckY][BallX-truck3X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end			

		else if( BallX >= truck4X &&  BallX < truck4X + truck_width && BallY >= truckY && BallY < truckY + truck_height  && truck_font[BallY-truckY][BallX-truck4X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end		
		
		else if( BallX >= truck5X &&  BallX < truck5X + truck_width && BallY >= truckY && BallY < truckY + truck_height  && truck_font[BallY-truckY][BallX-truck5X] != 6'b000000  )	
				begin 
					collision <= 1'b1 ;	
				end						

		/////////////////////////////////  GATORS /////////////////////////////////////////////////////////////////////////////		

		else if( BallX >= row1gator &&  BallX < row1gator + gator_width && BallY >= row1Y && BallY < row1Y + gator_height  && gator_font[BallY-row1Y][BallX-row1gator] != 6'b000000  )	
			begin 
				collision <= 1'b1 ;	
			end			

		else if( BallX >= row3gator &&  BallX < row3gator + gator_width && BallY >= row3Y && BallY < row3Y + gator_height  && gator_font[BallY-row3Y][BallX-row3gator] != 6'b000000  )	
			begin 
				collision <= 1'b1 ;		
			end

		else
			begin 
				collision <= 1'b0 ;
			end 
end


//#########################################################################################
// *****************************************************************************
// ****************************  Landing detection ***************************
// ****************************************************************************	

always_ff@(posedge Clk)
begin
		//*********** ROW1 DRAW *********************** 
		if( BallX >= row1longlog &&  BallX < row1longlog + longlog_width && BallY >= row1Y && BallY < row1Y + longlog_height  && longlog_font[BallY-row1Y][BallX-row1longlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b001 ;
			end	
		

		else if( BallX >= row1mediumlog &&  BallX < row1mediumlog + mediumlog_width && BallY >= row1Y && BallY < row1Y + mediumlog_height  && mediumlog_font[BallY-row1Y][BallX-row1mediumlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b001 ;
			end	

		else if( BallX >= row1shortlog &&  BallX < row1shortlog + shortlog_width && BallY >= row1Y && BallY < row1Y + shortlog_height  && shortlog_font[BallY-row1Y][BallX-row1shortlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b001 ;
			end		

		else if( BallX >= row1twoshell &&  BallX < row1twoshell + twoshell_width && BallY >= row1Y && BallY < row1Y + twoshell_height  && Twoshell_font[BallY-row1Y][BallX-row1twoshell] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b001 ;
			end
		
		else if( BallX >= row1threeshell &&  BallX < row1threeshell + threeshell_width && BallY >= row1Y && BallY < row1Y + threeshell_height  && Threeshell_font[BallY-row1Y][BallX-row1threeshell] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b001 ;
			end

		//*********** ROW2 Ball *********************** 		 
		else if( BallX >= row2longlog &&  BallX < row2longlog + longlog_width && BallY >= row2Y && BallY < row2Y + longlog_height  && longlog_font[BallY-row2Y][BallX-row2longlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b010 ;	
			end	
		

		else if( BallX >= row2mediumlog &&  BallX < row2mediumlog + mediumlog_width && BallY >= row2Y && BallY < row2Y + mediumlog_height  && mediumlog_font[BallY-row2Y][BallX-row2mediumlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b010 ;
			end	

		else if( BallX >= row2shortlog &&  BallX < row2shortlog + shortlog_width && BallY >= row2Y && BallY < row2Y + shortlog_height  && shortlog_font[BallY-row2Y][BallX-row2shortlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b010 ;	
			end		

		else if( BallX >= row2twoshell &&  BallX < row2twoshell + twoshell_width && BallY >= row2Y && BallY < row2Y + twoshell_height  && Twoshell_font[BallY-row2Y][BallX-row2twoshell] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b010 ;
			end
		
		else if( BallX >= row2threeshell &&  BallX < row2threeshell + threeshell_width && BallY >= row2Y && BallY < row2Y + threeshell_height  && Threeshell_font[BallY-row2Y][BallX-row2threeshell] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b010 ;
			end
 
		//*********** ROW3 Ball *********************** 
		
		else if( BallX >= row3longlog &&  BallX < row3longlog + longlog_width && BallY >= row3Y && BallY < row3Y + longlog_height  && longlog_font[BallY-row3Y][BallX-row3longlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b001 ;	
			end	
		

		else if( BallX >= row3mediumlog &&  BallX < row3mediumlog + mediumlog_width && BallY >= row3Y && BallY < row3Y + mediumlog_height  && mediumlog_font[BallY-row3Y][BallX-row3mediumlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b001 ;	
			end	

		else if( BallX >= row3shortlog &&  BallX < row3shortlog + shortlog_width && BallY >= row3Y && BallY < row3Y + shortlog_height  && shortlog_font[BallY-row3Y][BallX-row3shortlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b001 ;
			end		

		else if( BallX >= row3twoshell &&  BallX < row3twoshell + twoshell_width && BallY >= row3Y && BallY < row3Y + twoshell_height  && Twoshell_font[BallY-row3Y][BallX-row3twoshell] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b001 ;
			end
		
		else if( BallX >= row3threeshell &&  BallX < row3threeshell + threeshell_width && BallY >= row3Y && BallY < row3Y + threeshell_height  && Threeshell_font[BallY-row3Y][BallX-row3threeshell] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b001 ;	
			end
											
		
		//*********** ROW4 DRAW *********************** 		 
			
		else if( BallX >= row4longlog &&  BallX < row4longlog + longlog_width && BallY >= row4Y && BallY < row4Y + longlog_height  && longlog_font[BallY-row4Y][BallX-row4longlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b010 ;	
			end	
		

		else if( BallX >= row4mediumlog &&  BallX < row4mediumlog + mediumlog_width && BallY >= row4Y && BallY < row4Y + mediumlog_height  && mediumlog_font[BallY-row4Y][BallX-row4mediumlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b010 ;	
			end	

		else if( BallX >= row4shortlog &&  BallX < row4shortlog + shortlog_width && BallY >= row4Y && BallY < row4Y + shortlog_height  && shortlog_font[BallY-row4Y][BallX-row4shortlog] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b010 ;	
			end		

		else if( BallX >= row4twoshell &&  BallX < row4twoshell + twoshell_width && BallY >= row4Y && BallY < row4Y + twoshell_height  && Twoshell_font[BallY-row4Y][BallX-row4twoshell] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b010 ;	
			end
		
		else if( BallX >= row4threeshell &&  BallX < row4threeshell + threeshell_width && BallY >= row4Y && BallY < row4Y + threeshell_height  && Threeshell_font[BallY-row4Y][BallX-row4threeshell] != 6'b000000  )	
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b010 ;
			end
		
		else if ( DrawY >= 125 && DrawY <= 155 && ( DrawX >= 60 ) && ( DrawX <= 100 ) )
			begin 
				vaders_count <= vaders_count + 1 ; 
				vader1 <= 1 ; 
				in_water <= 1'b0 ;
				shift <= 3'b000 ;
	
			end 	
		else if ( DrawY >= 125 && DrawY <= 155 && ( DrawX >= 180 ) && ( DrawX <= 220 ) )
			begin 
				vaders_count <= vaders_count + 1 ; 
				vader2 <= 1 ; 
				in_water <= 1'b0 ;
				shift <= 3'b000 ;
			end 

		else if ( DrawY >= 125 && DrawY <= 155 && ( DrawX >= 300 ) && ( DrawX <= 340 ) )
			begin 
				vaders_count <= vaders_count + 1 ; 
				vader3 <= 1 ; 
				in_water <= 1'b0 ;
				shift <= 3'b000 ;
			end 

		else if ( DrawY >= 125 && DrawY <= 155 && ( DrawX >= 420 ) && ( DrawX <= 460 ) )
			begin 
				vaders_count <= vaders_count + 1 ; 
				vader4 <= 1 ; 
				in_water <= 1'b0 ;
				shift <= 3'b000 ;
			end 
		else if ( DrawY >= 125 && DrawY <= 155 && ( DrawX >= 540 ) && ( DrawX <= 580 ) )
			begin 
				vaders_count <= vaders_count + 1 ; 
				vader5 <= 1 ; 
				in_water <= 1'b0 ;
				shift <= 3'b000 ;
			end 			
		else if ( BallY < 240 )	
			begin 
				in_water <= 1'b1 ;
				shift <= 3'b000 ;
			end
		else 
			begin 
				in_water <= 1'b0 ;
				shift <= 3'b000 ;	
			end 


end  


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

		else if( DrawX >= firetruck4X &&  DrawX < firetruck4X + firetruck_width && DrawY >= firetruckY && DrawY < firetruckY + firetruck_height && firetruck_font[DrawY-firetruckY][DrawX-firetruck4X] != 6'b000000 )	
				begin 
					colorcode = firetruck_font[DrawY-firetruckY][DrawX-firetruck4X]	;	
				end			

		else if( DrawX >= firetruck5X &&  DrawX < firetruck5X + firetruck_width && DrawY >= firetruckY && DrawY < firetruckY + firetruck_height && firetruck_font[DrawY-firetruckY][DrawX-firetruck5X] != 6'b000000 )	
				begin 
					colorcode = firetruck_font[DrawY-firetruckY][DrawX-firetruck5X]	;	
				end	

		//*********** draw the bus ******************  flip 
		else if( DrawX >= bus1X &&  DrawX < bus1X + bus_width && DrawY >= busY && DrawY < busY + bus_height  && bus_font[DrawY-busY][DrawX-bus1X] != 6'b000000  )	
				begin 
					colorcode = bus_font[DrawY-busY][DrawX-bus1X]	;	
				end	

		else if( DrawX >= bus2X &&  DrawX < bus2X + bus_width && DrawY >= busY && DrawY < busY + bus_height  && bus_font[DrawY-busY][DrawX-bus2X] != 6'b000000  )	
				begin 
					colorcode = bus_font[DrawY-busY][DrawX-bus2X]	;	
				end	

		else if( DrawX >= bus3X &&  DrawX < bus3X + bus_width && DrawY >= busY && DrawY < busY + bus_height  && bus_font[DrawY-busY][DrawX-bus3X] != 6'b000000  )	
				begin 
					colorcode = bus_font[DrawY-busY][DrawX-bus3X]	;	
				end	

		else if( DrawX >= bus4X &&  DrawX < bus4X + bus_width && DrawY >= busY && DrawY < busY + bus_height  && bus_font[DrawY-busY][DrawX-bus4X] != 6'b000000  )	
				begin 
					colorcode = bus_font[DrawY-busY][DrawX-bus4X]	;	
				end	

		else if( DrawX >= bus5X &&  DrawX < bus5X + bus_width && DrawY >= busY && DrawY < busY + bus_height  && bus_font[DrawY-busY][DrawX-bus5X] != 6'b000000  )	
				begin 
					colorcode = bus_font[DrawY-busY][DrawX-bus5X]	;	
				end									
		


		//*********** draw the motorcycle ****************** 
		else if( DrawX >= motorcycle1X &&  DrawX < motorcycle1X + motorcycle_width && DrawY >= motorcycleY && DrawY < motorcycleY + motorcycle_height && motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle1X] != 6'b000000  )	
				begin 
					colorcode = motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle1X]	;	
				end	


		else if( DrawX >= motorcycle2X &&  DrawX < motorcycle2X + motorcycle_width && DrawY >= motorcycleY && DrawY < motorcycleY + motorcycle_height && motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle2X] != 6'b000000  )	
				begin 
					colorcode = motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle2X]	;	
				end			


		else if( DrawX >= motorcycle3X &&  DrawX < motorcycle3X + motorcycle_width && DrawY >= motorcycleY && DrawY < motorcycleY + motorcycle_height && motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle3X] != 6'b000000  )	
				begin 
					colorcode = motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle3X]	;	
				end		

		else if( DrawX >= motorcycle4X &&  DrawX < motorcycle4X + motorcycle_width && DrawY >= motorcycleY && DrawY < motorcycleY + motorcycle_height && motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle4X] != 6'b000000  )	
				begin 
					colorcode = motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle4X]	;	
				end	
		
		else if( DrawX >= motorcycle5X &&  DrawX < motorcycle5X + motorcycle_width && DrawY >= motorcycleY && DrawY < motorcycleY + motorcycle_height && motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle5X] != 6'b000000  )	
				begin 
					colorcode = motorcycle_font[DrawY-motorcycleY][DrawX-motorcycle5X]	;	
				end							


	  	//*********** draw the policecar  ****************** flip
		else if( DrawX >= policecar1X &&  DrawX < policecar1X + policecar_width && DrawY >= policecarY && DrawY < policecarY + policecar_height && policecar_font[DrawY-policecarY][DrawX-policecar1X] != 6'b000000 )	
				begin 
					colorcode = policecar_font[DrawY-policecarY][DrawX-policecar1X];
				end			

		else if( DrawX >= policecar2X &&  DrawX < policecar2X + policecar_width && DrawY >= policecarY && DrawY < policecarY + policecar_height && policecar_font[DrawY-policecarY][DrawX-policecar2X] != 6'b000000 )	
				begin 
					colorcode = policecar_font[DrawY-policecarY][DrawX-policecar2X];
				end	
		else if( DrawX >= policecar3X &&  DrawX < policecar3X + policecar_width && DrawY >= policecarY && DrawY < policecarY + policecar_height && policecar_font[DrawY-policecarY][DrawX-policecar3X] != 6'b000000 )	
				begin 
					colorcode = policecar_font[DrawY-policecarY][DrawX-policecar3X];
				end	
				
		else if( DrawX >= policecar4X &&  DrawX < policecar4X + policecar_width && DrawY >= policecarY && DrawY < policecarY + policecar_height && policecar_font[DrawY-policecarY][DrawX-policecar4X] != 6'b000000 )	
				begin 
					colorcode = policecar_font[DrawY-policecarY][DrawX-policecar4X];
				end	
		else if( DrawX >= policecar5X &&  DrawX < policecar5X + policecar_width && DrawY >= policecarY && DrawY < policecarY + policecar_height && policecar_font[DrawY-policecarY][DrawX-policecar5X] != 6'b000000 )	
				begin 
					colorcode = policecar_font[DrawY-policecarY][DrawX-policecar5X];
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

		else if( DrawX >= truck4X &&  DrawX < truck4X + truck_width && DrawY >= truckY && DrawY < truckY + truck_height  && truck_font[DrawY-truckY][DrawX-truck4X] != 6'b000000  )	
				begin 
					colorcode = truck_font[DrawY-truckY][DrawX-truck4X];	
				end		
		
		else if( DrawX >= truck5X &&  DrawX < truck5X + truck_width && DrawY >= truckY && DrawY < truckY + truck_height  && truck_font[DrawY-truckY][DrawX-truck5X] != 6'b000000  )	
				begin 
					colorcode = truck_font[DrawY-truckY][DrawX-truck5X];	
				end						

		//*********** ROW1 DRAW *********************** 
		else if( DrawX >= row1gator &&  DrawX < row1gator + gator_width && DrawY >= row1Y && DrawY < row1Y + gator_height  && gator_font[DrawY-row1Y][DrawX-row1gator] != 6'b000000  )	
			begin 
				colorcode = gator_font[DrawY-row1Y][DrawX-row1gator];	
			end	
		
		else if( DrawX >= row1longlog &&  DrawX < row1longlog + longlog_width && DrawY >= row1Y && DrawY < row1Y + longlog_height  && longlog_font[DrawY-row1Y][DrawX-row1longlog] != 6'b000000  )	
			begin 
				colorcode = longlog_font[DrawY-row1Y][DrawX-row1longlog];
			end	
		

		else if( DrawX >= row1mediumlog &&  DrawX < row1mediumlog + mediumlog_width && DrawY >= row1Y && DrawY < row1Y + mediumlog_height  && mediumlog_font[DrawY-row1Y][DrawX-row1mediumlog] != 6'b000000  )	
			begin 
				colorcode = mediumlog_font[DrawY-row1Y][DrawX-row1mediumlog]	;
			end	

		else if( DrawX >= row1shortlog &&  DrawX < row1shortlog + shortlog_width && DrawY >= row1Y && DrawY < row1Y + shortlog_height  && shortlog_font[DrawY-row1Y][DrawX-row1shortlog] != 6'b000000  )	
			begin 
				colorcode = shortlog_font[DrawY-row1Y][DrawX-row1shortlog];	
			end		

		else if( DrawX >= row1twoshell &&  DrawX < row1twoshell + twoshell_width && DrawY >= row1Y && DrawY < row1Y + twoshell_height  && Twoshell_font[DrawY-row1Y][DrawX-row1twoshell] != 6'b000000  )	
			begin 
				colorcode = Twoshell_font[DrawY-row1Y][DrawX-row1twoshell];	
			end
		
		else if( DrawX >= row1threeshell &&  DrawX < row1threeshell + threeshell_width && DrawY >= row1Y && DrawY < row1Y + threeshell_height  && Threeshell_font[DrawY-row1Y][DrawX-row1threeshell] != 6'b000000  )	
			begin 
				colorcode = Threeshell_font[DrawY-row1Y][DrawX-row1threeshell];	
			end

		//*********** ROW2 DRAW *********************** 		 
		else if( DrawX >= row2longlog &&  DrawX < row2longlog + longlog_width && DrawY >= row2Y && DrawY < row2Y + longlog_height  && longlog_font[DrawY-row2Y][DrawX-row2longlog] != 6'b000000  )	
			begin 
				colorcode = longlog_font[DrawY-row2Y][DrawX-row2longlog];	
			end	
		

		else if( DrawX >= row2mediumlog &&  DrawX < row2mediumlog + mediumlog_width && DrawY >= row2Y && DrawY < row2Y + mediumlog_height  && mediumlog_font[DrawY-row2Y][DrawX-row2mediumlog] != 6'b000000  )	
			begin 
				colorcode = mediumlog_font[DrawY-row2Y][DrawX-row2mediumlog];	
			end	

		else if( DrawX >= row2shortlog &&  DrawX < row2shortlog + shortlog_width && DrawY >= row2Y && DrawY < row2Y + shortlog_height  && shortlog_font[DrawY-row2Y][DrawX-row2shortlog] != 6'b000000  )	
			begin 
				colorcode = shortlog_font[DrawY-row2Y][DrawX-row2shortlog];	
			end		

		else if( DrawX >= row2twoshell &&  DrawX < row2twoshell + twoshell_width && DrawY >= row2Y && DrawY < row2Y + twoshell_height  && Twoshell_font[DrawY-row2Y][DrawX-row2twoshell] != 6'b000000  )	
			begin 
				colorcode = Twoshell_font[DrawY-row2Y][DrawX-row2twoshell];	
			end
		
		else if( DrawX >= row2threeshell &&  DrawX < row2threeshell + threeshell_width && DrawY >= row2Y && DrawY < row2Y + threeshell_height  && Threeshell_font[DrawY-row2Y][DrawX-row2threeshell] != 6'b000000  )	
			begin 
				colorcode = Threeshell_font[DrawY-row2Y][DrawX-row2threeshell]	;
			end
 
		//*********** ROW3 DRAW *********************** 
		else if( DrawX >= row3gator &&  DrawX < row3gator + gator_width && DrawY >= row3Y && DrawY < row3Y + gator_height  && gator_font[DrawY-row3Y][DrawX-row3gator] != 6'b000000  )	
			begin 
				colorcode = gator_font[DrawY-row3Y][DrawX-row3gator];	
			end
		
		else if( DrawX >= row3longlog &&  DrawX < row3longlog + longlog_width && DrawY >= row3Y && DrawY < row3Y + longlog_height  && longlog_font[DrawY-row3Y][DrawX-row3longlog] != 6'b000000  )	
			begin 
				colorcode = longlog_font[DrawY-row3Y][DrawX-row3longlog];	
			end	
		

		else if( DrawX >= row3mediumlog &&  DrawX < row3mediumlog + mediumlog_width && DrawY >= row3Y && DrawY < row3Y + mediumlog_height  && mediumlog_font[DrawY-row3Y][DrawX-row3mediumlog] != 6'b000000  )	
			begin 
				colorcode = mediumlog_font[DrawY-row3Y][DrawX-row3mediumlog];	
			end	

		else if( DrawX >= row3shortlog &&  DrawX < row3shortlog + shortlog_width && DrawY >= row3Y && DrawY < row3Y + shortlog_height  && shortlog_font[DrawY-row3Y][DrawX-row3shortlog] != 6'b000000  )	
			begin 
				colorcode = shortlog_font[DrawY-row3Y][DrawX-row3shortlog];	
			end		

		else if( DrawX >= row3twoshell &&  DrawX < row3twoshell + twoshell_width && DrawY >= row3Y && DrawY < row3Y + twoshell_height  && Twoshell_font[DrawY-row3Y][DrawX-row3twoshell] != 6'b000000  )	
			begin 
				colorcode = Twoshell_font[DrawY-row3Y][DrawX-row3twoshell];	
			end
		
		else if( DrawX >= row3threeshell &&  DrawX < row3threeshell + threeshell_width && DrawY >= row3Y && DrawY < row3Y + threeshell_height  && Threeshell_font[DrawY-row3Y][DrawX-row3threeshell] != 6'b000000  )	
			begin 
				colorcode = Threeshell_font[DrawY-row3Y][DrawX-row3threeshell];	
			end
											
		
		//*********** ROW4 DRAW *********************** 		 
			
		else if( DrawX >= row4longlog &&  DrawX < row4longlog + longlog_width && DrawY >= row4Y && DrawY < row4Y + longlog_height  && longlog_font[DrawY-row4Y][DrawX-row4longlog] != 6'b000000  )	
			begin 
				colorcode = longlog_font[DrawY-row4Y][DrawX-row4longlog];	
			end	
		

		else if( DrawX >= row4mediumlog &&  DrawX < row4mediumlog + mediumlog_width && DrawY >= row4Y && DrawY < row4Y + mediumlog_height  && mediumlog_font[DrawY-row4Y][DrawX-row4mediumlog] != 6'b000000  )	
			begin 
				colorcode = mediumlog_font[DrawY-row4Y][DrawX-row4mediumlog];	
			end	

		else if( DrawX >= row4shortlog &&  DrawX < row4shortlog + shortlog_width && DrawY >= row4Y && DrawY < row4Y + shortlog_height  && shortlog_font[DrawY-row4Y][DrawX-row4shortlog] != 6'b000000  )	
			begin 
				colorcode = shortlog_font[DrawY-row4Y][DrawX-row4shortlog];	
			end		

		else if( DrawX >= row4twoshell &&  DrawX < row4twoshell + twoshell_width && DrawY >= row4Y && DrawY < row4Y + twoshell_height  && Twoshell_font[DrawY-row4Y][DrawX-row4twoshell] != 6'b000000  )	
			begin 
				colorcode = Twoshell_font[DrawY-row4Y][DrawX-row4twoshell];	
			end
		
		else if( DrawX >= row4threeshell &&  DrawX < row4threeshell + threeshell_width && DrawY >= row4Y && DrawY < row4Y + threeshell_height  && Threeshell_font[DrawY-row4Y][DrawX-row4threeshell] != 6'b000000  )	
			begin 
				colorcode = Threeshell_font[DrawY-row4Y][DrawX-row4threeshell];	
			end
								
	   
		//*********** draw the two text **************** 		 

	    // S - C - O - R - E
		else if( DrawX >= Score1X &&  DrawX < Score1X + text_width && DrawY >= ScoreY && DrawY < ScoreY + text_height && S_font[DrawY-ScoreY][DrawX-Score1X] != 6'b000000 )	
			 begin 
					colorcode =  S_font[DrawY-ScoreY][DrawX-Score1X];
			 end			 
		
		else if( DrawX >= Score2X &&  DrawX < Score2X + text_width && DrawY >= ScoreY && DrawY < ScoreY + text_height && C_font[DrawY-ScoreY][DrawX-Score2X] != 6'b000000 )	
			 begin 
					colorcode =  C_font[DrawY-ScoreY][DrawX-Score2X];
			 end
		
		else if( DrawX >= Score3X &&  DrawX < Score3X + text_width && DrawY >= ScoreY && DrawY < ScoreY + text_height && O_font[DrawY-ScoreY][DrawX-Score3X] != 6'b000000 )	
			 begin 
					colorcode =  O_font[DrawY-ScoreY][DrawX-Score3X];
			 end

		else if( DrawX >= Score4X &&  DrawX < Score4X + text_width && DrawY >= ScoreY && DrawY < ScoreY + text_height && R_font[DrawY-ScoreY][DrawX-Score4X] != 6'b000000 )	
			 begin 
					colorcode =  R_font[DrawY-ScoreY][DrawX-Score4X];
			 end

		else if( DrawX >= Score5X &&  DrawX < Score5X + text_width && DrawY >= ScoreY && DrawY < ScoreY + text_height && E_font[DrawY-ScoreY][DrawX-Score5X] != 6'b000000 )	
			 begin 
					colorcode =  E_font[DrawY-ScoreY][DrawX-Score5X];
			 end		 

	    // T - I - M - E 		 
		else if( DrawX >= Time1X &&  DrawX < Time1X + text_width && DrawY >= TimeY && DrawY < TimeY + text_height && T_font[DrawY-TimeY][DrawX-Time1X] != 6'b000000 )	
			 begin 
					colorcode =  T_font[DrawY-TimeY][DrawX-Time1X];
			 end			 
		
		else if( DrawX >= Time2X &&  DrawX < Time2X + text_width && DrawY >= TimeY && DrawY < TimeY + text_height && I_font[DrawY-TimeY][DrawX-Time2X] != 6'b000000 )	
			 begin 
					colorcode =  I_font[DrawY-TimeY][DrawX-Time2X];
			 end

		else if( DrawX >= Time3X &&  DrawX < Time3X + text_width && DrawY >= TimeY && DrawY < TimeY + text_height && M_font[DrawY-TimeY][DrawX-Time3X] != 6'b000000 )	
			 begin 
					colorcode =  M_font[DrawY-TimeY][DrawX-Time3X];
			 end

		else if( DrawX >= Time4X &&  DrawX < Time4X + text_width && DrawY >= TimeY && DrawY < TimeY + text_height && E_font[DrawY-TimeY][DrawX-Time4X] != 6'b000000 )	
			 begin 
					colorcode =  E_font[DrawY-TimeY][DrawX-Time4X];
			 end
				
		// DIGIT 0000 	
      	else if( DrawX >= Digit0X &&  DrawX < Digit0X + text_width && DrawY >= DigitY && DrawY < DigitY + text_height && digit0[DrawY-DigitY][DrawX-Digit0X] != 6'b000000 )	
			 begin 
					colorcode =  6'b000101 ;
			 end			 
		
		else if( DrawX >= Digit1X &&  DrawX < Digit1X + text_width && DrawY >= DigitY && DrawY < DigitY + text_height && digit1[DrawY-DigitY][DrawX-Digit1X] != 6'b000000 )	
			 begin 
					colorcode =  6'b000101 ;
			 end		
	
		else if( DrawX >= Digit2X &&  DrawX < Digit2X + text_width && DrawY >= DigitY && DrawY < DigitY + text_height && digit2[DrawY-DigitY][DrawX-Digit2X] != 6'b000000 )	
			 begin 
					colorcode =  6'b000101 ;
			 end	
	
		else if( DrawX >= Digit3X &&  DrawX < Digit3X + text_width && DrawY >= DigitY && DrawY < DigitY + text_height && digit3[DrawY-DigitY][DrawX-Digit3X] != 6'b000000 )	
			 begin 
					colorcode =  6'b000101 ;
			 end	
		
	    //*********** draw the two purple lines **************** 
		else if ( (( DrawY >= 360 ) && ( DrawY <= 380 )) ||  ( (DrawY >= 240) && (DrawY <=260))    ) 
				begin 	
				   colorcode = 6'b001001 ;							
				end 
		
	    

	    //********** draw the green time bar ********************* 		
		 else if ( DrawX >= 430 && DrawX < 430 + time_width && DrawY >= 400 && DrawY < 415 ) 
				begin 	
					 colorcode = 6'b000010 ;			
				end 
	    
		
		 //********** draw 3 hearts ********************* 		
		 else if ( DrawX >= heart1X && DrawX <  heart1X + heart_width && DrawY >= heartY && DrawY < heartY + heart_height && heart_font[DrawY-heartY][DrawX-heart1X] != 6'b000000 && ( lives == 3'b011 || lives == 3'b010 ||  lives == 3'b001 ) ) 
				begin 	
					 colorcode = heart_font[DrawY-heartY][DrawX-heart1X] ;			
				end 
		 
		 else if ( DrawX >= heart2X && DrawX <  heart2X + heart_width && DrawY >= heartY && DrawY < heartY + heart_height && heart_font[DrawY-heartY][DrawX-heart2X] != 6'b000000 && ( lives == 3'b011 || lives == 3'b010 ) ) 
				begin 	
					 colorcode = heart_font[DrawY-heartY][DrawX-heart2X]  ;			
				end 
		
		 else if ( DrawX >= heart3X && DrawX <  heart3X + heart_width && DrawY >= heartY && DrawY < heartY + heart_height && heart_font[DrawY-heartY][DrawX-heart3X] != 6'b000000 && lives == 3'b011   ) 
				begin 	
					 colorcode = heart_font[DrawY-heartY][DrawX-heart3X]  ;			
				end 
		 //********** draw the top part green grass and 5 vaders ********************* 	
		 else if ( (( DrawY >= 105 ) && ( DrawY <= 155 )) )	
				if (DrawY >= 125)
						// ------------
						if ( (( DrawX >= 60 ) && ( DrawX <= 100 )) ||  ( (DrawX >= 180) && (DrawX <=220)) || ( (DrawX >= 300) && (DrawX <=340))  ||  ( (DrawX >= 420) && (DrawX <=460))  ||  ( (DrawX >= 540) && (DrawX <=580))	) 
								 if ( DrawX >= vader1X && DrawX <  vader1X + vader_width && DrawY >= vaderY && DrawY < vaderY + vader_height && vader_font[DrawY-vaderY][DrawX-vader1X] != 6'b000000 && vader1 == 1 ) 
								 begin 	
										colorcode = vader_font[DrawY-vaderY][DrawX-vader1X] ;			
								 end  

								 else if ( DrawX >= vader2X && DrawX <  vader2X + vader_width && DrawY >= vaderY && DrawY < vaderY + vader_height && vader_font[DrawY-vaderY][DrawX-vader2X] != 6'b000000 && vader2 == 1 ) 
								 begin 	
										colorcode = vader_font[DrawY-vaderY][DrawX-vader2X] ;			
								 end 
								 
								 else if ( DrawX >= vader3X && DrawX <  vader3X + vader_width && DrawY >= vaderY && DrawY < vaderY + vader_height && vader_font[DrawY-vaderY][DrawX-vader3X] != 6'b000000 && vader3 == 1 ) 
								 begin 	
										colorcode = vader_font[DrawY-vaderY][DrawX-vader3X] ;			
								 end 
								 
								 else if ( DrawX >= vader4X && DrawX <  vader4X + vader_width && DrawY >= vaderY && DrawY < vaderY + vader_height && vader_font[DrawY-vaderY][DrawX-vader4X] != 6'b000000 && vader4 == 1 ) 
								 begin 	
										colorcode = vader_font[DrawY-vaderY][DrawX-vader4X] ;			
								 end 
								 
								 else if ( DrawX >= vader5X && DrawX <  vader5X + vader_width && DrawY >= vaderY && DrawY < vaderY + vader_height && vader_font[DrawY-vaderY][DrawX-vader5X] != 6'b000000 && vader5 == 1 ) 
								 begin 	
										colorcode = vader_font[DrawY-vaderY][DrawX-vader5X] ;			
								 end 
								 
								 else 			
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

//#########################################################################################
// ****************************************************************************
// **************************** Animation *************************************
// ****************************************************************************	

logic clk_1Hz ;
logic clk_4Hz ;
int time_width = 180 ; 

SlowClock clock_generator(.*);
MediumClock clock_generator2(.*);

// 1s clock cycle
always_ff@(posedge clk_1Hz)
	begin

	if( time_width == 0 ) 
		begin 
			time_width <= 180 ;
			time_up <= 1'b1 ; 
		end  	
	else 
		begin 
			time_width <= time_width - 1 ;
			time_up <= 1'b0 ; 
		end 	
  	
   end 


// 0.25s clock cycle
/////////////////////////////////////////   
always_ff@(posedge clk_4Hz)
	begin
	
	// change timer bar
	firetruck1X <=  firetruck1X - 1 ;
	firetruck2X <=  firetruck2X - 1 ;
	firetruck3X <=  firetruck3X - 1 ;
	firetruck4X <=  firetruck4X - 1 ;
	firetruck5X <=  firetruck5X - 1 ;
	if( firetruck1X == 0 ) 
		begin 
			 firetruck1X <= 640 ;
		end  	
   
	if( firetruck2X == 0 ) 
		begin 
			 firetruck2X <= 640 ;
		end 
		
	if( firetruck3X == 0 ) 
		begin 
			 firetruck3X <= 640 ;
		end 	
	
	if( firetruck4X == 0 ) 
		begin 
			 firetruck4X <= 640 ;
		end 	
	
	if( firetruck5X == 0 ) 
		begin 
			 firetruck5X <= 640 ;
		end 	
	
	end 

////////////////////////////////
always_ff@(posedge clk_4Hz)
	begin
	
	// change timer bar
	bus1X <=  bus1X + 1 ;
	bus2X <=  bus2X + 1 ;
	bus3X <=  bus3X + 1 ;
	bus4X <=  bus4X + 1 ;
	bus5X <=  bus5X + 1 ;
	if( bus1X == 640 ) 
		begin 
			 bus1X <= 0 ;
		end  	
   
	if( bus2X == 640 ) 
		begin 
			 bus2X <= 0;
		end 
		
	if( bus3X == 640 ) 
		begin 
			 bus3X <= 0;
		end 	
	
	if( bus4X == 640 ) 
		begin 
			 bus4X <= 0;
		end 	
	if( bus5X == 640 ) 
		begin 
			 bus5X <= 0 ;
		end 	
	
	end 

////////////////////////////////
always_ff@(posedge clk_4Hz)
	begin
	
	// change timer bar
	motorcycle1X <=  motorcycle1X - 1 ;
	motorcycle2X <=  motorcycle2X - 1 ;
	motorcycle3X <=  motorcycle3X - 1 ;
	motorcycle4X <=  motorcycle4X - 1 ;
	motorcycle5X <=  motorcycle5X - 1 ;
	if( motorcycle1X == 0 ) 
		begin 
			 motorcycle1X <= 640 ;
		end  	
   
	if( motorcycle2X == 0 ) 
		begin 
			 motorcycle2X <= 640 ;
		end 
		
	if( motorcycle3X == 0 ) 
		begin 
			 motorcycle3X <= 640 ;
		end 	
	if( motorcycle4X == 0 ) 
		begin 
			 motorcycle4X <= 640 ;
		end 	
	if( motorcycle5X == 0 ) 
		begin 
			 motorcycle5X <= 640 ;
		end 	
	
	end

///////////////////////////////////
always_ff@(posedge clk_4Hz)
	begin
	
	// change timer bar
	truck1X <=  truck1X - 1 ;
	truck2X <=  truck2X - 1 ;
	truck3X <=  truck3X - 1 ;
	truck4X <=  truck4X - 1 ;
	truck5X <=  truck5X - 1 ;
	if( truck1X == 0 ) 
		begin 
			 truck1X <= 640 ;
		end  	
   
	if( truck2X == 0 ) 
		begin 
			 truck2X <= 640 ;
		end 
		
	if( truck3X == 0 ) 
		begin 
			 truck3X <= 640 ;
		end 	
	if( truck4X == 0 ) 
		begin 
			 truck4X <= 640 ;
		end 	
	if( truck5X == 0 ) 
		begin 
			 truck5X <= 640 ;
		end 	
	end	

////////////////////////////////
always_ff@(posedge clk_4Hz)
	begin
	
	// change timer bar
	policecar1X <=  policecar1X + 1 ;
	policecar2X <=  policecar2X + 1 ;
	policecar3X <=  policecar3X + 1 ;
	policecar4X <=  policecar4X + 1 ;
	policecar5X <=  policecar5X + 1 ;
	if( policecar1X == 640 ) 
		begin 
			 policecar1X <= 0 ;
		end  	
   
	if( policecar2X == 640 ) 
		begin 
			 policecar2X <= 0 ;
		end 
		
	if( policecar3X == 640 ) 
		begin 
			 policecar3X <= 0 ;
		end 	
	if( policecar4X == 640 ) 
		begin 
			 policecar4X <= 0 ;
		end 	
	if( policecar5X == 640 ) 
		begin 
			 policecar5X <= 0 ;
		end 	
	
	end	


always_ff@(posedge clk_4Hz)
	begin
	
	// change timer bar
	row1gator <= row1gator - 1  ;
	row1longlog <= row1longlog - 1 ;
	row1shortlog <= row1shortlog - 1 ;
	row1mediumlog <= row1mediumlog - 1 ;
	row1twoshell <= row1twoshell - 1 ;
	row1threeshell <= row1threeshell - 1 ;
	
	if( row1gator == 0 ) 
		begin 
			 row1gator <= 640 ;
		end  	
   
	if( row1longlog == 0 ) 
		begin 
			 row1longlog <= 640 ;
		end 
		
	if( row1shortlog == 0 ) 
		begin 
			 row1shortlog <= 640 ;
		end 	

	if( row1mediumlog == 0 ) 
		begin 
			 row1mediumlog <= 640 ;
		end 	

	if( row1twoshell == 0 ) 
		begin 
			 row1twoshell <= 640 ;
		end 
	if( row1threeshell == 0 ) 
		begin 
			 row1threeshell <= 640 ;
		end		
	
	end	


always_ff@(posedge clk_4Hz)
	begin
	
	// change timer bar
	row3gator <= row3gator - 1  ;
	row3longlog <= row3longlog - 1 ;
	row3shortlog <= row3shortlog - 1 ;
	row3mediumlog <= row3mediumlog - 1 ;
	row3twoshell <= row3twoshell - 1 ;
	row3threeshell <= row3threeshell - 1 ;
	
	if( row3gator == 0 ) 
		begin 
			 row3gator <= 640 ;
		end  	
   
	if( row3longlog == 0 ) 
		begin 
			 row3longlog <= 640 ;
		end 
		
	if( row3shortlog == 0 ) 
		begin 
			 row3shortlog <= 640 ;
		end 	

	if( row3mediumlog == 0 ) 
		begin 
			 row3mediumlog <= 640 ;
		end 	

	if( row3twoshell == 0 ) 
		begin 
			 row3twoshell <= 640 ;
		end 
	if( row3threeshell == 0 ) 
		begin 
			 row3threeshell <= 640 ;
		end		
	
	end	

always_ff@(posedge clk_4Hz)
	begin
	
	// change timer bar
	row2longlog <= row2longlog + 1 ;
	row2shortlog <= row2shortlog + 1 ;
	row2mediumlog <= row2mediumlog + 1 ;
	row2twoshell <= row2twoshell + 1 ;
	row2threeshell <= row2threeshell + 1 ;
		
   
	if( row2longlog == 640 ) 
		begin 
			 row2longlog <= 0 ;
		end 
		
	if( row2shortlog == 640 ) 
		begin 
			 row2shortlog <= 0 ;
		end 	

	if( row2mediumlog == 640 ) 
		begin 
			 row2mediumlog <= 0 ;
		end 	

	if( row2twoshell == 640 ) 
		begin 
			 row2twoshell <= 0 ;
		end 
	if( row2threeshell == 640 ) 
		begin 
			 row2threeshell <= 0 ;
		end		
	
	end	

always_ff@(posedge clk_4Hz)
	begin
	
	// change timer bar
	row4longlog <= row4longlog + 1 ;
	row4shortlog <= row4shortlog + 1 ;
	row4mediumlog <= row4mediumlog + 1 ;
	row4twoshell <= row4twoshell + 1 ;
	row4threeshell <= row4threeshell + 1 ;
		
   
	if( row4longlog == 640 ) 
		begin 
			 row4longlog <= 0 ;
		end 
		
	if( row4shortlog == 640 ) 
		begin 
			 row4shortlog <= 0 ;
		end 	

	if( row4mediumlog == 640 ) 
		begin 
			 row4mediumlog <= 0 ;
		end 	

	if( row4twoshell == 640 ) 
		begin 
			 row4twoshell <= 0 ;
		end 
	if( row4threeshell == 640 ) 
		begin 
			 row4threeshell <= 0 ;
		end		
	
	end	


endmodule

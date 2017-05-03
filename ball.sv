//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  03-03-2017                               --
//    Spring 2017 Distribution                                           --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input         Reset, 
                             frame_clk,  // The clock indicating a new frame (~60Hz)
               input [15:0]  keycode,
			   input  collision,
    		   input in_water ,
    		   input success , 
    		   input [2:0] shift ,
			   output [9:0]  BallX, BallY, BallS, // Ball coordinates and size
               output [3:0]  ten,
               output [3:0]  hundred,
               output [3:0]  thousand,
			   output [2:0]  lives
              );
    
    // W  8'h001A
    // A  8'h0004
    // S  8'h0016
    // D  8'h0007 
    // UP  8'h75
    // LEFT 8'h6b
    // RIGHT 8'h74
    // DOWN 8'h72  

    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
	 logic [15:0] tmp = 16'b0 ;
	 logic [15:0] tmp2 = 16'b0 ;
	 logic [2:0] hearts = 3'b011;
    //logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
	  
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=362;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=137;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=380;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=10;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=20;      // Step size on the Y axis
    parameter [9:0] Ball_Size=8;        // Ball size
    
    assign BallX = Ball_X_Pos;
    assign BallY = Ball_Y_Pos;
    assign BallS = Ball_Size;
    assign lives = hearts ;
	 
	 
	always_ff @ (posedge frame_clk or posedge Reset)
    begin 	
		if ( shift == 3'b001 ) 
			begin 
				Ball_X_Pos <= Ball_X_Pos - 1  ; 
				Ball_Y_Pos <= Ball_Y_Pos ; 
			end 
		else if ( shift == 3'b010 ) 
			begin 
				Ball_X_Pos <= Ball_X_Pos + 1  ; 
				Ball_Y_Pos <= Ball_Y_Pos ; 
			end 
		else 
			begin 
				Ball_X_Pos <= Ball_X_Pos ; 
				Ball_Y_Pos <= Ball_Y_Pos ; 
			end 

	end 
	 


    always_ff @ (posedge frame_clk or posedge Reset)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;
				hearts = 3'b011 ;
		  end
		  
		  else if (success)
		  begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;
			hearts = 3'b011 ;
		  end

		  else if (collision)
		  begin 
				hearts <= hearts - 1 ;
				Ball_X_Pos <= Ball_X_Center ; 
				Ball_Y_Pos <= Ball_Y_Center ; 		
		  end 

		  else if (in_water)
		  begin 
				hearts <= hearts - 1 ;
				Ball_X_Pos <= Ball_X_Center ; 
				Ball_Y_Pos <= Ball_Y_Center ; 		
		  end 

		  else if (hearts == 3'b000)
		  begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;
				hearts = 3'b011 ;
		  end
        /*
		  else if ( Ball_Y_Pos >= Ball_Y_Max )	
		  begin 
				Ball_X_Pos <= Ball_X_Center ; 
				Ball_Y_Pos <= Ball_Y_Center ; 
		 
		  end
		  */  
		  /*
		  else if ( Ball_Y_Pos <= Ball_Y_Min )	
		  begin 
					Ball_X_Pos <= Ball_X_Center ; 
					Ball_Y_Pos <= Ball_Y_Center ; 
		 
		  end 
		  */
		  
		  else if ( Ball_X_Pos >= Ball_X_Max )	
		  begin 
					Ball_X_Pos <= Ball_X_Center ; 
					Ball_Y_Pos <= Ball_Y_Center ; 
					hearts <= hearts - 1 ;
		  end  
		 
		  else if ( Ball_X_Pos <= Ball_X_Min )	
		  begin 
					Ball_X_Pos <= Ball_X_Center ; 
					Ball_Y_Pos <= Ball_Y_Center ; 
					hearts <= hearts - 1 ;
		  end 
		
		  else 
		  begin 
					case (keycode)
                 8'h001A : // W & UP    
							begin 	
									if (tmp != keycode)
										begin
											Ball_X_Pos <= Ball_X_Pos ; 
											Ball_Y_Pos <= Ball_Y_Pos - Ball_Y_Step ; 
											tmp <= keycode ;
										end 
								   else 	
										begin
											Ball_X_Pos <= Ball_X_Pos ; 
											Ball_Y_Pos <= Ball_Y_Pos ; 
										end 
							end						
                 8'h0004 : // A & LEFT 
                        begin 	
									if (tmp != keycode )
										begin
											Ball_X_Pos <= Ball_X_Pos - Ball_X_Step ; 
											Ball_Y_Pos <= Ball_Y_Pos  ;
											tmp <= keycode ;
										end 
								   else 	
										begin
											Ball_X_Pos <= Ball_X_Pos ; 
											Ball_Y_Pos <= Ball_Y_Pos ; 
										end 
								end		
						
                  8'h0016 : // S & DOWN
                        begin 
									if ( tmp != keycode)
										begin
											if ( Ball_Y_Pos +  Ball_Y_Step < Ball_Y_Max )
												begin 
													Ball_Y_Pos <= Ball_Y_Pos +  Ball_Y_Step ; 
												end 
											else 
												begin 
													Ball_Y_Pos <= Ball_Y_Pos ; 
												end 	
											Ball_X_Pos <= Ball_X_Pos  ; 
											tmp <= keycode ;
										end 
								   else 	
										begin
											Ball_X_Pos <= Ball_X_Pos ; 
											Ball_Y_Pos <= Ball_Y_Pos ; 
										end 
                        end 				
						8'h0007 : // D & RIGHT
								begin 
									if (tmp != keycode)
										begin
											Ball_X_Pos <= Ball_X_Pos + Ball_X_Step ; 
											Ball_Y_Pos <= Ball_Y_Pos ;
											tmp <= keycode ;
										end 
								   else 	
										begin
											Ball_X_Pos <= Ball_X_Pos ; 
											Ball_Y_Pos <= Ball_Y_Pos ; 
										end 
                        end 								
						// doesn't move when we change somehting here 
						8'h0000 :
                    begin  
								Ball_X_Pos <= Ball_X_Pos ;	
								Ball_Y_Pos <= Ball_Y_Pos ;	
								tmp <= keycode ;
						  end 	
						
						default : 
						  begin      
								Ball_X_Pos <= Ball_X_Pos ;	
								Ball_Y_Pos <= Ball_X_Pos ;	
								tmp <= keycode ;
						  end 	
					endcase
	     end 	
	
	
    end
 

	 // increment based on keycode  
    always_ff @ (posedge frame_clk or posedge Reset)
    begin
		  if (Reset)
        begin
				ten <= 4'b0 ; 
				hundred <= 4'b0;
				thousand <= 4'b0;
				tmp2 <= 16'b0;
        end
		  // up down left right
		  else if ( keycode == 8'h001A || keycode ==  8'h0004 || keycode == 8'h0016 || keycode == 8'h0007) 
		  begin 
				if (tmp2 != keycode) 
				begin 
					tmp2 = keycode ;
					if ( ten == 4'b1001)	
					begin	
						if ( hundred == 4'b1001)
							begin 
								 ten <= 4'b0;
								 hundred <= 4'b0;
								 thousand <= thousand + 1 ;
							end 
						else 
							begin 
								hundred <= hundred + 1 ;
								ten<= 4'b0 ;
							end 
					end 
					else 
					begin	
						ten <= ten + 1 ;		
					end 
				end 
				
				else 
				begin 
					ten <= ten ; 
					hundred <= hundred ;
					thousand <= thousand ;
					
				end
			end 	
     ///////////////////////////
		else 
			begin 
				tmp2 <= keycode ;  
				ten <= ten ; 
				hundred <= hundred ;
				thousand <= thousand ;
			end  

    end 
    
	 /*	 
	 always_comb
    begin
        // By default, keep motion unchanged     
        Ball_X_Motion_in = Ball_X_Motion;
        Ball_Y_Motion_in = Ball_Y_Motion;      
        //keydownflag = keydownflag ;
		  // Be careful when using comparators with "logic" datatype becuase compiler treats 
        //   both sides of the operator UNSIGNED numbers. (unless with further type casting)
        // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
        // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
                    
        if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
			   begin 		
						Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
						//Ball_Y_Motion_in = 10'b0 ;
						Ball_X_Motion_in = 10'b0 ;
						//keydownflag = keydownflag ;
					end 
        else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )  // Ball is at the top edge, BOUNCE!
            begin 
					Ball_Y_Motion_in = Ball_Y_Step;
					//Ball_Y_Motion_in = 10'b0 ;
					Ball_X_Motion_in = 10'b0 ;
					//keydownflag = keydownflag ;
				end 
        else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
            begin
					Ball_X_Motion_in = (~ (Ball_X_Step) + 1'b1);  
					//Ball_X_Motion_in = 10'b0 ;
					Ball_Y_Motion_in = 10'b0;
					//keydownflag = keydownflag ;
				end 
        else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the left edge, BOUNCE!
            begin 
					Ball_X_Motion_in = Ball_X_Step;
					//Ball_X_Motion_in = 10'b0 ;
					Ball_Y_Motion_in = 10'b0;
					//keydownflag = keydownflag ;
			end 
        else 
            begin 
					case (keycode)
                 8'h001A : // W & UP    
							begin 	
									if (keydownflag == 1'b0)
									begin 
									Ball_Y_Motion_in = (~ (Ball_Y_Step) + 1'b1); 
									Ball_X_Motion_in = 10'b0;
									keydownflag = 1'b1 ;
									end 
									else
									begin 
									Ball_Y_Motion_in = 10'b0; 
									Ball_X_Motion_in = 10'b0;
									keydownflag = 1'b1 ;
									end 		
                     end						
                 8'h0004 : // A & LEFT 
                        begin 
								   if (keydownflag == 1'b0)
									begin 
									Ball_X_Motion_in = (~ (Ball_X_Step) + 1'b1); 
									Ball_Y_Motion_in = 10'b0;
									keydownflag = 1'b1 ;
									end 
									else
									begin 
									Ball_Y_Motion_in = 10'b0; 
									Ball_X_Motion_in = 10'b0;
									keydownflag = 1'b1 ;
									end 			
								end		
						
                  8'h0016 : // S & DOWN
                        begin 
								  if (keydownflag == 1'b0)
									begin 
								   Ball_Y_Motion_in = Ball_Y_Step ;//
                           Ball_X_Motion_in = 10'b0; 
									keydownflag = 1'b1 ;
									end 
									else
									begin 
									Ball_Y_Motion_in = 10'b0; 
									Ball_X_Motion_in = 10'b0;
									keydownflag = 1'b1 ;
									end	
                        end 				
						8'h0007 : // D & RIGHT
								begin 
								  if (keydownflag == 1'b0)
									begin 
								   Ball_Y_Motion_in = 10'b0;//
                           Ball_X_Motion_in = Ball_X_Step;  
									keydownflag = 1'b1 ;
									end 
									else
									begin 
									Ball_Y_Motion_in = 10'b0; 
									Ball_X_Motion_in = 10'b0;
									keydownflag = 1'b1 ;
									end	
                        end 								
						// doesn't move when we change somehting here 
						8'h0000 :
                    begin  
								Ball_X_Motion_in = 10'b0;
								Ball_Y_Motion_in = 10'b0;
								keydownflag = 1'b0 ;
						  end 	
						
						default : 
						  begin      
						  Ball_Y_Motion_in = Ball_Y_Motion ;
                    Ball_X_Motion_in = Ball_X_Motion;
						  //keydownflag = keydownflag  ;
						  end 	
					endcase
				end 
        
		// Update the ball's position with its motion
        Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
        Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
	end */ 
endmodule

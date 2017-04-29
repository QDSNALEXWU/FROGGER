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
               input [15:0] keycode,
					output [9:0]  BallX, BallY, BallS // Ball coordinates and size
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
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
     
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=435;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis
    parameter [9:0] Ball_Size=4;        // Ball size
    
    assign BallX = Ball_X_Pos;
    assign BallY = Ball_Y_Pos;
    assign BallS = Ball_Size;
    
    always_ff @ (posedge frame_clk or posedge Reset)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= 10'd0;
        end
        else 
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
        end
    end
 

    always_comb
    begin
        // By default, keep motion unchanged     
        Ball_X_Motion_in = Ball_X_Motion;
        Ball_Y_Motion_in = Ball_Y_Motion;
              
        // Be careful when using comparators with "logic" datatype becuase compiler treats 
        //   both sides of the operator UNSIGNED numbers. (unless with further type casting)
        // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
        // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
                    
        if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
			   begin 		
					Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
					Ball_X_Motion_in = 10'b0 ;
				end 
        else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )  // Ball is at the top edge, BOUNCE!
            begin 
					Ball_Y_Motion_in = Ball_Y_Step;
					Ball_X_Motion_in = 10'b0 ;
				end 
        else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
            begin
					Ball_X_Motion_in = (~ (Ball_X_Step) + 1'b1);  
					Ball_Y_Motion_in = 10'b0;
            end 
        else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the left edge, BOUNCE!
            begin 
					Ball_X_Motion_in = Ball_X_Step;
					Ball_Y_Motion_in = 10'b0;
				end 
        else 
            begin 
					case (keycode)
						8'h001A : // W & UP    
						  begin 	
						  Ball_Y_Motion_in = (~ (Ball_Y_Step) + 1'b1); 
                    Ball_X_Motion_in = 10'b0;
						  end	
						8'h0004 : // A & LEFT 
                    begin 
						  Ball_X_Motion_in = (~ (Ball_X_Step) + 1'b1); 
                    Ball_Y_Motion_in = 10'b0;
						  end		
						8'h0016 : // S & DOWN
                    begin 
						  Ball_Y_Motion_in = Ball_Y_Step ;//
                    Ball_X_Motion_in = 10'b0; 
						  end 				
						8'h0007 : // D & RIGHT
                    begin  
						  Ball_X_Motion_in = Ball_X_Step;//
                    Ball_Y_Motion_in = 10'b0;
						  end 	
						default : 
						  begin      
						  //Ball_Y_Motion_in = Ball_Y_Motion ;
                    //Ball_X_Motion_in = Ball_X_Motion;
						  Ball_Y_Motion_in = 10'b0 ;
                    Ball_X_Motion_in = 10'b0 ;
						  end 	
					endcase
				end 
        
		  // Update the ball's position with its motion
        Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
        Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
	end 
endmodule

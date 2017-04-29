
module  color_mapper ( input [0:5] colorcode,
                       output logic [7:0]  VGA_R, VGA_G, VGA_B );


// try to match the color code with the actual RGB values 
//color code match: 
//# 0 transparent 
//# 1 black  (000000)
//# 2 green (27b212)
//# 3 red (d80222)
//# 4 light blue (5db1f0)
//# 5 yellow (F1FF0A)
//# 6 grey (b2b2b0)
//# 7 orange (f27a00)
//# 8 brown (663300)
//# 9 purple (8600b3)
//# 10 dark_blue (000066)
//# 11 white (ffffff) 

logic [7:0] Red, Green, Blue;
assign VGA_R = Red;
assign VGA_G = Green;
assign VGA_B = Blue;


always_comb
    begin:RGB_Display
        
        // #0 white  (fffff) - 000000 
        if ((colorcode==6'b000000))
            begin
					 Red=8'h00;
                Green=8'h00;
                Blue=8'h00;
				end
        
        // #1 black  (0000) - 000001
        else if ((colorcode==6'b000001))
            begin
                Red=8'h00;
                Green=8'h00;
                Blue=8'h00;
            end
        
        // #2 green (27b212) - 000010    
        else if ((colorcode==6'b000010))
            begin
                Red=8'h27;
                Green=8'hb2;
                Blue=8'h12;
            end

        // #3 red (d80222) - 000011    
        else if ((colorcode==6'b000011))
            begin
                Red=8'hd8;
                Green=8'h02;
                Blue=8'h22;
            end  
            
        // #4  light blue (5db1f0) - 000100   
        else if ((colorcode==6'b000100))
            begin
                Red=8'h5d;
                Green=8'hb1;
                Blue=8'hf0;
            end      

        //# 5 yellow (F1FF0A) - 000101    
        else if ((colorcode==6'b000101))
            begin
                Red=8'hF1;
                Green=8'hFF;
                Blue=8'h0A;
            end     

        //# 6 grey (b2b2b0) - 000110      
        else if ((colorcode==6'b000110))
            begin
                Red=8'hb2;
                Green=8'hb2;
                Blue=8'hb0;
            end 

        //# 7 orange (f27a00) - 000111     
        else if ((colorcode==6'b000111))
            begin
                Red=8'hf2;
                Green=8'h7a;
                Blue=8'h00;
            end      

        //# 8 brown (663300) - 001000    
        else if ((colorcode==6'b001000))
            begin
                Red=8'h66;
                Green=8'h33;
                Blue=8'h00;
            end 
		  
		  //# 9 purple (8600b3) - 001001    
        else if ((colorcode==6'b001001))
            begin
                Red=8'h86;
                Green=8'h00;
                Blue=8'hb3;
            end 
		  
		  //# 10 dark_blue (000066) - 001010
		  else if ((colorcode==6'b001010))
            begin
                Red=8'h00;
                Green=8'h00;
                Blue=8'h66;
            end  	
		  
		  //# 11 white (ffffff) - 001011
		  else if ((colorcode==6'b001011))
            begin
                Red=8'hff;
                Green=8'hff;
                Blue=8'hff;
            end  
		   
		  // default grey_color 
		  else 		
				begin
                Red=8'hb2;
                Green=8'hb2;
                Blue=8'hb0;
            end 

    end
endmodule


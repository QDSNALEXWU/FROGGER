module letterfont(input logic Clk,
                   // Y X L 
                   output logic [0:13][0:13][0:5] S_font,  
                   output logic [0:13][0:13][0:5] C_font,  
                   output logic [0:13][0:13][0:5] O_font,  
                   output logic [0:13][0:13][0:5] R_font,  
                   output logic [0:13][0:13][0:5] E_font,  
                   output logic [0:13][0:13][0:5] T_font,  
                   output logic [0:13][0:13][0:5] I_font,
                   output logic [0:13][0:13][0:5] M_font 
			);
						
always_comb
    begin

      //S (14 x 14)
      S_font <= '{
      '{ 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0 },
      '{ 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0 }, 
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{ 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 },
      '{ 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 },
      '{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },  
      '{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },  
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 }, 
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 }, 
      '{ 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 },
      '{ 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 }  
     };

      //C (14 x 14)
      C_font <='{
      '{ 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 },
      '{ 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 },
      '{ 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5 },  
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, 
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{ 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5 }, 
      '{ 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5 }, 
      '{ 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 },
      '{ 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 } 
      };

      // O (14 x 14)
      O_font <= '{     
      '{ 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 }, 
      '{ 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 }, 
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 }, 
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 }, 
      '{ 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 }
      };

      //R (14 X 14)
      R_font <= '{
      '{5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 },
      '{5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0 },
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },  
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },  
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5 }, 
      '{5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5 }, 
      '{5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0 }, 
      '{5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0 }, 
      '{5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5, 0, 0 },
      '{5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5, 0, 0 },
      '{5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5 }, 
      '{5, 5, 5, 5, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5 } 
      };

      //E (14 x 14)
      E_font <= '{
      '{5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, 
      '{5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, 
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0 }, 
      '{5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0 }, 
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
      '{5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, 
      '{5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }
      };

      //T (14 x 14)
      T_font <= '{
      '{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }
      };

      //I (14 x 14)
      I_font <= '{
      '{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0, 0 }, 
      '{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }
      };

      //M (14 x 14)
      M_font <= '{
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5 }, 
      '{ 5, 5, 5, 5, 5, 5, 0, 0, 5, 5, 5, 5, 5, 5 }, 
      '{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 5, 5, 0, 0, 5, 5, 5, 5 },  
      '{ 5, 5, 5, 5, 0, 0, 5, 5, 0, 0, 5, 5, 5, 5 },  
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 },
      '{ 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5 }
      };


    end 
endmodule 
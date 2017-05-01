
module MediumClock(  input Clk, 
                     output logic clk_4Hz
                 );

logic [27:0] counter;

always@( posedge Clk)
    begin
        counter <= counter + 1;
        if ( counter == 1_562_500)
            begin
                counter <= 0;
                clk_4Hz <= ~clk_4Hz;
            end
    end
endmodule
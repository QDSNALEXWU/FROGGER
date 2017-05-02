//https://electronics.stackexchange.com/questions/204540/verilog-slow-clock-geneator-module-1hz-from-50mhz
module SlowClock(  input Clk, 
                   output logic clk_1Hz
                 );

logic [27:0] counter;

always@(posedge Clk)
    begin
        counter <= counter + 1;
        if ( counter == 25_000_000)
            begin
                counter <= 0;
                clk_1Hz <= ~clk_1Hz;
            end
    end
endmodule
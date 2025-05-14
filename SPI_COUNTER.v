module SPI_COUNTER 
#(parameter count_tick_width = 4 , data_width = 8 )(
input wire    rst,
input wire    counter_rst,
input wire    spi_clk,
output reg   tick
);
reg [count_tick_width - 1:0] counter;

always @(posedge spi_clk , negedge rst )
  begin
    if( (!rst) || !counter_rst)
      begin 
      counter <= 'b0;
      tick    <= 1'b0;
    end
    else if (counter == (data_width-1))
          begin
            counter <= 'b0;
            tick    <= 1'b1;
          end
    else
          begin 
            counter <= counter + 1'b1;
            tick    <= 1'b0;
          end
 
      end
       
    
    
    //assign tick = (counter == data_width)? 1'b1 : 1'b0 ;
endmodule
   
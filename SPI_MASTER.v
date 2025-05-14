module SPI_MASTER
#(parameter data_width          = 8 ,
            dvsr                = 1000 ,
            counter_clk_width   = 10 ,
            count_tick_width    =  4 ,
            addr_width           = 2 ,
            slave_no            = 2**addr_width
              ) 
              (
input wire                        clk, rst,
input wire                        miso,
input wire                        valid_m,
input wire                        transmit,
input wire  [addr_width  - 1: 0]  addr ,
input wire  [data_width - 1: 0]   par_data_in_m,
output wire                       busy,
output wire [slave_no   - 1: 0]   ss,
output wire                       mosi,
output wire                       spi_clk,
output wire [data_width - 1: 0]   par_data_out_m


);
  
wire tick;
wire store_m;
wire clk_run;
wire counter_rst;

SPI_FSM 
#( .addr_width ( addr_width ) ) m0 (
.clk(clk),
.rst(rst),
.counter_rst(counter_rst),
.transmit(transmit),
.tick(tick),
.addr(addr),
.busy(busy),
.anded_ss(store_m),
.clk_run(clk_run),
.ss(ss)

);


SPI_COUNTER 
#( .count_tick_width ( count_tick_width ) ,
   .data_width( data_width ) ) m1 (
   .counter_rst(counter_rst),
.rst(rst),
.spi_clk(spi_clk),
.tick(tick)

);





SPI_CLK 
#( .dvsr ( dvsr ) ,
   .counter_clk_width( counter_clk_width ) )m2(
.clk(clk),
.rst(rst),
.clk_run(clk_run),
.spi_clk(spi_clk)

);



Shift_Reg_8bit
#(.data_width( data_width ) ) m3(
.spi_clk(spi_clk),
.rst(rst),
.valid(valid_m),
.ss_1bit(store_m),
.data_in(miso),
.par_data_in(par_data_in_m),
.data_out(mosi),
.par_data_out(par_data_out_m)
);

endmodule

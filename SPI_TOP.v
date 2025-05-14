module SPI_TOP 
#(parameter data_width          = 8 ,
            dvsr                = 1000 ,
            counter_clk_width   = 10 ,
            count_tick_width    =  4 ,
            addr_width          = 2 ,
            slave_no            = 2**addr_width
              ) (
input wire        clk, rst,
input wire        valid_m,
input wire        transmit,
input wire                          valid_s1,
input wire                          valid_s2,
input wire                          valid_s0,
input wire                          valid_s3,
input wire  [addr_width  - 1 : 0]   addr ,
input wire  [data_width - 1 : 0]    par_data_in_m,
input wire  [data_width - 1 : 0]    par_data_in_s0,
input wire  [data_width - 1 : 0]    par_data_in_s1,
input wire  [data_width - 1 : 0]    par_data_in_s2,
input wire  [data_width - 1 : 0]    par_data_in_s3,
output wire                         busy,
output wire [data_width - 1 : 0]    par_data_out_m,
output wire [data_width - 1 : 0]    par_data_out_s0,
output wire [data_width - 1 : 0]    par_data_out_s1,
output wire [data_width - 1 : 0]    par_data_out_s2,
output wire [data_width - 1 : 0]    par_data_out_s3
  
  
);

wire       miso;
wire       mosi;
wire       spi_clk;
wire [slave_no - 1 : 0]      ss;



SPI_MASTER 
#( .count_tick_width ( count_tick_width ) ,
   .data_width( data_width ) ,
   .addr_width ( addr_width ) ,
   .dvsr ( dvsr ) ,
   .counter_clk_width( counter_clk_width )
     ) m5(
.clk(clk),
.rst(rst),
.miso(miso),
.addr(addr),
.valid_m(valid_m),
.transmit(transmit),
.par_data_in_m(par_data_in_m),
.ss(ss),
.busy(busy),
.mosi(mosi),
.par_data_out_m(par_data_out_m),
.spi_clk(spi_clk)
);



SPI_SLAVE 
#(.data_width( data_width ) ,
  .addr_width ( addr_width ) )m6(
.spi_clk(spi_clk),
.rst(rst),
.valid_s0(valid_s0),
.valid_s1(valid_s1),
.valid_s2(valid_s2),
.valid_s3(valid_s3),
.ss(ss),
.mosi(mosi),
.par_data_in_s0(par_data_in_s0),
.par_data_in_s1(par_data_in_s1),
.par_data_in_s2(par_data_in_s2),
.par_data_in_s3(par_data_in_s3),
.miso(miso),
.par_data_out_s0(par_data_out_s0),
.par_data_out_s1(par_data_out_s1),
.par_data_out_s2(par_data_out_s2),
.par_data_out_s3(par_data_out_s3)


);


endmodule
module SPI_SLAVE
#(parameter data_width          = 8 ,
            addr_width          = 2 ,
            slave_no            = 2**addr_width )
             (
  input wire                          spi_clk, rst,
  input wire                          valid_s1,
  input wire                          valid_s2,
  input wire                          valid_s0,
  input wire                          valid_s3,
  input wire  [slave_no   - 1 : 0]    ss ,
  input wire                          mosi,
  input wire  [data_width - 1 : 0]    par_data_in_s0,
  input wire  [data_width - 1 : 0]    par_data_in_s1,
  input wire  [data_width - 1 : 0]    par_data_in_s2,
  input wire  [data_width - 1 : 0]    par_data_in_s3,
  output reg                          miso,
  output wire [data_width - 1 : 0]    par_data_out_s0,
  output wire [data_width - 1 : 0]    par_data_out_s1,
  output wire [data_width - 1 : 0]    par_data_out_s2,
  output wire [data_width - 1 : 0]    par_data_out_s3
  
  
);


wire miso0 , miso1 , miso2 , miso3 ;


Shift_Reg_8bit 
#(.data_width( data_width )  ) s0 
  (
.spi_clk(spi_clk),
.rst(rst),
.valid(valid_s0),
.ss_1bit(ss[0]),
.data_in(mosi),
.par_data_in(par_data_in_s0),
.data_out(miso0),
.par_data_out(par_data_out_s0)
);



Shift_Reg_8bit 
#(.data_width( data_width )  ) s1 
  (
.spi_clk(spi_clk),
.rst(rst),
.valid(valid_s1),
.ss_1bit(ss[1]),
.data_in(mosi),
.par_data_in(par_data_in_s1),
.data_out(miso1),
.par_data_out(par_data_out_s1)
);


Shift_Reg_8bit 
#(.data_width( data_width )  ) s2 
  (
.spi_clk(spi_clk),
.rst(rst),
.valid(valid_s2),
.ss_1bit(ss[2]),
.data_in(mosi),
.par_data_in(par_data_in_s2),
.data_out(miso2),
.par_data_out(par_data_out_s2)
);



Shift_Reg_8bit 
#(.data_width( data_width )  ) s3 
  (
.spi_clk(spi_clk),
.rst(rst),
.valid(valid_s3),
.ss_1bit(ss[3]),
.data_in(mosi),
.par_data_in(par_data_in_s3),
.data_out(miso3),
.par_data_out(par_data_out_s3)
);

always@*
  begin
    case (ss)
      'b1110: miso = miso1;
      'b1101: miso = miso1;
      'b1011: miso = miso2;
      'b0111: miso = miso3;
    endcase
    end


endmodule
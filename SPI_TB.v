`timescale 10ps/1ps
module SPI_TB();
parameter            CLK_PERIOD          = 10 ; 
parameter            data_width          = 8 ;
parameter            dvsr                = 10 ;
parameter            counter_clk_width   = 10 ;
parameter            count_tick_width    = 4 ;
parameter            addr_width          = 2 ;

reg        clk_tb;
reg        rst_tb;
reg        valid_s0_tb;
reg        valid_s1_tb;
reg        valid_s2_tb;
reg        valid_s3_tb;
reg        valid_m_tb;
reg        transmit_tb;
reg  [addr_width - 1 : 0]    addr_tb ;
reg  [data_width - 1 : 0]    par_data_in_m_tb;
reg  [data_width - 1 : 0]    par_data_in_s0_tb;
reg  [data_width - 1 : 0]    par_data_in_s1_tb;
reg  [data_width - 1 : 0]    par_data_in_s2_tb;
reg  [data_width - 1 : 0]    par_data_in_s3_tb;
wire                         busy_tb;
wire [data_width - 1 : 0]    par_data_out_m_tb;
wire [data_width - 1 : 0]    par_data_out_s0_tb;
wire [data_width - 1 : 0]    par_data_out_s1_tb;
wire [data_width - 1 : 0]    par_data_out_s2_tb;
wire [data_width - 1 : 0]    par_data_out_s3_tb;
  
  SPI_TOP
  #( .data_width( data_width ) ,
     .addr_width ( addr_width ) ,
     .count_tick_width ( count_tick_width ) ,
     .dvsr ( dvsr ) ,
     .counter_clk_width( counter_clk_width )) DUT(
     
.clk(clk_tb),
.rst(rst_tb),
.valid_s0(valid_s0_tb),
.valid_s1(valid_s1_tb),
.valid_s2(valid_s2_tb),
.valid_s3(valid_s3_tb),
.valid_m(valid_m_tb),
.transmit(transmit_tb),
.addr(addr_tb),
.par_data_in_m(par_data_in_m_tb),
.busy(busy_tb),
.par_data_out_m(par_data_out_m_tb),
.par_data_in_s0(par_data_in_s0_tb),
.par_data_in_s1(par_data_in_s1_tb),
.par_data_in_s2(par_data_in_s2_tb),
.par_data_in_s3(par_data_in_s3_tb),
.par_data_out_s0(par_data_out_s0_tb),
.par_data_out_s1(par_data_out_s1_tb),
.par_data_out_s2(par_data_out_s2_tb),
.par_data_out_s3(par_data_out_s3_tb)

);


always #(CLK_PERIOD/2) clk_tb =~clk_tb;

initial 
  begin
    clk_tb=1'b0;
    rst_tb = 1'b1;
    #(CLK_PERIOD/2)
    rst_tb = 1'b0;
    #(CLK_PERIOD/2)
    rst_tb = 1'b1;
    #(CLK_PERIOD)
    par_data_in_m_tb  = 'b11111111;
    par_data_in_s0_tb = 'b00;
    par_data_in_s1_tb = 'b01;
    par_data_in_s2_tb = 'b10;
    par_data_in_s3_tb = 'b11;
    valid_m_tb        = 1'b1;
    valid_s0_tb       = 1'b1;
    valid_s1_tb       = 1'b1;
    valid_s2_tb       = 1'b1;
    valid_s3_tb       = 1'b1;
    #(CLK_PERIOD)
    valid_m_tb        = 1'b0;
    valid_s0_tb       = 1'b0;
    valid_s1_tb       = 1'b0;
    valid_s2_tb       = 1'b0;
    valid_s3_tb       = 1'b0;
    #(CLK_PERIOD)
    transmit_tb = 1'b1; 
    addr_tb =2'b00;
    #(90*CLK_PERIOD)
    transmit_tb = 1'b1; 
    addr_tb =2'b01;
    #(90*CLK_PERIOD)
    transmit_tb = 1'b1; 
    addr_tb =2'b10;
    #(90*CLK_PERIOD)
    transmit_tb = 1'b1; 
    addr_tb =2'b11;
    #(90*CLK_PERIOD)
    transmit_tb = 1'b1;
    
  end

endmodule
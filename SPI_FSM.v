/*
CLK = CLOCK
RST = ASYNCROUNS RESET
valid_M = DATA IN OF MASTER IS valid  
TRANSMIT = STSRTING OF TRANSMITING
TICK = COUNTER DONE
BUSY = IS NOW TRANSMITING
STORE = ENABLE STORING
CLK RUN = ENBLE OF SPI CLK
SS = SLAVE SELECT

*/
module SPI_FSM 
#(parameter addr_width    = 2 ,
            slave_no      = 2**addr_width )(
input wire                     clk, rst ,
input wire                     transmit ,
input wire                     tick ,
input wire [addr_width - 1: 0] addr ,
output wire                    anded_ss , 
output reg                     busy ,
output reg                     counter_rst ,
output reg                     clk_run , 
output reg [slave_no - 1 :0]   ss
);

reg [2:0]n_state,c_state;

localparam       idle        = 3'b00,
                 slave0 = 3'b01,
                 slave1 = 3'b10,
                 slave2 = 3'b011,
                 slave3 = 3'b100,
                 ending =3'b101;
                 
always @(posedge clk ,negedge rst)
  begin
    if(!rst)
      c_state <= idle;
    else
      c_state <= n_state;
  end                  
  
  always @*
    begin
      
      n_state    = idle;
      clk_run    = 1'b0 ;
      ss         = 2**slave_no - 1 ;
      busy       = 1'b0 ;
      counter_rst = 1'b0;     
      case (c_state)
          idle:
            begin
              clk_run  = 1'b0 ;
              ss       = 2**slave_no - 1 ;
              busy     = 1'b0 ;
              counter_rst= 1'b0;
              if(transmit && addr == 'b0)
                n_state = slave0;
              else if(transmit && addr == 'b01)
                n_state = slave1;
              else if(transmit && addr == 'b10)
                n_state = slave2;
              else if(transmit && addr == 'b11)
                n_state = slave3;
              else
                n_state = idle  ;
            end

          slave0:
            begin
              clk_run  = 1'b1 ;
              busy     = 1'b1 ;
              ss       =  'b1110 ;
              counter_rst= 1'b1;
              if(tick)
                n_state = ending  ;
              else 
                n_state = slave0 ;
            end
            slave1:
            begin
              clk_run  = 1'b1 ;
              busy     = 1'b1 ;
              ss       =  'b1101 ;
              counter_rst= 1'b1;
              if(tick)
                n_state = ending  ;
              else 
                n_state = slave1 ;
            end
            slave2:
            begin
              clk_run  = 1'b1 ;
              busy     = 1'b1 ;
              ss       =  'b1011 ;
              counter_rst= 1'b1;
              if(tick)
                n_state = ending  ;
              else 
                n_state = slave2 ;
            end
            slave3:
            begin
              clk_run  = 1'b1 ;
              busy     = 1'b1 ;
              ss       =  'b0111 ;
              counter_rst= 1'b1;
              if(tick)
                n_state = ending  ;
              else 
                n_state = slave3 ;
            end
          ending:
            begin
              clk_run   = 1'b1 ;
              busy      = 1'b1 ;
              counter_rst= 1'b0;
              ss        = 2**slave_no - 1 ;
              
              if(!tick && transmit && addr == 'b0)
                n_state = slave0;
              else if(!tick && transmit && addr == 'b01)
                n_state = slave1;
              else if(!tick && transmit && addr == 'b10)
                n_state = slave2;
              else if(!tick && transmit && addr == 'b11)
                n_state = slave3;
              else if(!tick)
                n_state = idle  ;
              else 
                n_state = ending ;
            end                
          default :
            begin  
              clk_run  = 1'b0 ;
              ss       = 2**slave_no - 1 ;
              busy     = 1'b0 ;
              counter_rst= 1'b0;
              n_state = idle;
            end
        
        endcase
      end
      
 assign anded_ss = (&ss)  ;
 /*
 reg [count_tick_width - 1:0] counter;

always @(posedge spi_clk , negedge rst)
  begin
    if( (!rst) || rst_counter )
      counter <= 'b0;
    else
      counter <= counter + 1'b1;
    end
    
    assign tick = (counter == data_width)? 1'b1 : 1'b0 ;
 */
endmodule  
module ClK_DIV
#(parameter dvsr = 1024 , counter_clk_width = 10)
(
input wire      clk, rst,
input wire      CLK_EN,
output reg      new_clk

);

reg [counter_clk_width - 1:0] count;
 always @(posedge clk ,negedge rst)
  begin 
    
    if(!rst)
      begin
        new_clk <= 1'b1;
        count   <=  'b0;
      end
    else if (CLK_EN)
      begin
        
       count <= count + 1;
       
       if(count < (dvsr/2) )
         begin
           new_clk <= 1'b0;
         end 
       else if (count < dvsr )
         begin
           new_clk <= 1'b1;
         end
       else
         begin
           count <= 'b0;
         end
      end
    
    else if( !CLK_EN )
      begin
        new_clk <= 1'b1;
        count   <=  'b0;
      end
  end
    
endmodule  
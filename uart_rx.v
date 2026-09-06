
module uart_rx(
       input clk, reset, baud_tick, rx,
       output reg data_valid,busy,
       output reg [7:0]received_data
    );
reg [7:0] received_data_reg; // builds the byte being received
reg [3:0] bit_count; 

always@ (posedge clk)
begin 
  if(reset)
   begin 
     bit_count <= 4'b0;
     busy <= 1'b0;
     received_data_reg <= 8'b0;
     received_data <= 8'b0;
     data_valid <= 1'b0;
   end
   
   else if(!busy && rx == 0)
     begin
       busy <= 1'b1;
       bit_count <= 4'b0;
       received_data_reg <= 8'b0;
     end
   
   else if(busy && baud_tick)
     begin
        if(bit_count==0)
          bit_count <= bit_count + 1; 
          
        else if(bit_count >= 1 && bit_count < 9)
          begin 
              received_data_reg[bit_count-1] <= rx;
              bit_count <= bit_count + 1;
          end
          
        else if(bit_count == 9)
           begin
                received_data <= received_data_reg;
                data_valid <= 1'b1;
                busy <= 1'b0;
                bit_count <= 4'b0;
            end
     end
end
  
endmodule

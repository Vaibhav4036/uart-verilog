
module uart_tx(
      input clk, reset, baud_tick, tx_start,
      input [7:0]data,
      output reg tx, busy
    );
reg [7:0] stored_data;
reg [3:0] bit_count;

always@ (posedge clk)
begin 
 if(reset)
   begin 
    stored_data <= 8'b0; // clear stored_data
    bit_count <= 4'b0; // clear bit_count
    busy <= 1'b0;
   end
  
  else if(!busy && tx_start)
    begin 
      stored_data <= data; // store data
      bit_count <= 4'b0; // start from START bit (bit_count = 0)
      busy <= 1'b1;
    end
  
  else if(busy && baud_tick)
    begin
      if(bit_count <9)
       bit_count <= bit_count + 1;
      else
       begin 
          bit_count <= 4'b0;
          busy <= 1'b0;
        end
    end
end

always@ (*)
begin
 if(busy == 1'b0)
  tx = 1; // IDLE
  
 else if(bit_count == 0)
   tx = 0; // START 
   
 else if(bit_count <9)
   tx = stored_data[bit_count-1]; // DATA
   
 else if(bit_count ==9)
   tx = 1;  // STOP
end
endmodule

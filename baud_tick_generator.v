
module baud_tick_generator(
       input clk,reset,
       output reg baud_tick
    );
reg [12:0] count;
always@ (posedge clk)
begin 
 if(reset)
   count <= 0;
 else if(count==5207)
    count <= 0;
 else
    count <= count + 1;
end
always@ (*)
begin 
 if(count==5207)
  baud_tick = 1;
 else
  baud_tick = 0;
end
endmodule

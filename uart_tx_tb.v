
module uart_tx_tb;
reg clk,reset,tx_start;
reg [7:0] data;
wire tx ,busy,baud_tick;

uart_tx uut (.clk(clk),.reset(reset),.baud_tick(baud_tick),.tx_start(tx_start),.data(data),.tx(tx),.busy(busy));
baud_tick_generator baud_gen (.clk(clk),.reset(reset),.baud_tick(baud_tick));

initial 
begin 
$monitor($time,"clk=%b,reset=%b,baud_tick=%b,tx_start=%b,data=%b,tx=%b,busy=%b,stored_data=%b,bit_count=%b",
       clk,reset,baud_tick,tx_start,data,tx,busy,uut.stored_data,uut.bit_count);
clk = 0;
forever #10 clk = ~clk;
end

initial 
begin 
     reset = 1; // Put UART Tx into known IDLE State
     tx_start = 0;  // Don't request transmission yet
     data = 0; // No data loaded yet

     #40 reset = 0; 

     data = 8'b01000001;
     #20 tx_start = 1;
     #20 tx_start = 0;
     #1200000; 
     $finish;
end
endmodule


module uart_rx_tb;
reg clk, reset, rx;
wire [7:0]received_data; wire data_valid, busy, baud_tick;
uart_rx uut (
              .clk(clk),
              .reset(reset),
              .baud_tick(baud_tick),
              .rx(rx),
              .data_valid(data_valid),
              .busy(busy),
              .received_data(received_data)
             );

baud_tick_generator baud_gen (
                                .clk(clk),
                                .reset(reset),
                                .baud_tick(baud_tick)
                              );
   
initial 
begin 
$monitor($time,"clk=%b,reset=%b,baud_tick=%b,rx=%b,data_valid=%b,busy=%b,received_data=%b",
             clk,reset,baud_tick,rx,data_valid,busy,received_data);
clk = 0;
forever #10 clk = ~clk;   
end

initial
begin 
 reset = 1; rx = 1;
 #40 reset = 0;
 #20 rx = 0;
 
 #104160 rx = 1;  // D0
 #104160 rx = 0;  // D1
 #104160 rx = 0;  // D2
 #104160 rx = 0;  // D3
 #104160 rx = 0;  // D4
 #104160 rx = 0;  // D5
 #104160 rx = 1;  // D6
 #104160 rx = 0;  // D7
 #104160 rx = 1;  // STOP

 #104160;
 $finish;
end             
endmodule


module uart_loopback_tb;
reg clk, reset, tx_start;
reg [7:0] data;
wire tx, baud_tick, data_valid, busy;
wire [7:0] received_data;

// Baud Tick Generator 
baud_tick_generator baud_gen (
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick)
);

// UART Transmitter
uart_tx transmitter (
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick),
    .tx_start(tx_start),
    .data(data),
    .tx(tx),
    .busy()
);

// UART Receiver
uart_rx receiver (
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick),
    .rx(tx),                  // TX output connected to RX input
    .data_valid(data_valid),
    .busy(busy),
    .received_data(received_data)
);

initial
begin
    $monitor($time,"clk=%b reset=%b tx_start=%b data=%b tx=%b baud_tick=%b received_data=%b data_valid=%b busy=%b",
             clk,reset,tx_start,data,tx,baud_tick,received_data,data_valid,busy);
    clk = 0;
    forever #10 clk = ~clk;
end

initial
begin
    reset = 1;
    tx_start = 0;
    data = 8'b00000000;

    #40 reset = 0;
    
    #20;
    data = 8'b01000001;
    tx_start = 1;

    #20 tx_start = 0;
    
    #1200000;
    $finish;
end
endmodule

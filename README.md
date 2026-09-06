# UART Verilog

A Verilog implementation of a UART (Universal Asynchronous Receiver/Transmitter) communication system, including a transmitter, receiver, baud rate generator, and loopback verification testbench.

## 📋 Overview

This project implements a fully functional UART core in Verilog, capable of serial data transmission and reception at a configurable baud rate. It includes individual testbenches for each module as well as a loopback testbench that verifies end-to-end transmit-receive functionality.

## ✨ Features

- Configurable baud rate via a dedicated baud tick generator
- Standard UART frame format: 1 start bit, 8 data bits, 1 stop bit (no parity)
- Independent, reusable transmitter (`uart_tx`) and receiver (`uart_rx`) modules
- Self-checking testbenches for transmitter, receiver, and full loopback
- Simulation waveform included for quick reference

## 📁 Repository Structure

| File | Description |
|---|---|
| `baud_tick_generator.v` | Generates baud rate tick pulses from the system clock |
| `uart_tx.v` | UART transmitter module |
| `uart_tx_tb.v` | Testbench for the transmitter |
| `uart_rx.v` | UART receiver module |
| `uart_rx_tb.v` | Testbench for the receiver |
| `uart_loopback_tb.v` | Loopback testbench (TX → RX) for end-to-end verification |
| `waveform.jpeg` | Simulation waveform showing UART data transfer |
| `README.md` | Project documentation |

## 🧩 Module Details

### Baud Tick Generator (`baud_tick_generator.v`)
Generates a periodic tick signal at the desired baud rate, derived from the system clock. This tick drives the sampling/shifting logic in both the transmitter and receiver.

### UART Transmitter (`uart_tx.v`)
Serializes an 8-bit parallel data input into a UART frame (start bit, 8 data bits, stop bit) and transmits it bit-by-bit on the `tx` line at the configured baud rate.

### UART Receiver (`uart_rx.v`)
Samples the incoming serial `rx` line, detects the start bit, deserializes the 8 data bits, and reconstructs the original byte along with a "data valid" indicator.

### Loopback Testbench (`uart_loopback_tb.v`)
Connects the transmitter's output directly to the receiver's input to verify that data sent by `uart_tx` is correctly received and decoded by `uart_rx`.

## 🖥️ Simulation

Simulation waveforms are included (`waveform.jpeg`) showing the transmitted and received data lines, illustrating correct byte framing and successful loopback transfer.

To run the simulation yourself (example using Icarus Verilog):

```bash
iverilog -o uart_sim uart_tx.v uart_rx.v baud_tick_generator.v uart_loopback_tb.v
vvp uart_sim
gtkwave dump.vcd
```

*(Adjust file names and waveform dump command to match your testbench setup.)*

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Vaibhav4036/uart-verilog.git
   cd uart-verilog
   ```
2. Simulate individual modules using their respective testbenches (`uart_tx_tb.v`, `uart_rx_tb.v`).
3. Run `uart_loopback_tb.v` to verify complete transmit-receive functionality.

## 🛠️ Tools Used

- Verilog HDL
- Icarus Verilog / ModelSim (or your simulator of choice)
- GTKWave (for waveform viewing)

## 📌 Future Improvements

- Add parity bit support
- Add configurable data/stop bit widths
- Add FIFO buffering for TX/RX
- Add UART controller with register interface (APB/AXI-lite)

## 📄 License

This project is open-source. Feel free to use and modify it for learning or development purposes.

## 👤 Author

**Vaibhav Tiwari**

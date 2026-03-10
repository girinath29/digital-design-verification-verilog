# Day 4 – Synchronous FIFO Design (Verilog)

## Overview

This project implements a **Synchronous FIFO (First-In First-Out) memory buffer** using Verilog.  
The design demonstrates how data can be written and read sequentially while maintaining the correct order.

The FIFO uses a **single clock domain**, making it suitable for many digital systems such as buffers, communication interfaces, and data pipelines.

This project is part of my **VLSI RTL Design and Verification practice series**, where I build and verify digital design blocks using Verilog.

---

## Design Features

- Parameterized data width
- Parameterized FIFO depth
- Circular buffer memory structure
- Separate write pointer and read pointer
- Full flag detection
- Empty flag detection
- Fully synchronous operation
- Implemented using pure Verilog

---

## FIFO Operation

### Write Operation

Data is written into FIFO when:
wr_en = 1 and FIFO is not full

The data is stored at the memory location pointed to by the **write pointer**, which then increments.

---

### Read Operation

Data is read from FIFO when:
rd_en = 1 and FIFO is not empty

---
The data is taken from the memory location pointed to by the **read pointer**, which then increments.

---

## Status Flags

| Signal | Description |
|------|-------------|
| full | Indicates FIFO cannot accept more data |
| empty | Indicates FIFO contains no data |

---

## Project Structure

#Overview

This project implements a Synchronous FIFO (First-In First-Out) memory buffer using Verilog.
The design demonstrates how data can be written and read sequentially while maintaining the correct order.

The FIFO uses a single clock domain, making it suitable for many digital systems such as buffers, communication interfaces, and data pipelines.

This project is part of my VLSI RTL Design and Verification practice series, where I build and verify digital design blocks using Verilog.


---

## Verification Methodology

The FIFO design is verified using a **self-checking Verilog testbench**.

Verification includes:

- Directed write operations
- Directed read operations
- Randomized data generation
- Reference FIFO model inside the testbench
- Automatic comparison of expected vs actual outputs
- Error reporting using `$display`

At the end of simulation the testbench reports:
TEST PASSED
or
TEST FAILED

## Running the Simulation

Compile and run the simulation using:

```bash
iverilog rtl/*.v tb/tb_fifo.v -o sim.out
vvp sim.out
gtkwave waves_day4.vcd

```


---
##Waveform Result

-The waveform verifies:

-Write operations

-Read operations

-Correct data order

FIFO full and empty conditions
![FIFO Waveform](FIFO_Waveform.png)
---

---
##Key Learning Outcomes

This project demonstrates:

-FIFO memory architecture

-Pointer-based buffer management

-Hardware control logic

-Writing a self-checking testbench

-Verification through waveform analysis

These concepts are widely used in VLSI RTL Design and Design Verification roles.


---


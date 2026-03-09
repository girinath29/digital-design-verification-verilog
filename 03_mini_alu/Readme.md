# Day 3 – Mini ALU (Verilog)

## Overview
This project implements a simple combinational ALU using pure Verilog.  
The design supports arithmetic, logical, and comparison operations.

## Operations
- ADD
- SUB
- AND
- OR
- XOR
- PASS A
- PASS B
- COMPARE (A > B)

## Verification
- Self-checking Verilog testbench
- Directed tests for each operation
- Random tests for robustness
- Waveforms generated using GTKWave

## Run Simulation
iverilog rtl/*.v tb/tb_alu.v -o sim.out
vvp sim.out
gtkwave waves_day3.vcd

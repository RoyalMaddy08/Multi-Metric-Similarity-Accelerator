# BRAM-Based-KNN-Accelerator

## Features
- BRAM-based dataset storage
- 4D Euclidean distance computation
- Pipelined minimum finder
- Fully synthesizable Verilog
- Artix-7 compatible

## Results
- WNS: +3.628 ns
- TNS: 0 ns
- Failing Endpoints: 0

## Dataset
16 training vectors stored in BRAM.

## Simulation
Run:
tb_knn_bram_top.v

## FPGA
Target Device:
xc7a100tcsg324-1

## Nearest Neighbor Search Result

Query Vector:
(10,10,10,11)

Nearest Index:
13

Minimum Distance:
1


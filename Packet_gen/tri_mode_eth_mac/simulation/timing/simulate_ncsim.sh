#!/bin/sh
mkdir work

echo "Compiling Tri-Mode Ethernet MAC Core Simulation Models"
ncvlog -work work $XILINX/verilog/src/glbl.v
ncvlog -work work ../../implement/results/routed.v
ncvlog -work work ../demo_tb.v

echo "Compiling SDF file"
ncsdfc ../../implement/results/routed.sdf -output ./routed.sdf.X

echo "Generating SDF command file"
echo 'COMPILED_SDF_FILE = "routed.sdf.X",' > sdf.cmd
echo 'SCOPE = testbench.dut,' >> sdf.cmd
echo 'MTM_CONTROL = "MAXIMUM";' >> sdf.cmd

echo "Elaborating design"
ncelab -NOWARN BNDMEM -NOWARN NTCWID -NOWARN NTCNNC -NOWARN CUVWSP -NOWARN NCCDELW -access +r -sdf_cmd_file sdf.cmd work.testbench glbl

ncsim -gui -input @"simvision -input wave_ncsim.sv" work.testbench


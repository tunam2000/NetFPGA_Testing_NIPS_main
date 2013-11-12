#!/bin/sh
mkdir work

echo "Compiling Tri-Mode Ethernet MAC Core Simulation Models"
ncvlog -work work $XILINX/verilog/src/glbl.v
ncvlog -work work ../../../tri_mode_eth_mac.v
ncvlog -work work ../../example_design/fifo/tx_client_fifo.v
ncvlog -work work ../../example_design/fifo/rx_client_fifo.v
ncvlog -work work ../../example_design/fifo/ten_100_1g_eth_fifo.v
ncvlog -work work ../../example_design/address_swap_module.v
ncvlog -work work ../../example_design/johnson_cntr.v
ncvlog -work work ../../example_design/physical/rgmii_v2_0_if.v
ncvlog -work work ../../example_design/tx_clk_gen.v
ncvlog -work work ../../example_design/rx_clk_gen.v
ncvlog -work work ../../example_design/clk_gen.v
ncvlog -work work ../../example_design/tri_mode_eth_mac_block.v
ncvlog -work work ../../example_design/tri_mode_eth_mac_locallink.v
ncvlog -work work ../../example_design/tri_mode_eth_mac_example_design.v
ncvlog -work work ../demo_tb.v

ncelab -NOWARN NTCNNC -NOWARN CUVWSP -NOWARN NCCDELW -access +r work.testbench glbl

ncsim -gui -input @"simvision -input wave_ncsim.sv" work.testbench

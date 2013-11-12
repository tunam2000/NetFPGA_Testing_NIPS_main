vlib work
vmap work work
vlog -work work \$XILINX/verilog/src/glbl.v
vlog -work work ../../../tri_mode_eth_mac.v
vlog -work work ../../example_design/fifo/tx_client_fifo.v
vlog -work work ../../example_design/fifo/rx_client_fifo.v
vlog -work work ../../example_design/fifo/ten_100_1g_eth_fifo.v
vlog -work work ../../example_design/address_swap_module.v
vlog -work work ../../example_design/johnson_cntr.v
vlog -work work ../../example_design/physical/rgmii_v2_0_if.v
vlog -work work ../../example_design/tx_clk_gen.v
vlog -work work ../../example_design/rx_clk_gen.v
vlog -work work ../../example_design/clk_gen.v
vlog -work work ../../example_design/tri_mode_eth_mac_block.v
vlog -work work ../../example_design/tri_mode_eth_mac_locallink.v
vlog -work work ../../example_design/tri_mode_eth_mac_example_design.v
vlog -work work ../demo_tb.v
vsim -L unisims_ver -t ps work.testbench work.glbl
do wave_mti.do
run -all

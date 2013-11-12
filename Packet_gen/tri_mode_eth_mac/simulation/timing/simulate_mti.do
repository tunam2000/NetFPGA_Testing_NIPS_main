vlib work
vmap work work
vlog -work work \$XILINX/verilog/src/glbl.v
vlog -work work ../../implement/results/routed.v
vlog -work work ../demo_tb.v
vsim -L simprims_ver +no_tchk_msg +transport_int_delays +transport_path_delays -t ps -sdfmax /dut=../../implement/results/routed.sdf work.testbench work.glbl
do wave_mti.do
run -all

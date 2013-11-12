view structure
view signals
view wave
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {System Signals}
add wave -noupdate -format Logic /testbench/reset
add wave -noupdate -format Logic /testbench/gtx_clk
add wave -noupdate -divider {Tx Client Interface}
add wave -noupdate -format Logic /testbench/tx_clk
add wave -noupdate -format Logic /testbench/dut/\\trimac_locallink/tx_enable_int\\
add wave -noupdate -format Logic /testbench/dut/\\trimac_locallink/tx_ack\\
add wave -noupdate -format Logic /testbench/dut/\\trimac_locallink/tx_data_valid\\
add wave -noupdate -format Logic /testbench/dut/\\trimac_locallink/tx_data\\
add wave -noupdate -format Literal -hex /testbench/tx_ifg_delay
add wave -noupdate -divider {Tx Statistics Vector}
add wave -noupdate -format Literal -binary /testbench/tx_statistics_vector
add wave -noupdate -format Logic /testbench/tx_statistics_valid
add wave -noupdate -divider {Rx Client Interface}
add wave -noupdate -format Logic /testbench/rx_clk
add wave -noupdate -format Logic /testbench/dut/\\trimac_locallink/rx_enable_int\\
add wave -noupdate -format Logic /testbench/dut/\\trimac_locallink/rx_data_valid\\
add wave -noupdate -format Literal -hex /testbench/dut/\\trimac_locallink/rx_data\\
add wave -noupdate -format Logic /testbench/dut/\\trimac_locallink/rx_good_frame\\
add wave -noupdate -format Logic /testbench/dut/\\trimac_locallink/rx_bad_frame\\
add wave -noupdate -divider {Rx Statistics Vector}
add wave -noupdate -format Literal -binary /testbench/rx_statistics_vector
add wave -noupdate -format Logic /testbench/rx_statistics_valid
add wave -noupdate -divider {Flow Control}
add wave -noupdate -format Literal -hex /testbench/pause_val
add wave -noupdate -format Logic /testbench/pause_req
add wave -noupdate -divider {Tx RGMII Interface}
add wave -noupdate -format logic /testbench/rgmii_txc
add wave -noupdate -format logic /testbench/rgmii_tx_ctl
add wave -noupdate -format logic -hex /testbench/rgmii_txd
add wave -noupdate -divider {Rx RGMII Interface}
add wave -noupdate -format logic /testbench/rgmii_rxc
add wave -noupdate -format logic /testbench/rgmii_rx_ctl
add wave -noupdate -format logic -hex /testbench/rgmii_rxd
add wave -noupdate -divider {Management Interface}
add wave -noupdate -format Literal -hex /testbench/configuration_vector
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
WaveRestoreZoom {0 ps} {4310754 ps}

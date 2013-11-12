# SimVision Command Script

#
# groups
#

if {[catch {group new -name {System Signals} -overlay 0}] != ""} {
    group using {System Signals}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :testbench.reset \
    :testbench.gtx_clk

if {[catch {group new -name {TX Client Interface} -overlay 0}] != ""} {
    group using {TX Client Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :testbench.tx_clk \
    :testbench.dut.trimac_locallink.tx_enable_int \
    :testbench.dut.trimac_locallink.tx_ack \
    :testbench.dut.trimac_locallink.tx_data_valid \
    :testbench.dut.trimac_locallink.tx_data \
    :testbench.tx_ifg_delay

if {[catch {group new -name {TX Statistics Vector} -overlay 0}] != ""} {
    group using {TX Statistics Vector}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :testbench.tx_statistics_vector \
    :testbench.tx_statistics_valid

if {[catch {group new -name {RX Client Interface} -overlay 0}] != ""} {
    group using {RX Client Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :testbench.rx_clk \
    
    :testbench.dut.trimac_locallink.rx_enable_int \
    :testbench.dut.trimac_locallink.rx_data_valid \
    :testbench.dut.trimac_locallink.rx_data \
    :testbench.dut.trimac_locallink.rx_good_frame \
    :testbench.dut.trimac_locallink.rx_bad_frame

if {[catch {group new -name {RX Statistics Vector} -overlay 0}] != ""} {
    group using {RX Statistics Vector}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :testbench.rx_statistics_vector \
    :testbench.rx_statistics_valid


if {[catch {group new -name {Flow Control} -overlay 0}] != ""} {
    group using {Flow Control}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :testbench.pause_val \
    :testbench.pause_req

if {[catch {group new -name {Rx FIFO Local Link Interface} -overlay 0}] != ""} {
    group using {Rx FIFO Local Link Interface}

    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    testbench.dut.trimac_locallink.rx_ll_sof_out_n \
    testbench.dut.trimac_locallink.rx_ll_eof_out_n \
    testbench.dut.trimac_locallink.rx_ll_src_rdy_out_n \
    testbench.dut.trimac_locallink.rx_ll_dst_rdy_in_n \
    testbench.dut.trimac_locallink.rx_ll_data_out

if {[catch {group new -name {Tx FIFO Local Link Interface} -overlay 0}] != ""} {
    group using {Tx FIFO Local Link Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    testbench.dut.trimac_locallink.tx_ll_sof_in_n \
    testbench.dut.trimac_locallink.tx_ll_eof_in_n \
    testbench.dut.trimac_locallink.tx_ll_src_rdy_in_n \
    testbench.dut.trimac_locallink.tx_ll_dst_rdy_out_n \
    testbench.dut.trimac_locallink.tx_ll_data_in

if {[catch {group new -name {TX RGMII Interface} -overlay 0}] != ""} {
    group using {TX RGMII Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :testbench.rgmii_txc \
    :testbench.rgmii_tx_ctl \
    :testbench.rgmii_txd

if {[catch {group new -name {RX RGMII Interface} -overlay 0}] != ""} {
    group using {RX RGMII Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :testbench.rgmii_rxc \
    :testbench.rgmii_rx_ctl \
    :testbench.rgmii_rxd



if {[catch {group new -name {Management Interface} -overlay 0}] != ""} {
    group using {Management Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :testbench.configuration_vector


#
# Waveform windows
#
if {[window find -match exact -name "Waveform 1"] == {}} {
    window new WaveWindow -name "Waveform 1" -geometry 906x585+25+55
} else {
    window geometry "Waveform 1" 906x585+25+55
}
window target "Waveform 1" on
waveform using {Waveform 1}
waveform sidebar visibility partial
waveform set \
    -primarycursor TimeA \
    -signalnames name \
    -signalwidth 175 \
    -units fs \
    -valuewidth 75
cursor set -using TimeA -time 50,000,000,000fs
cursor set -using TimeA -marching 1
waveform baseline set -time 0

set groupId [waveform add -groups {{System Signals}}]
set groupId [waveform add -groups {{TX Client Interface}}]
set groupId [waveform add -groups {{TX Statistics Vector}}]
set groupId [waveform add -groups {{RX Client Interface}}]
set groupId [waveform add -groups {{RX Statistics Vector}}]
set groupId [waveform add -groups {{Flow Control}}]
set groupId [waveform add -groups {{Rx FIFO Local Link Interface}}]
set groupId [waveform add -groups {{Tx FIFO Local Link Interface}}]

set groupId [waveform add -groups {{TX RGMII Interface}}]
set groupId [waveform add -groups {{RX RGMII Interface}}]
set groupId [waveform add -groups {{Management Interface}}]

waveform xview limits 0fs 10us

simcontrol run -time 500us

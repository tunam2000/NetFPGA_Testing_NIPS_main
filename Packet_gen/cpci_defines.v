///////////////////////////////////////////////////////////////////////////////
// $Id: cpci_defines.v 4428 2008-08-12 02:24:01Z grg $
//
// Module: cpci_defines.v
// Project: NF2.
// Description: CPCI specific defines
//              several devices.
//
//              Can also use for chip specific defines.
//
///////////////////////////////////////////////////////////////////////////////



`ifndef CPCI_DEFINES_V
`define CPCI_DEFINES_V

//-----------------------------------------------------------------------------5
// CPCI Definitions
//-----------------------------------------------------------------------------

// Version and revision IDs
`define CPCI_VERSION_ID   24'h000003
`define CPCI_REVISION_ID  8'h03
// Version 1: NF2.0
// Revision 6: Fixed bug in dma_engine whereby an extra word would be
// insterted at the start of a packet.
//
// Version 2: NF2.1
// Rev 2: DLL on nclk
// Rev 3: DMA rx interface change
// Rev 4: DMA engine split into submodules
//
// Version 3: NF 2.1 with dedicated DMA bus (bi-directional)
// Rev 1: Initial version
// Rev 2: Fixed bug with PCI retries on writes to Virtex (retries
//        were not being generated)
// Rev 3: Fixed bug preventing programming of the Virtex via JTAG 
//        immediately after CPCI reprogramming.

// Register addresses (byte address)
// Note: In order to allow the PERL parser to generate 
//       a register map which can be used by the Perl based tests, 
//       All register address names must start with "CPCI_",
//       end with "_reg", and address must be in the format of
//       "<bit number>'h<hex number>"


`define CPCI_ID_reg      	12'h000
`define CPCI_Board_ID_reg	12'h004
`define CPCI_Control_reg 	12'h008
`define CPCI_Reset_reg		12'h00c
`define CPCI_Error_reg		12'h010

`define CPCI_Dummy_reg		12'h020

`define CPCI_Interrupt_Mask_reg 	12'h040
`define CPCI_Interrupt_Status_reg 	12'h044

`define CPCI_CNET_Clk_Sel_reg	12'h050

`define CPCI_Reprog_Data_reg 	12'h100
`define CPCI_Reprog_Status_reg 	12'h104
`define CPCI_Reprog_Ctrl_reg 	12'h108

`define CPCI_DMA_Addr_I_reg	12'h140
`define CPCI_DMA_Addr_E_reg	12'h144

`define CPCI_DMA_Size_I_reg	12'h148
`define CPCI_DMA_Size_E_reg	12'h14c

`define CPCI_DMA_Ctrl_I_reg	12'h150
`define CPCI_DMA_Ctrl_E_reg	12'h154

`define CPCI_DMA_Xfer_Time_reg	12'h180
`define CPCI_DMA_Retries_reg	12'h184

`define CPCI_CNET_Read_Time_reg	12'h188

`define CPCI_DMA_Ingress_Pkt_Cnt_reg	12'h400
`define CPCI_DMA_Egress_Pkt_Cnt_reg	12'h404

`define CPCI_CPCI_Reg_Read_Cnt_reg	12'h408
`define CPCI_CPCI_Reg_Write_Cnt_reg	12'h40c

`define CPCI_CNET_Reg_Read_Cnt_reg	12'h410
`define CPCI_CNET_Reg_Write_Cnt_reg	12'h414


`define CPCI_Clock_check_n_clk_reg	12'h500
`define CPCI_Clock_check_p_max_reg      12'h504
`define CPCI_Clock_check_n_exp_reg      12'h508
`define CPCI_PCI_clk_counter_reg    	12'h510
`define CPCI_CPCI_reset_counter_reg     12'h520

// Defaults for timers/counters
`define CPCI_DMA_Xfer_Time_default	32'd30000
`define CPCI_DMA_Retries_default	16'hffff
`define CPCI_CNET_Read_Time_default	32'd4000

// These are default values for clock checker module.
// We time for 1/10th sec by default, so these are the
// number of clock ticks expected.
// So if you change one, then you must change the other.
`define CPCI_P_MAX_default 'd3333333
`define CPCI_N_EXP_default 'd6250000

/*********************************************************
 * useful macros
 *********************************************************/

 // 5- print the reg name and addr in C format
 `define PRINT_REG_ADDRESSES_CPCI                                                                                                       \
        $fwrite(c_reg_defines_fd, "/* ========== CPCI Defines ========== */\n");                                                        \
        $fwrite(c_reg_defines_fd, "#define CPCI_ID_REG                             0x%07x\n", {15'h0, `CPCI_ID_reg});                   \
        $fwrite(c_reg_defines_fd, "#define CPCI_BOARD_ID_REG                       0x%07x\n", {15'h0, `CPCI_Board_ID_reg});             \
        $fwrite(c_reg_defines_fd, "#define CPCI_CONTROL_REG                        0x%07x\n", {15'h0, `CPCI_Control_reg});              \
        $fwrite(c_reg_defines_fd, "#define CPCI_RESET_REG                          0x%07x\n", {15'h0, `CPCI_Reset_reg});                \
        $fwrite(c_reg_defines_fd, "#define CPCI_ERROR_REG                          0x%07x\n\n", {15'h0, `CPCI_Error_reg});              \
                                                                                                                                        \
        $fwrite(c_reg_defines_fd, "#define CPCI_DUMMY_REG                          0x%07x\n\n", {15'h0, `CPCI_Dummy_reg});              \
                                                                                                                                        \
        $fwrite(c_reg_defines_fd, "#define CPCI_INTERRUPT_MASK_REG                 0x%07x\n", {15'h0, `CPCI_Interrupt_Mask_reg});       \
        $fwrite(c_reg_defines_fd, "#define CPCI_INTERRUPT_STATUS_REG               0x%07x\n\n", {15'h0, `CPCI_Interrupt_Status_reg});   \
                                                                                                                                        \
        $fwrite(c_reg_defines_fd, "#define CPCI_CNET_CLK_SEL_REG                   0x%07x\n\n", {15'h0, `CPCI_CNET_Clk_Sel_reg});       \
                                                                                                                                        \
        $fwrite(c_reg_defines_fd, "#define CPCI_REPROG_DATA_REG                    0x%07x\n", {15'h0, `CPCI_Reprog_Data_reg});          \
        $fwrite(c_reg_defines_fd, "#define CPCI_REPROG_STATUS_REG                  0x%07x\n", {15'h0, `CPCI_Reprog_Status_reg});        \
        $fwrite(c_reg_defines_fd, "#define CPCI_REPROG_CTRL_REG                    0x%07x\n\n", {15'h0, `CPCI_Reprog_Ctrl_reg});        \
                                                                                                                                        \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_ADDR_I_REG                     0x%07x\n", {15'h0, `CPCI_DMA_Addr_I_reg});           \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_ADDR_E_REG                     0x%07x\n", {15'h0, `CPCI_DMA_Addr_E_reg});           \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_SIZE_I_REG                     0x%07x\n", {15'h0, `CPCI_DMA_Size_I_reg});           \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_SIZE_E_REG                     0x%07x\n", {15'h0, `CPCI_DMA_Size_E_reg});           \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_CTRL_I_REG                     0x%07x\n", {15'h0, `CPCI_DMA_Ctrl_I_reg});           \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_CTRL_E_REG                     0x%07x\n", {15'h0, `CPCI_DMA_Ctrl_E_reg});           \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_XFER_TIME_REG                  0x%07x\n", {15'h0, `CPCI_DMA_Xfer_Time_reg});        \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_RETRIES_REG                    0x%07x\n\n", {15'h0, `CPCI_DMA_Retries_reg});        \
                                                                                                                                        \
        $fwrite(c_reg_defines_fd, "#define CPCI_CNET_READ_TIME_REG                 0x%07x\n\n", {15'h0, `CPCI_CNET_Read_Time_reg});     \
                                                                                                                                        \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_INGRESS_PKT_CNT_REG            0x%07x\n", {15'h0, `CPCI_DMA_Ingress_Pkt_Cnt_reg});  \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_EGRESS_PKT_CNT_REG             0x%07x\n", {15'h0, `CPCI_DMA_Egress_Pkt_Cnt_reg});   \
        $fwrite(c_reg_defines_fd, "#define CPCI_CPCI_REG_READ_CNT_REG              0x%07x\n", {15'h0, `CPCI_CPCI_Reg_Read_Cnt_reg});    \
        $fwrite(c_reg_defines_fd, "#define CPCI_CPCI_REG_WRITE_CNT_REG             0x%07x\n", {15'h0, `CPCI_CPCI_Reg_Write_Cnt_reg});   \
        $fwrite(c_reg_defines_fd, "#define CPCI_CNET_REG_READ_CNT_REG              0x%07x\n", {15'h0, `CPCI_CNET_Reg_Read_Cnt_reg});    \
        $fwrite(c_reg_defines_fd, "#define CPCI_CNET_REG_WRITE_CNT_REG             0x%07x\n\n", {15'h0, `CPCI_CNET_Reg_Write_Cnt_reg}); \
                                                                                                                                        \
        $fwrite(c_reg_defines_fd, "#define CPCI_CLOCK_CHECK_N_CLK_REG              0x%07x\n", {15'h0, `CPCI_Clock_check_n_clk_reg});    \
        $fwrite(c_reg_defines_fd, "#define CPCI_CLOCK_CHECK_P_MAX_REG              0x%07x\n", {15'h0, `CPCI_Clock_check_p_max_reg});    \
        $fwrite(c_reg_defines_fd, "#define CPCI_CLOCK_CHECK_N_EXP_REG              0x%07x\n", {15'h0, `CPCI_Clock_check_n_exp_reg});    \
        $fwrite(c_reg_defines_fd, "#define CPCI_PCI_CLK_COUNTER_REG                0x%07x\n", {15'h0, `CPCI_PCI_clk_counter_reg});      \
        $fwrite(c_reg_defines_fd, "#define CPCI_CPCI_RESET_COUNTER_REG             0x%07x\n\n", {15'h0, `CPCI_CPCI_reset_counter_reg}); \
                                                                                                                                        \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_XFER_TIME_DEFAULT              0x%08x\n", `CPCI_DMA_Xfer_Time_default);             \
        $fwrite(c_reg_defines_fd, "#define CPCI_DMA_RETRIES_DEFAULT                0x%04x\n", `CPCI_DMA_Retries_default);               \
        $fwrite(c_reg_defines_fd, "#define CPCI_CNET_READ_TIME_DEFAULT             0x%08x\n\n\n", `CPCI_CNET_Read_Time_default)

`endif

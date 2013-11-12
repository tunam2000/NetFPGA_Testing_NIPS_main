///////////////////////////////////////////////////////////////////////////////
// $Id: global_defines.v 3763 2008-05-22 06:22:10Z grg $
//
// Module: defines.v
// Project: NF2.
// Description: Common verilog definitions that may be used by
//              several devices.
//
//              Can also use for chip specific defines.
//
///////////////////////////////////////////////////////////////////////////////



`ifndef DEFINES_V
`define DEFINES_V

//-----------------------------------------------------------------------------
// PCI Bus Definitions
//-----------------------------------------------------------------------------


// Width of address bus. This is byte addresses even though bottom bits are zero.
`define PCI_ADDR_WIDTH 32

// Width of data bus
`define PCI_DATA_WIDTH 32

// Width of BE bus
`define PCI_BE_WIDTH 4


//-----------------------------------------------------------------------------
// CPCI/CNET Bus Definitions
//-----------------------------------------------------------------------------


// Width of address bus. This is byte addresses even though bottom bits are zero.
`define CPCI_CNET_ADDR_WIDTH 27

// Width of data bus
`define CPCI_CNET_DATA_WIDTH 32

// Width of DMA data bus
`define DMA_DATA_WIDTH 32

`define DMA_CTRL_WIDTH (`DMA_DATA_WIDTH / 8)

// Width of CPCI debug data bus
`define CPCI_DEBUG_DATA_WIDTH 29


//-----------------------------------------------------------------------------
// SRAM related defines
//
// Note: These are for a *single* device
//-----------------------------------------------------------------------------

`define SRAM_ADDR_WIDTH 19
`define SRAM_DATA_WIDTH 36


//-----------------------------------------------------------------------------
// DRAM related defines
//-----------------------------------------------------------------------------

// DRAM address width: 2 + 22   (BA + Addr)
`define DRAM_ADDR_WIDTH 24


`include "cpci_defines.v"
`include "NF_2.1_defines.v"

`endif



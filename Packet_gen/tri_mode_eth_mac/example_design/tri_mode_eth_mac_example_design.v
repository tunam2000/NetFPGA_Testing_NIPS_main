 
//----------------------------------------------------------------------
// $Revision: 1.1.2.1 $ $Date: 2007/05/14 13:57:04 $
//----------------------------------------------------------------------
// File       : tri_mode_eth_mac_example_design.v 
// Author     : Xilinx Inc.
//----------------------------------------------------------------------
// Copyright (c) 2004-2007 by Xilinx, Inc. All rights reserved.
// This text/file contains proprietary, confidential
// information of Xilinx, Inc., is distributed under license
// from Xilinx, Inc., and may be used, copied and/or
// disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc. Xilinx hereby grants you
// a license to use this text/file solely for design, simulation,
// implementation and creation of design files limited
// to Xilinx devices or technologies. Use with non-Xilinx
// devices or technologies is expressly prohibited and
// immediately terminates your license unless covered by
// a separate agreement.
//
// Xilinx is providing this design, code, or information
// "as is" solely for use in developing programs and
// solutions for Xilinx devices. By providing this design,
// code, or information as one possible implementation of
// this feature, application or standard, Xilinx is making no
// representation that this implementation is free from any
// claims of infringement. You are responsible for
// obtaining any rights you may require for your implementation.
// Xilinx expressly disclaims any warranty whatsoever with
// respect to the adequacy of the implementation, including
// but not limited to any warranties or representations that this
// implementation is free from claims of infringement, implied
// warranties of merchantability or fitness for a particular
// purpose.
//
// Xilinx products are not intended for use in life support
// appliances, devices, or systems. Use in such applications are
// expressly prohibited.
//
// This copyright and support notice must be retained as part
// of this text at all times. (c) Copyright 2004-2007 Xilinx, Inc.
// All rights reserved.
//-----------------------------------------------------------------------------
// Description:  This is the Verilog example design for the Tri-Mode
//               Ethernet MAC core. It is intended that this example design 
//               can be quickly adapted and downloaded onto an FPGA to provide 
//               a real hardware test environment.
//
//               This level:
//
//               * Instantiates the LocalLink wrapper, containing the 
//                 block level wrapper and an RX and TX FIFO with a 
//                 LocalLink interface;
//
//               * Instantiates a simple client example design,
//                 providing an address swap and a simple
//                 loopback function;
//
//               * Instantiates an IBUF on GTX_CLK
//
//               Please refer to the Datasheet, Getting Started Guide, and
//               the Tri-Mode Ethernet MAC User Gude for further information.
//
//
//    ---------------------------------------------------------------------
//    | EXAMPLE DESIGN WRAPPER                                            |
//    |           --------------------------------------------------------|
//    |           |LOCALLINK WRAPPER                                      |
//    |           |              -----------------------------------------|
//    |           |              |BLOCK LEVEL WRAPPER                     |
//    |           |              |    ---------------------               |
//    | --------  |  ----------  |    | ETHERNET MAC      |               |
//    | |      |  |  |        |  |    | WRAPPER           |  ---------    |
//    | |      |->|->|        |--|--->| Tx            Tx  |--|       |--->|
//    | |      |  |  |        |  |    | client        PHY |  |       |    |
//    | | ADDR |  |  | LOCAL  |  |    | I/F           I/F |  |       |    |  
//    | | SWAP |  |  |  LINK  |  |    |                   |  | PHY   |    |
//    | |      |  |  |  FIFO  |  |    |                   |  | I/F   |    |
//    | |      |  |  |        |  |    |                   |  |       |    |
//    | |      |  |  |        |  |    | Rx            Rx  |  |       |    |
//    | |      |  |  |        |  |    | client        PHY |  |       |    |
//    | |      |<-|<-|        |<-|----| I/F           I/F |<-|       |<---|
//    | |      |  |  |        |  |    |                   |  ---------    |
//    | --------  |  ----------  |    ---------------------               |
//    |           |              -----------------------------------------|
//    |           --------------------------------------------------------|
//    ---------------------------------------------------------------------
//
//-----------------------------------------------------------------------------

`timescale 1 ns/1 ps

module tri_mode_eth_mac_example_design
    ( //-- asynchronous reset     
      reset,   
      //------------------------------------------------------------------
      //-- Client Receiver Interface
      //------------------------------------------------------------------
      rx_clk,
      rx_statistics_vector,
      rx_statistics_valid,
      //------------------------------------------------------------------
      //-- Client Transmitter Interface
      //------------------------------------------------------------------
      tx_clk,    
      tx_ifg_delay,
      tx_statistics_vector,
      tx_statistics_valid,
      //------------------------------------------------------------------
      //-- MAC Control Interface
      //------------------------------------------------------------------
      pause_req,    
      pause_val, 
     //-----------------------------------------------------------------------
      //-- RGMII Interface
      //-----------------------------------------------------------------------
      gtx_clk,    
      rgmii_txd,
      rgmii_tx_ctl,
      rgmii_txc,
      rgmii_rxd,
      rgmii_rx_ctl,
      rgmii_rxc,
      //-----------------------------------------------------------------------
      //-- RGMII Inband Status Registers
      //-----------------------------------------------------------------------
      inband_link_status,
      inband_clock_speed,
      inband_duplex_status,
      //------------------------------------------------------------------
      //-- Configuration Vector
      //------------------------------------------------------------------
      configuration_vector 
      );
 
      input  reset; 
               
      output rx_clk;              
      output [27:0] rx_statistics_vector;
      output rx_statistics_valid;
      
      output tx_clk;    
      input  [7:0] tx_ifg_delay;
      output [31:0] tx_statistics_vector;
      output tx_statistics_valid;
      input  pause_req;    
      input  [15:0] pause_val; 
 

      input  gtx_clk;    
      output [3:0] rgmii_txd;
      output rgmii_tx_ctl;
      output rgmii_txc;
      input  [3:0] rgmii_rxd;
      input  rgmii_rx_ctl;
      input  rgmii_rxc;
      output inband_link_status;
      output [1:0] inband_clock_speed;
      output inband_duplex_status;
      
      

      input  [66:0] configuration_vector;   
  //----------------------------------------------------------------------
  //-- internal signals used in this top level wrapper.
  //----------------------------------------------------------------------

  wire        gtx_clk_ibufg;                    // gtx_clk routed through an IBUFG.
  wire        tx_clk_int;                       // Internal transmitter core clock signal.
  wire        rx_clk_int;                       // Internal receiver core clock signal
  wire        rx_enable_int;                    // rx_enable signal routed from the MAC
  wire        tx_enable_int;                    // tx_enable signal routed from the MAC
    
  wire        tx_ll_clk;          
  reg  [5:0]  tx_ll_pre_reset;   
  reg         tx_ll_reset; 
  wire [7:0]  tx_ll_data;  
  wire        tx_ll_sof_n;       
  wire        tx_ll_eof_n;       
  wire        tx_ll_src_rdy_n;   
  wire        tx_ll_dst_rdy_n;     

  wire        rx_ll_clk;        
  wire        rx_ll_reset; 
  wire [7:0]  rx_ll_data;     
  wire        rx_ll_sof_n;        
  wire        rx_ll_eof_n;        
  wire        rx_ll_src_rdy_n; 
  wire        rx_ll_dst_rdy_n;     

  wire [27:0] rx_statistics_vector_int;         // Internal rx_statistics_vector signal.
  wire        rx_statistics_valid_int;          // Internal rx_statistics_valid signal.
  wire [31:0] tx_statistics_vector_int;	        // Internal tx_statistics_vector signal.
  wire        tx_statistics_valid_int;          // Internal tx_statistics_valid signal.
  reg         rx_statistics_valid_reg;          // rx_statistics_vector registered in IOBs.
  reg  [27:0] rx_statistics_vector_reg;         // rx_statistics_valid registered in an IOB.
  reg         tx_statistics_valid_reg;          // tx_statistics_vector registered in IOBs.
  reg  [31:0] tx_statistics_vector_reg;         // tx_statistics_valid registered in an IOB.


  //synthesis attribute async_reg of tx_ll_pre_reset is "true";
  //synthesis attribute async_reg of tx_ll_reset is "true";


  assign tx_clk = tx_clk_int;
  assign rx_clk = rx_clk_int;

  assign tx_ll_clk = tx_clk_int;
  assign rx_ll_clk = tx_clk_int; 

  assign rx_ll_reset = tx_ll_reset; 

  assign rx_ll_dst_rdy_n = tx_ll_dst_rdy_n; 

  //----------------------------------------------------------------------
  //-- gtx_clk Clock Management
  //----------------------------------------------------------------------

   IBUF ibufg_gtx_clk (.I(gtx_clk),           .O(gtx_clk_ibufg));


  //-------------------------------------------------------------------
  // Create synchronous reset signal for use in the Address swapping module. 
  //-------------------------------------------------------------------
  // Create synchronous reset in the transmitter clock domain.
  always @(posedge tx_clk_int, posedge reset)
  begin
    if (reset === 1'b1)
    begin
      tx_ll_pre_reset <= 6'h3F;
      tx_ll_reset     <= 1'b1;
    end
    else
    begin
      tx_ll_pre_reset[0]   <= 1'b0;
      tx_ll_pre_reset[5:1] <= tx_ll_pre_reset[4:0];    
      tx_ll_reset          <= tx_ll_pre_reset[5];
    end
  end

  //-------------------------------------------------------------------
  // Register the Rx statistic vector to allow the usage of IOB registers
  //-------------------------------------------------------------------
  always @(posedge rx_clk_int or posedge reset)
  begin
    if (reset == 1'b1)
    begin
      rx_statistics_valid_reg  <= 1'b0;
      rx_statistics_vector_reg <= 28'h0000000;
    end
    else
    begin
      rx_statistics_valid_reg  <= rx_statistics_valid_int;
      rx_statistics_vector_reg <= rx_statistics_vector_int;
    end
  end


   assign rx_statistics_vector = rx_statistics_vector_reg;   
    
   assign rx_statistics_valid = rx_statistics_valid_reg;

   //-------------------------------------------------------------------
   // register the Tx statistic vector to allow the usage of IOB registers
   //-------------------------------------------------------------------
   always @(posedge tx_clk_int or posedge reset)
   begin
     if (reset == 1'b1)
     begin
       tx_statistics_valid_reg  <= 1'b0;
       tx_statistics_vector_reg <= 32'h00000000;
     end
     else
     begin
       tx_statistics_valid_reg  <= tx_statistics_valid_int;
       tx_statistics_vector_reg <= tx_statistics_vector_int;
     end
   end                  


   assign tx_statistics_vector = tx_statistics_vector_reg;


   assign tx_statistics_valid = tx_statistics_valid_reg;  


  //----------------------------------------------------------------------
  //-- Instantiate the TRIMAC core LocalLink wrapper
  //----------------------------------------------------------------------
  tri_mode_eth_mac_locallink trimac_locallink( 
      .reset(reset),
      //------------------------------------------------------------------------
      //-- Receiver Interface.
      //------------------------------------------------------------------------
      .rx_clk(rx_clk_int),
      .rx_enable(rx_enable_int),
 
      .rx_statistics_vector(rx_statistics_vector_int),
      .rx_statistics_valid(rx_statistics_valid_int), 
      //------------------------------------------------------------------------
      // Receiver (LocalLink) Interface
      //------------------------------------------------------------------------
      .rx_ll_clock(rx_ll_clk),    
      .rx_ll_reset(rx_ll_reset),    
      .rx_ll_data_out(rx_ll_data),          
      .rx_ll_sof_out_n(rx_ll_sof_n),         
      .rx_ll_eof_out_n(rx_ll_eof_n),         
      .rx_ll_src_rdy_out_n(rx_ll_src_rdy_n), 
      .rx_ll_dst_rdy_in_n(rx_ll_dst_rdy_n), 
      //------------------------------------------------------------------------
      //-- Transmitter Interface
      //------------------------------------------------------------------------
      .tx_clk(tx_clk_int),
      .tx_enable(tx_enable_int),
 
      .tx_ifg_delay(tx_ifg_delay),        
      .tx_statistics_vector(tx_statistics_vector_int),
      .tx_statistics_valid(tx_statistics_valid_int), 
      //------------------------------------------------------------------------
      // Transmitter (LocalLink) Interface
      //------------------------------------------------------------------------
      .tx_ll_clock(tx_ll_clk),    
      .tx_ll_reset(tx_ll_reset),  
      .tx_ll_data_in(tx_ll_data),           
      .tx_ll_sof_in_n(tx_ll_sof_n),         
      .tx_ll_eof_in_n(tx_ll_eof_n),         
      .tx_ll_src_rdy_in_n(tx_ll_src_rdy_n), 
      .tx_ll_dst_rdy_out_n(tx_ll_dst_rdy_n),     
      //------------------------------------------------------------------------
      //-- Flow Control
      //------------------------------------------------------------------------
      .pause_req(pause_req),
      .pause_val(pause_val),
      //-----------------------------------------------------------------------
      //-- RGMII Interface
      //-----------------------------------------------------------------------
      .gtx_clk(gtx_clk_ibufg),    
      .rgmii_txd(rgmii_txd),
      .rgmii_tx_ctl(rgmii_tx_ctl),
      .rgmii_txc(rgmii_txc),
      .rgmii_rxd(rgmii_rxd),
      .rgmii_rx_ctl(rgmii_rx_ctl),
      .rgmii_rxc(rgmii_rxc),
      .inband_link_status(inband_link_status),
      .inband_clock_speed(inband_clock_speed),
      .inband_duplex_status(inband_duplex_status),
       .configuration_vector(configuration_vector)
       );


  //-------------------------------------------------------------------
  //  Instantiate the address swapping module
  //-------------------------------------------------------------------
  address_swap_module client_side_asm
    (.rx_ll_clock(tx_clk_int),
     .rx_ll_reset(tx_ll_reset),
     .rx_ll_data_in(rx_ll_data),
     .rx_ll_sof_in_n(rx_ll_sof_n),
     .rx_ll_eof_in_n(rx_ll_eof_n),
     .rx_ll_src_rdy_in_n(rx_ll_src_rdy_n),
     .rx_ll_data_out(tx_ll_data),
     .rx_ll_sof_out_n(tx_ll_sof_n),
     .rx_ll_eof_out_n(tx_ll_eof_n),
     .rx_ll_src_rdy_out_n(tx_ll_src_rdy_n),
     .rx_ll_dst_rdy_in_n(tx_ll_dst_rdy_n));     

endmodule

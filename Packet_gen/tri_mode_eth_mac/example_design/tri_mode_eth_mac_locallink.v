 
//----------------------------------------------------------------------
// $Revision: 1.1.2.1 $ $Date: 2007/05/14 13:57:04 $
//----------------------------------------------------------------------
// File       : tri_mode_eth_mac_locallink.v 
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
//----------------------------------------------------------------------
// Description: This is the LocalLink wrapper for the Tri-Mode  
//              Ethernet MAC core.
//
//         _________________________________________________________
//        |                                                         |
//        |                    LOCAL LINK WRAPPER                   |
//        |                                                         |
//        |   _____________________       ______________________    |
//        |  |  _________________  |     |                      |   |
//        |  | |                 | |     |                      |   |
//  -------->| | TX CLIENT FIFO  | |---->| Tx               Tx  |--------->   	 
//        |  | |                 | |     | client           PHY |   |
//        |  | |_________________| |     | I/F              I/F |   |
//        |  |                     |     |                      |   | 
//  Local |  |     10/100/1G       |     |  TRI-MODE ETHERNET   |   |
//  Link  |  |    ETHERNET FIFO    |     |      MAC CORE        |   | GMII/MII
//        |  |                     |     |     TOP WRAPPER      |   |
//        |  |  _________________  |     |                      |   |
//        |  | |                 | |     |                      |   |
//  <--------| | RX CLIENT FIFO  | |<----| Rx               Rx  |<---------
//        |  | |                 | |     | client           PHY |   |
//        |  | |_________________| |     | I/F              I/F |   |
//        |  |_____________________|     |______________________|   |
//        |                                                         |
//        |_________________________________________________________|
//    

`timescale 1 ns/1 ps

module tri_mode_eth_mac_locallink
    ( //-- asynchronous reset     
      reset, 
  
      //------------------------------------------------------------------
      //-- Client Receiver Interface
      //------------------------------------------------------------------
      rx_clk,
      rx_enable,
     
      rx_statistics_vector,
      rx_statistics_valid,
      //------------------------------------------------------------------------
      //-- Client Receiver (LocalLink) Interface
      //------------------------------------------------------------------------
      rx_ll_clock,
      rx_ll_reset,
      rx_ll_data_out,          
      rx_ll_sof_out_n,         
      rx_ll_eof_out_n,         
      rx_ll_src_rdy_out_n, 
      rx_ll_dst_rdy_in_n,
      //------------------------------------------------------------------
      //-- Client Transmitter Interface
      //------------------------------------------------------------------
      tx_clk, 
      tx_enable,
     
      tx_ifg_delay,
      tx_statistics_vector,
      tx_statistics_valid,
      //------------------------------------------------------------------------
      //-- Client Transmitter (LocalLink) Interface
      //------------------------------------------------------------------------
      tx_ll_clock,
      tx_ll_reset,
      tx_ll_data_in,           
      tx_ll_sof_in_n,         
      tx_ll_eof_in_n,         
      tx_ll_src_rdy_in_n, 
      tx_ll_dst_rdy_out_n,  
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
      output rx_enable;
             
      output [27:0] rx_statistics_vector;
      output rx_statistics_valid;
      
      input  rx_ll_clock; 
      input  rx_ll_reset;   
      output [7:0] rx_ll_data_out;              
      output rx_ll_sof_out_n;
      output rx_ll_eof_out_n;
      output rx_ll_src_rdy_out_n;
      input  rx_ll_dst_rdy_in_n;
      
      output tx_clk;
      output tx_enable;
     
      input  [7:0] tx_ifg_delay;
      output [31:0] tx_statistics_vector;
      output tx_statistics_valid;
      
      input  tx_ll_clock;            
      input  tx_ll_reset;          
      input  [7:0] tx_ll_data_in;     
      input  tx_ll_sof_in_n;        
      input  tx_ll_eof_in_n;        
      input  tx_ll_src_rdy_in_n;    
      output tx_ll_dst_rdy_out_n;    

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
  //-- internal signals used in this locallink level wrapper.
  //----------------------------------------------------------------------  
   wire       rx_clk_int;     
   wire       rx_enable_int;      
     
   wire       tx_clk_int;     
   wire       tx_enable_int;      

   wire [7:0] rx_data;        
   wire       rx_data_valid;  
   wire       rx_good_frame;  
   wire       rx_bad_frame;   
  
   wire [7:0] tx_data;               
   wire       tx_data_valid;          
   wire       tx_ack;                 
   wire       tx_underrun;            
   wire       tx_collision;           
   wire       tx_retransmit;          
  
  // create a synchronous reset in the transmitter clock domain
  reg tx_pre_reset;
  reg tx_reset;

  // create a synchronous reset in the receiver clock domain
  reg rx_pre_reset;
  reg rx_reset;

  // synthesis attribute keep of tx_data       is "true";
  // synthesis attribute keep of tx_data_valid is "true";
  // synthesis attribute keep of tx_ack        is "true"; 
  // synthesis attribute keep of tx_underrun   is "true"; 
  // synthesis attribute keep of rx_data       is "true";
  // synthesis attribute keep of rx_data_valid is "true";
  // synthesis attribute keep of rx_good_frame is "true";
  // synthesis attribute keep of rx_bad_frame  is "true";
  // synthesis attribute keep of tx_enable_int is "true";
  // synthesis attribute keep of rx_enable_int is "true";

  // synthesis attribute ASYNC_REG of rx_pre_reset is "TRUE";
  // synthesis attribute ASYNC_REG of tx_pre_reset is "TRUE";


   assign rx_clk          = rx_clk_int;
   assign rx_enable       = rx_enable_int;
   assign tx_enable       = tx_enable_int;

   assign tx_clk          = tx_clk_int;

  //-------------------------------------------------------------------
  // Create synchronous reset signals for use in the Address swapping 
  // and FIFO modules.  A synchronous reset signal is created in each
  // clock domain.
  //-------------------------------------------------------------------

  // Create synchronous reset in the transmitter clock domain.
  always @(posedge tx_clk_int, posedge reset)
  begin
    if (reset === 1'b1)
    begin
      tx_pre_reset <= 1'b1;
      tx_reset     <= 1'b1;
    end
    else
    begin
      if (tx_enable_int == 1'b1) 
      begin
        tx_pre_reset <= 1'b0;
        tx_reset     <= tx_pre_reset;
      end
    end
  end

  // Create synchronous reset in the receiver clock domain.
  always @(posedge rx_clk_int, posedge reset)
  begin
    if (reset === 1'b1)
    begin
      rx_pre_reset <= 1'b1;
      rx_reset     <= 1'b1;
    end
    else
    begin
      if (rx_enable_int == 1'b1) 
      begin
        rx_pre_reset <= 1'b0;
        rx_reset     <= rx_pre_reset;
      end
    end
  end

  //----------------------------------------------------------------------
  //-- Instantiate the Tri-Mode EMAC core top wrapper
  //----------------------------------------------------------------------
  tri_mode_eth_mac_block trimac_block( 
      .reset(reset),
      //------------------------------------------------------------------------
      //-- Receiver Interface.
      //------------------------------------------------------------------------
      .rx_clk(rx_clk_int), 
      .rx_enable(rx_enable_int),
      .rx_statistics_vector(rx_statistics_vector),
      .rx_statistics_valid(rx_statistics_valid), 
      .rx_data(rx_data),
      .rx_data_valid(rx_data_valid),
      .rx_good_frame(rx_good_frame),
      .rx_bad_frame(rx_bad_frame),
      //------------------------------------------------------------------------
      //-- Transmitter Interface
      //------------------------------------------------------------------------
      .tx_clk(tx_clk_int),
      .tx_enable(tx_enable_int),
      .tx_ifg_delay(tx_ifg_delay),        
      .tx_statistics_vector(tx_statistics_vector),
      .tx_statistics_valid(tx_statistics_valid), 
      .tx_data(tx_data),
      .tx_data_valid(tx_data_valid),
      .tx_ack(tx_ack),
      .tx_underrun(tx_underrun),
      .tx_collision(tx_collision),
      .tx_retransmit(tx_retransmit),  
      //------------------------------------------------------------------------
      //-- Flow Control
      //------------------------------------------------------------------------
      .pause_req(pause_req),
      .pause_val(pause_val),
      //-----------------------------------------------------------------------
      //-- RGMII Interface
      //-----------------------------------------------------------------------
      .gtx_clk(gtx_clk),    
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
  // Instantiate the client side FIFO								 
  //-------------------------------------------------------------------
  ten_100_1g_eth_fifo client_side_FIFO
    (.tx_clk(tx_clk_int),
     .tx_reset(tx_reset),
     .tx_enable(tx_enable_int),
     .tx_data(tx_data),
     .tx_data_valid(tx_data_valid),
     .tx_ack(tx_ack),
     .tx_underrun(tx_underrun),
     .tx_collision(tx_collision),
     .tx_retransmit(tx_retransmit),
     
     .tx_ll_clock(tx_ll_clock),
     .tx_ll_reset(tx_ll_reset),
     .tx_ll_data_in(tx_ll_data_in),
     .tx_ll_sof_in_n(tx_ll_sof_in_n),
     .tx_ll_eof_in_n(tx_ll_eof_in_n),
     .tx_ll_src_rdy_in_n(tx_ll_src_rdy_in_n),
     .tx_ll_dst_rdy_out_n(tx_ll_dst_rdy_out_n),
     .tx_fifo_status(),
     .tx_overflow(),
     
     .rx_clk(rx_clk_int),
     .rx_reset(rx_reset),
     .rx_enable(rx_enable_int),
     .rx_data(rx_data),
     .rx_data_valid(rx_data_valid),
     .rx_good_frame(rx_good_frame),
     .rx_bad_frame(rx_bad_frame),
     .rx_overflow(),

     .rx_ll_clock(rx_ll_clock),
     .rx_ll_reset(rx_ll_reset),
     .rx_ll_data_out(rx_ll_data_out),
     .rx_ll_sof_out_n(rx_ll_sof_out_n),
     .rx_ll_eof_out_n(rx_ll_eof_out_n),
     .rx_ll_src_rdy_out_n(rx_ll_src_rdy_out_n),
     .rx_ll_dst_rdy_in_n(rx_ll_dst_rdy_in_n),
     .rx_fifo_status());

endmodule

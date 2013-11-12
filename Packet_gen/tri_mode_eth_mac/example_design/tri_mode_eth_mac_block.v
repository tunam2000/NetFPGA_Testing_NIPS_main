//------------------------------------------------------------------------
//-- $Revision: 1.1.2.1 $ $Date: 2007/05/14 13:57:04 $
//------------------------------------------------------------------------
//-- File       : tri_mode_eth_mac_block.v  
//-- Author     : Xilinx Inc.
//------------------------------------------------------------------------
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
// Description:  This is the block level Verilog design for the Tri-Mode 
//               Ethernet MAC Example Design. 
//
//               This block level:
//
//               * instantiates all clock management logic required (BUFGs, 
//                 DCMs) to operate the EMAC and its example design;
//
//               * instantiates appropriate PHY interface modules (GMII or RGMII)
//                 as required based on the user configuration;
//
//               Please refer to the Datasheet, Getting Started Guide, and
//               the Tri-Mode Ethernet MAC User Gude for further information.

`timescale 1 ns/1 ps

module tri_mode_eth_mac_block
    ( //-- asynchronous reset     
      reset,
     
      //------------------------------------------------------------------
      //-- Client Receiver Interface
      //------------------------------------------------------------------
      rx_clk,
      rx_enable,
      rx_statistics_vector,
      rx_statistics_valid,
      rx_data,              
      rx_data_valid,        
      rx_good_frame,        
      rx_bad_frame,        
      //------------------------------------------------------------------
      //-- Client Transmitter Interface
      //------------------------------------------------------------------
      tx_clk, 
      tx_enable,
    
      tx_ifg_delay,
      tx_statistics_vector,
      tx_statistics_valid,
      tx_data,             
      tx_data_valid,       
      tx_ack,              
      tx_underrun,         
      tx_collision,        
      tx_retransmit,       
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
      
      output [7:0] rx_data;              
      output  rx_data_valid;        
      output  rx_good_frame;        
      output  rx_bad_frame;  
      
      output tx_clk;
      output tx_enable;
     
      input  [7:0] tx_ifg_delay;
      output [31:0] tx_statistics_vector;
      output tx_statistics_valid;
      input  [7:0] tx_data;             
      input  tx_data_valid;       
      output tx_ack;              
      input  tx_underrun;         
      output tx_collision;        
      output tx_retransmit; 
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
  

  wire rgmii_rxc_ibuf;	                 // RGMII Receive clock routed through an IBUFG.
  wire rx_rgmii_clk_int;		 // Internal RGMII receiver clock.
  wire tx_rgmii_clk_int;		 // Internal RGMII transmitter clock.
  wire tx_rgmii_clk90_int;		 // RGMII Clock used to generate rgmii_txc output. 								   
  										   
  wire gmii_tx_en_int;                   // Internal gmii_tx_en signal.
  wire gmii_tx_er_int;                   // Internal gmii_tx_er signal.
  wire [7:0] gmii_txd_int;               // Internal gmii_txd signal.
  wire  gmii_rx_dv_int;                  // gmii_rx_dv_ibuf registered in IOBs.
  wire  gmii_rx_er_int;                  // gmii_rx_er_ibuf registered in IOBs.
  wire  [7:0] gmii_rxd_int;              // gmii_rxd_ibuf registered in IOBs.
         

  wire rx_clk_int;                       // Internal receiver core clock signal
  reg  rx_enable_int;                    // rx_enable signal routed from the MAC to the client loopback design example.  
  
  wire tx_clk_int;                       // Internal transmitter core clock signal.
  wire [7:0] tx_ifg_delay_int;           // Internal tx_ifg_delay signal.
  reg  tx_enable_int;                    // tx_enable signal routed from the MAC to the client loopback design example.
										 


  wire speedis100_int;                   // Asserted when speed is 100Mb/s.
  wire speedis10100_int;                 // Asserted when speed is 10Mb/s or 100Mb/s.
  wire gmii_col_int;                     // Collision signal from the gmii/mii routed through an IBUF.
  wire gmii_crs_int;                     // Carrier Sense signal from the gmii/mii routed through an IBUF.

  //synthesis attribute max_fanout of rx_clk_int is 5000

 
  reg tx_pre_rgmii_reset;
  reg tx_rgmii_reset;
  reg rx_pre_rgmii_reset;
  reg rx_rgmii_reset;

  //synthesis attribute async_reg of tx_pre_rgmii_reset is "true";
  //synthesis attribute async_reg of rx_pre_rgmii_reset is "true";


  reg rxspeedis10100;
  reg txspeedis10100;
  //synthesis attribute async_reg of rxspeedis10100 is "true";
  //synthesis attribute async_reg of txspeedis10100 is "true";
  //synthesis attribute async_reg of rx_enable_int  is "true";
  //synthesis attribute async_reg of tx_enable_int  is "true";
  //synthesis attribute keep of rx_rgmii_clk_int    is "true";
  //synthesis attribute keep of tx_rgmii_clk_int    is "true";

 
   assign rx_enable = rx_enable_int;
   assign tx_enable = tx_enable_int; 
  

 

  //---------------------------------------------------------------------------
  //-- Clock generation circuit. These circuits produce the clocks for 
  //-- 10/100/1000 operation.
  //---------------------------------------------------------------------------
  clk_gen clock_inst
    (.reset(reset),	  
     .speed_is_10_100(speedis10100_int),
     .speed_is_100(speedis100_int),
     .rx_clk(rgmii_rxc_ibuf),
     .clk(gtx_clk),
     .rx_gmii_mii_clk(rx_rgmii_clk_int),
 
     .tx_gmii_mii_clk(tx_rgmii_clk_int),
     .tx_gmii_mii_clk90(tx_rgmii_clk90_int)
  );

  assign rx_clk_int = rx_rgmii_clk_int;
  assign tx_clk_int = tx_rgmii_clk_int;


 
  //---------------------------------------------------------------------------
  // RGMII Interface and Resets
  //--------------------------------------------------------------------------- 
  always @(posedge tx_rgmii_clk_int, posedge reset)
  begin
    if (reset === 1'b1)
    begin
      tx_pre_rgmii_reset <= 1'b1;
      tx_rgmii_reset     <= 1'b1;
    end
    else
    begin
      tx_pre_rgmii_reset <= 1'b0;
      tx_rgmii_reset     <= tx_pre_rgmii_reset;
    end
  end
  always @(posedge rx_rgmii_clk_int, posedge reset)
  begin
    if (reset === 1'b1)
    begin
      rx_pre_rgmii_reset <= 1'b1;
      rx_rgmii_reset     <= 1'b1;
    end
    else
    begin
      rx_pre_rgmii_reset <= 1'b0;
      rx_rgmii_reset     <= rx_pre_rgmii_reset;
    end
  end

  rgmii_v2_0_if rgmii_interface(
        .tx_reset(tx_rgmii_reset),
        .rx_reset(rx_rgmii_reset),  
        .speedis10100(speedis10100_int), 

        .rgmii_txd(rgmii_txd),   
        .rgmii_tx_ctl(rgmii_tx_ctl),   
        .rgmii_txc(rgmii_txc),   
        .rgmii_rxd(rgmii_rxd),   
        .rgmii_rx_ctl(rgmii_rx_ctl),   

        .link_status(inband_link_status),
        .clock_speed(inband_clock_speed),
        .duplex_status(inband_duplex_status),
        
        .txd_from_mac(gmii_txd_int),
        .tx_en_from_mac(gmii_tx_en_int),
        .tx_er_from_mac(gmii_tx_er_int),
        .col_to_mac(gmii_col_int),
        .crs_to_mac(gmii_crs_int),
        .tx_clk(tx_rgmii_clk_int),          // Internal RGMII transmitter clock.
        .tx_clk90(tx_rgmii_clk90_int),      // RGMII Clock used to generate rgmii_txc output.
        .rxd_to_mac(gmii_rxd_int),         
        .rx_dv_to_mac(gmii_rx_dv_int),
        .rx_er_to_mac(gmii_rx_er_int),
        .rx_clk(rx_rgmii_clk_int)     
      );

  //--------------------------------------------------------------------
  // RGMII Receiver Clock Management : receive RX_CLK through IOBs 
  // from RGMII interface
  //-------------------------------------------------------------------
  // Route rgmii_rxc through an IBUFG
  IBUFG ibufg_rgmii_rx_clk  (.I(rgmii_rxc),           .O(rgmii_rxc_ibuf));

  


   always @(posedge rx_rgmii_clk_int or posedge reset)
   begin
     if (reset == 1'b1)
       rxspeedis10100 <= 1'b0;
     else
       rxspeedis10100 <= speedis10100_int;
   end

   always @(posedge tx_rgmii_clk_int or posedge reset)
   begin
     if (reset == 1'b1)
       txspeedis10100 <= 1'b0;
     else
       txspeedis10100 <= speedis10100_int;
   end

   //-- Generate the enables for the MAC.
   always @(posedge rx_rgmii_clk_int or posedge reset)
   begin
     if (reset == 1'b1)
     begin
       rx_enable_int <= 1'b0;
     end
     else
     begin
       if (rxspeedis10100 == 1'b1)
         rx_enable_int <= #1 ~(rx_enable_int);
       else
         rx_enable_int <= 1'b1;
     end
   end
   
   always @(posedge tx_rgmii_clk_int or posedge reset)
   begin
     if (reset == 1'b1)
     begin
       tx_enable_int <= 1'b0;
     end
     else
     begin
       if (txspeedis10100 == 1'b1)
         tx_enable_int <= #1 ~(tx_enable_int);
       else
         tx_enable_int <= 1'b1;
     end
   end

  //----------------------------------------------------------------------
  //-- Instantiate the TRIMAC core
  //----------------------------------------------------------------------
  tri_mode_eth_mac trimac_core( 
      .reset(reset),

      .emacphytxd(gmii_txd_int),
      .emacphytxen(gmii_tx_en_int),
      .emacphytxer(gmii_tx_er_int),
      .phyemaccrs(gmii_crs_int),
      .phyemaccol(gmii_col_int),
      .phyemacrxd(gmii_rxd_int),
      .phyemacrxdv(gmii_rx_dv_int),
      .phyemacrxer(gmii_rx_er_int),
      
      .clientemactxd(tx_data),
      .clientemactxdvld(tx_data_valid),
      .emacclienttxack(tx_ack),
      .clientemactxunderrun(tx_underrun),
      .emacclienttxcollision(tx_collision),
      .emacclienttxretransmit(tx_retransmit),
      .clientemactxifgdelay(tx_ifg_delay_int),
      .clientemactxenable(tx_enable_int),
      .clientemacpausereq(pause_req),
      .clientemacpauseval(pause_val),

      .emacclientrxd(rx_data),
      .emacclientrxdvld(rx_data_valid),
      .emacclientrxgoodframe(rx_good_frame),
      .emacclientrxbadframe(rx_bad_frame),
      .clientemacrxenable(rx_enable_int),
       
      .emacclienttxstats(tx_statistics_vector),
      .emacclienttxstatsvld(tx_statistics_valid),

      .emacclientrxstats(rx_statistics_vector),
      .emacclientrxstatsvld(rx_statistics_valid),
      .tieemacconfigvec(configuration_vector),

      .txgmiimiiclk(tx_rgmii_clk_int),
      .rxgmiimiiclk(rx_rgmii_clk_int),
      .speedis100(speedis100_int),
      .speedis10100(speedis10100_int),      

      .corehassgmii(1'b0)
      );

  

   // Assign the internal receiver clock to the output receiver clock 
   assign rx_clk = rx_clk_int;
 
   // Assign internal transmit clock to output transmit clock   
   assign tx_clk = tx_clk_int;
   
   assign tx_ifg_delay_int = tx_ifg_delay;              
                  
  
endmodule

 
 
//------------------------------------------------------------------------
//-- Title      : Clock generator Top Level
//-- Project    : Tri-Mode Ethernet MAC
//------------------------------------------------------------------------
//-- File       : clk_gen.v
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
//------------------------------------------------------------------------
//-- Description: This file contains the top level for the Tri-Mode 
//--              Ethernet MAC clock module.
//--              3 clocks are generated.   
//--              RX_GMII_MII_CLK and TX_GMII_MII_CLK operate at 125MHz at 
//--              1Gb/s, 25MHz at 100Mb/s and 2.5MHz at 10Mb/s. These are 
//--              used to clock the receiver and transmitter GMII and MII
//--              interfaces. 
//--              A 90 degrees phase shifted version of the CLK input is 
//--              also output (TX_GMII_MII_CLK90) to help produce the correct 
//--              set-up and hold times at the transmitter output. 
//--              The user client interface is also clocked on the non-phase shifted 
//--              clocks but, at 10/100 Mb/s, an enable signal is used to ensure 
//--              that the 8-bit wide client data is only valid every 
//--              second cycle. The enable is set high at 1000 Mb/s.

`timescale 1 ns/1 ps

module clk_gen (
    reset,
    speed_is_10_100,
    speed_is_100,
    rx_clk,
    clk,
    rx_gmii_mii_clk,
    tx_gmii_mii_clk90,
    tx_gmii_mii_clk
    );
  
  input  reset;
  input  speed_is_100;
  input  speed_is_10_100;
  input  rx_clk;
  input  clk;
  output rx_gmii_mii_clk;
  output tx_gmii_mii_clk90;
  output tx_gmii_mii_clk;

  rx_clk_gen receive_clock(
      .reset(reset),
      .speed_is_10_100(speed_is_10_100),
      .rx_clk(rx_clk),
      .rx_gmii_mii_clk(rx_gmii_mii_clk));

  tx_clk_gen transmit_clock(
      .reset(reset),
      .clk(clk),
      .speed_is_10_100(speed_is_10_100),
      .speed_is_100(speed_is_100),
 
      .tx_gmii_mii_clk(tx_gmii_mii_clk),
      .tx_gmii_mii_clk90(tx_gmii_mii_clk90)
  );
  

endmodule

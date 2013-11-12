//------------------------------------------------------------------------
//-- Title      : Transmitter Clock Generator
//-- Project    : Tri-Mode Ethernet MAC
//------------------------------------------------------------------------
//-- File       : tx_clk_gen.v
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
//-- Description:  This module takes CLK (GTX_CLK from top level) and generates
//--               the clocks needed to run the TX portion of the EMAC.
//--   The input CLK is 125MHZ and the following clocks are derived for 
//--   the various medium speeds:
//--  
//--                            1G ethernet     100 Mb        10 Mb
//--              CLK           125   MHz       125  MHz      125  Mhz
//--              GMII/MII CLK  125   MHZ       25   MHZ      2.5   MHZ
//-------------------------------------------------------------------------------

`timescale 1 ns/1 ps

module tx_clk_gen
  (reset,
   clk,
   speed_is_10_100,
   speed_is_100,
         
   tx_gmii_mii_clk,
   tx_gmii_mii_clk90
  );

  input  reset;
  input  clk;
  input  speed_is_10_100;
  input  speed_is_100;
  output tx_gmii_mii_clk;
  output tx_gmii_mii_clk90;
  wire clk_25mhz;
  wire clk_2_5mhz;
  wire clk_12_5mhz;

  wire tx_clk0;
  wire tx_clk90;
  wire tx_clk180;
 
  reg  tx_ce_reg;
  wire tx_ce;
  reg  tx_ce_reg_f;
  wire tx_ce_f;
  reg  tx_speed_is_100;

  reg  speed_sel_tx_mii_clk;
  reg  speed_sel_tx_mii_clk_reg;

  reg r1, r2, r3, reset_s;


  //synthesis attribute ASYNC_REG of tx_speed_is_100 is "TRUE";
  //synthesis attribute ASYNC_REG of r1 is "TRUE";
  //synthesis attribute ASYNC_REG of r2 is "TRUE";
  //synthesis attribute ASYNC_REG of r3 is "TRUE";
  //synthesis attribute ASYNC_REG of reset_s is "TRUE";

  // Generate a synchronous reset
  always @(posedge clk, posedge reset)
  begin
    if (reset == 1'b1)
    begin
      r1 <= 1'b1;
      r2 <= 1'b1;
      r3 <= 1'b1;
      reset_s <= 1'b1;
    end	 
    else
    begin  
      r1 <= 1'b0;
      r2 <= r1;
      r3 <= r2;
      reset_s <= r3;    
    end   
  end

  //-- Use a DCM to generate the 2ns set-up and hold time
  //-- at the transmitter output at 1000Mb/s
  DCM RGMII_TX_DCM ( 
         .CLKIN(clk),
         .CLKFB(tx_clk0),
         .DSSEN(1'b0),
         .PSINCDEC(1'b0),
         .PSEN(1'b0),
         .PSCLK(1'b0),
         .RST(reset_s),
         .CLK0(tx_clk0),
         .CLK90(tx_clk90),
         .CLK180(tx_clk180),
         .CLK270(),
         .CLK2X(),
         .CLK2X180(),
         .CLKDV(),
         .CLKFX(),
         .CLKFX180(),
         .PSDONE(),
         .STATUS(),
         .LOCKED());

  //-- From 125Mhz, generated 25Mhz, 2.5Mhz, 12.5Mhz and 1.25Mhz

  johnson_cntr ethernet_clk_100mhz_gen
    (.reset(reset_s),
     .clk(tx_clk180),
     .clk_div10(clk_12_5mhz),
     .clk_div5(clk_25mhz),
     .ce_r(1'b1),
     .ce_f(1'b1));

  always @(posedge tx_clk180, posedge reset_s)
  begin
    if (reset_s == 1'b1) 
      tx_ce_reg <= 1'b0;
    else
      tx_ce_reg <= clk_12_5mhz;
  end

  assign tx_ce = clk_12_5mhz & ~(tx_ce_reg);

  always @(negedge tx_clk180, posedge reset_s)
  begin
    if (reset_s == 1'b1) 
      tx_ce_reg_f <= 1'b0;
    else
      tx_ce_reg_f <= clk_12_5mhz;
  end

  assign tx_ce_f = ~(clk_12_5mhz) & tx_ce_reg_f;

  johnson_cntr ethernet_clk_10mhz_gen
    (.reset(reset_s),
     .clk(tx_clk180),
     .clk_div10(),
     .clk_div5(clk_2_5mhz),
     .ce_r(tx_ce),
     .ce_f(tx_ce_f));

//-- Select between the johnson counter outputs depending on the 
//-- state of the SPEED_IS_100 line.
  always @(posedge tx_clk180)
  begin
      tx_speed_is_100 <= speed_is_100;
  end
  
  always @(clk_2_5mhz, clk_25mhz, tx_speed_is_100)
  begin
    if (tx_speed_is_100 == 1'b0)
      speed_sel_tx_mii_clk <= clk_2_5mhz;
    else
      speed_sel_tx_mii_clk <= clk_25mhz;
  end

  always @(posedge tx_clk180, posedge reset_s)
  begin
    if (reset_s == 1'b1) 
      speed_sel_tx_mii_clk_reg <= 1'b0;
    else
      speed_sel_tx_mii_clk_reg <= ~(speed_sel_tx_mii_clk);
  end


//-- Now generate the clocks based on speed of 10/100 or 1000. 
//-- If 10/100, take the Johnson counter generated clock
//-- If 1000, take the clock from GTX_CLK

  BUFGMUX BUFGMUX_SPEED_CLK
    (.O(tx_gmii_mii_clk),
     .I0(tx_clk0),
     .I1(speed_sel_tx_mii_clk_reg),
     .S(speed_is_10_100));


//-- To maintain the 2ns set-up and hold requirement we need to use the 90 
//-- degrees out of phase clock output to generate the rgmii_txc output.

 
  BUFGMUX BUFGMUXCLK90
    (.I0(tx_clk90),
     .I1(speed_sel_tx_mii_clk),
     .S(speed_is_10_100),
     .O(tx_gmii_mii_clk90));
      


endmodule


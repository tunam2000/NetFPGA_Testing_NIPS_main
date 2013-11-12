//-- Title      : Clock generator 
//-- Project    : 
//-------------------------------------------------------------------------------
//-- File       : Johnson_cntr.v
//-- Author     : Xilinx
//-------------------------------------------------------------------------------
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
//-- Description:
//-- If trimode, input GTX_CLK is always 125MHz.
//-- The clocks for running the core and GMII/MII interface are generated
//-- from the 125Mhz and selected by register bits.
//-- Johnson coutner generates CLK/5 and CLK/10 from CLK and are used
//-- when the EMAC core is running at either 10Mbps or 100Mbps.
//-- CLK/5 is used by GMII/MII interface
//-- CLK/10 is used by EMAC core. 
//-- 

`timescale 1 ns/1 ps

module johnson_cntr
  ( reset,
    clk,
    clk_div10,
    clk_div5,
    ce_r,
    ce_f
    );

  input  reset;
  input  clk;
  output clk_div10;
  output clk_div5;
  input  ce_r;
  input  ce_f;

  reg  reg1_out;
  reg  reg2_out;
  reg  reg3_out;
  reg  reg3_falling_out;
  reg  reg4_out;
  reg  reg5_out;
  wire reg5_out_inv;
  
  always @(posedge clk or posedge reset)
  begin
    if (reset == 1'b1)
      reg1_out    <= 1'b0;
    else if (ce_r == 1'b1)
      reg1_out    <= reg5_out_inv;
  end

  always @(posedge clk or posedge reset)
  begin
    if (reset == 1'b1)
      reg2_out    <= 1'b0;
    else if (ce_r == 1'b1)
      reg2_out    <= reg1_out;
  end

  always @(posedge clk or posedge reset)
  begin
    if (reset == 1'b1)
      reg3_out    <= 1'b0;
    else if (ce_r == 1'b1)
      reg3_out    <= reg2_out;
  end

  always @(negedge clk or posedge reset)
  begin
    if (reset == 1'b1)
      reg3_falling_out    <= 1'b0;
    else if (ce_f == 1'b1)
      reg3_falling_out    <= reg3_out;
  end

  always @(posedge clk or posedge reset)
  begin
    if (reset == 1'b1)
      reg4_out    <= 1'b0;
    else if (ce_r == 1'b1)
      reg4_out    <= reg3_out;
  end

  always @(posedge clk or posedge reset)
  begin
    if (reset == 1'b1)
      reg5_out    <= 1'b0;
    else if (ce_r == 1'b1)
      reg5_out    <= reg4_out;
  end

  assign reg5_out_inv = ~(reg5_out);

  assign clk_div5     = reg1_out ^ reg3_falling_out;        
  assign clk_div10    = reg3_out;

endmodule





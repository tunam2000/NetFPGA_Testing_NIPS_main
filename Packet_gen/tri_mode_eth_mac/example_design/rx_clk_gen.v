 
 
 
//------------------------------------------------------------------------
//-- Title      : RX Clock generator 
//-- Project    : Tri-Mode Ethernet MAC
//------------------------------------------------------------------------
//-- File       : rx_clk_gen.v
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
//-- Description:  This module routes the rx_clk from the phy chip 
//--               (via a bufg) onto the rx_gmii_mii_clk line.
//--               A DCM is used to shift the input clock to ensure that 
//--               the set-up and hold times are observed.

`timescale 1 ns/1 ps

module rx_clk_gen
  (reset,
   speed_is_10_100,
   rx_clk,
   rx_gmii_mii_clk
  );

  input  reset;
  input  speed_is_10_100;
  input  rx_clk;	
  output rx_gmii_mii_clk;

  wire rx_clk0;
  wire rx_gmii_mii_clk_int;
  wire dcm_reset;
  wire dcm_locked;               // locked wire from DCM. 
  reg  dcm_locked_reg1;          // dcm_locked registered once. 
  reg  dcm_locked_reg2;          // dcm_locked registered twice.  
  reg  dcm_locked_reg3;          // dcm_locked registered thrice.  
  reg  dcm_reset1;               // Automatic reset pulse applied to DCM on loss of lock. 
  reg  dcm_reset2;               // dcm_reset1 registered once.  
  reg  dcm_reset3;               // dcm_reset1 registered twice.  
  reg  dcm_reset_lost_lock;      // A reset pulse for the DCM, 3 clocks in duration. 
  
  // synthesis attribute async_reg of dcm_locked_reg1 is "true";
  // synthesis attribute async_reg of dcm_locked_reg2 is "true";
  // synthesis attribute async_reg of dcm_locked_reg3 is "true";

  

   // A DCM must be used to meet the GMII input setup
   // and hold specifications.
   // Note: Phase shift is set in UCF file. 
   DCM gmii_rxc_dcm ( 
         .CLKIN(rx_clk),
         .CLKFB(rx_gmii_mii_clk_int),
         .DSSEN(1'b0),
         .PSINCDEC(1'b0),
         .PSEN(1'b0),
         .PSCLK(1'b0),
         .RST(dcm_reset),
         .CLK0(rx_clk0),
         .CLK90(),
         .CLK180(),
         .CLK270(),
         .CLK2X(),
         .CLK2X180(),
         .CLKDV(),
         .CLKFX(),
         .CLKFX180(),
         .PSDONE(),
         .STATUS(),
         .LOCKED(dcm_locked));

   BUFGMUX bufg_gmii_rx_clk (
         .I0(rx_clk0),
         .I1(rx_clk),
         .S(speed_is_10_100),
         .O(rx_gmii_mii_clk_int));

   // Babysitting circuit to reset DCM after it becomes unlocked.  
   // dcm_locked is an asynchronous signal. This logic detects the falling edge.
   always @ (posedge rx_clk or posedge reset)
   begin
     if (reset)
     begin		 
       dcm_locked_reg1     <= 1'b0;  // automatic logic is set to be active.
       dcm_locked_reg2     <= 1'b0;
       dcm_locked_reg3     <= 1'b1;
       dcm_reset1          <= 1'b1;
       dcm_reset2          <= 1'b1;
       dcm_reset3          <= 1'b1;
       dcm_reset_lost_lock <= 1'b1;
     end
     else
     begin		 
       dcm_locked_reg1     <= dcm_locked;
       dcm_locked_reg2     <= dcm_locked_reg1;
       dcm_locked_reg3     <= dcm_locked_reg2;
       dcm_reset1          <= !dcm_locked_reg1 & !dcm_locked_reg2 & dcm_locked_reg3;
       dcm_reset2          <= dcm_reset1;
       dcm_reset3          <= dcm_reset2;
       dcm_reset_lost_lock <= dcm_reset1 | dcm_reset2 | dcm_reset3;
     end
   end

   assign dcm_reset       = reset | speed_is_10_100 | dcm_reset_lost_lock;
   assign rx_gmii_mii_clk = rx_gmii_mii_clk_int;                     


  

endmodule

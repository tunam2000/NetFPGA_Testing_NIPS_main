/* $Revision: 1.1.2.1 $ $Date: 2007/05/14 13:57:05 $
 * Title       : Verilog component declaration for tri_mode_eth_mac (the tri-mode MAC core)
 * Project     : Tri-Mode Ethernet MAC Core
 * File        : tri_mode_eth_mac_mod.v
 * Author      : Xilinx Inc.
 * Description : This module holds the Verilog component declaration for tri_mode_eth_mac 
 * (the Tri-Mode MAC core).
 * Copyright (c) 2004-2007 by Xilinx, Inc. All rights reserved.
 * This text/file contains proprietary, confidential
 * information of Xilinx, Inc., is distributed under license
 * from Xilinx, Inc., and may be used, copied and/or
 * disclosed only pursuant to the terms of a valid license
 * agreement with Xilinx, Inc. Xilinx hereby grants you
 * a license to use this text/file solely for design, simulation,
 * implementation and creation of design files limited
 * to Xilinx devices or technologies. Use with non-Xilinx
 * devices or technologies is expressly prohibited and
 * immediately terminates your license unless covered by
 * a separate agreement.
 * 
 * Xilinx is providing this design, code, or information
 * "as is" solely for use in developing programs and
 * solutions for Xilinx devices. By providing this design,
 * code, or information as one possible implementation of
 * this feature, application or standard, Xilinx is making no
 * representation that this implementation is free from any
 * claims of infringement. You are responsible for
 * obtaining any rights you may require for your implementation.
 * Xilinx expressly disclaims any warranty whatsoever with
 * respect to the adequacy of the implementation, including
 * but not limited to any warranties or representations that this
 * implementation is free from claims of infringement, implied
 * warranties of merchantability or fitness for a particular
 * purpose.
 * 
 * Xilinx products are not intended for use in life support
 * appliances, devices, or systems. Use in such applications are
 * expressly prohibited.
 * 
 * This copyright and support notice must be retained as part
 * of this text at all times. (c) Copyright 2004-2007 Xilinx, Inc.
 * All rights reserved.
 */


/****************************************************************************
 * Component Declaration for trimac (the Tri-Mode MAC core).
 ****************************************************************************/
 module tri_mode_eth_mac
    ( reset,
      emacphytxd,
      emacphytxen,
      emacphytxer,
      phyemaccrs,
      phyemaccol,
      phyemacrxd,
      phyemacrxdv,
      phyemacrxer,
      
      clientemactxd,
      clientemactxdvld,
      emacclienttxack,
      clientemactxunderrun,
      emacclienttxcollision,
      emacclienttxretransmit,
      clientemactxifgdelay,
      clientemacpausereq,
      clientemacpauseval,
      clientemactxenable,

      emacclientrxd,
      emacclientrxdvld,
      emacclientrxgoodframe,
      emacclientrxbadframe,
      clientemacrxenable,
       
      emacclienttxstats,
      emacclienttxstatsvld,

      emacclientrxstats,
      emacclientrxstatsvld,
      tieemacconfigvec,

      txgmiimiiclk,
      rxgmiimiiclk,
      speedis100,
      speedis10100,      

      corehassgmii
      );

  // Port declarations

  input           reset;

  output [7:0]    emacphytxd;
  output          emacphytxen;
  output          emacphytxer;
  input           phyemaccrs;
  input           phyemaccol;
  input [7:0]     phyemacrxd;
  input           phyemacrxdv;
  input           phyemacrxer;
      
  input [7:0]     clientemactxd;
  input           clientemactxdvld;
  output          emacclienttxack;
  input           clientemactxunderrun;
  output          emacclienttxcollision;
  output          emacclienttxretransmit;
  input [7:0]     clientemactxifgdelay;
  input           clientemacpausereq;
  input [15:0]    clientemacpauseval;
  input           clientemactxenable;

  output [7:0]    emacclientrxd;
  output          emacclientrxdvld;
  output          emacclientrxgoodframe;
  output          emacclientrxbadframe;
  input           clientemacrxenable;
       
  output [31:0]   emacclienttxstats;
  output          emacclienttxstatsvld;

  output [27:0]   emacclientrxstats;
  output          emacclientrxstatsvld;
  input [66:0]    tieemacconfigvec;

  input           txgmiimiiclk;
  input           rxgmiimiiclk;
  output          speedis100;
  output          speedis10100;      

  input            corehassgmii;

endmodule // tri_mode_eth_mac  
   

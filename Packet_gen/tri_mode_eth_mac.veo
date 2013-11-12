/*******************************************************************************
*     This file is owned and controlled by Xilinx and must be used             *
*     solely for design, simulation, implementation and creation of            *
*     design files limited to Xilinx devices or technologies. Use              *
*     with non-Xilinx devices or technologies is expressly prohibited          *
*     and immediately terminates your license.                                 *
*                                                                              *
*     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"            *
*     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                  *
*     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION          *
*     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION              *
*     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS                *
*     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                  *
*     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE         *
*     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY                 *
*     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                  *
*     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR           *
*     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF          *
*     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS          *
*     FOR A PARTICULAR PURPOSE.                                                *
*                                                                              *
*     Xilinx products are not intended for use in life support                 *
*     appliances, devices, or systems. Use in such applications are            *
*     expressly prohibited.                                                    *
*                                                                              *
*     (c) Copyright 1995-2007 Xilinx, Inc.                                     *
*     All rights reserved.                                                     *
*******************************************************************************/
// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
tri_mode_eth_mac YourInstanceName (
	.reset(reset),
	.emacphytxd(emacphytxd), // Bus [7 : 0] 
	.emacphytxen(emacphytxen),
	.emacphytxer(emacphytxer),
	.phyemaccrs(phyemaccrs),
	.phyemaccol(phyemaccol),
	.phyemacrxd(phyemacrxd), // Bus [7 : 0] 
	.phyemacrxdv(phyemacrxdv),
	.phyemacrxer(phyemacrxer),
	.clientemactxd(clientemactxd), // Bus [7 : 0] 
	.clientemactxdvld(clientemactxdvld),
	.emacclienttxack(emacclienttxack),
	.clientemactxunderrun(clientemactxunderrun),
	.emacclienttxcollision(emacclienttxcollision),
	.emacclienttxretransmit(emacclienttxretransmit),
	.clientemactxifgdelay(clientemactxifgdelay), // Bus [7 : 0] 
	.clientemactxenable(clientemactxenable),
	.clientemacpausereq(clientemacpausereq),
	.clientemacpauseval(clientemacpauseval), // Bus [15 : 0] 
	.emacclientrxd(emacclientrxd), // Bus [7 : 0] 
	.emacclientrxdvld(emacclientrxdvld),
	.emacclientrxgoodframe(emacclientrxgoodframe),
	.emacclientrxbadframe(emacclientrxbadframe),
	.clientemacrxenable(clientemacrxenable),
	.emacclienttxstats(emacclienttxstats), // Bus [31 : 0] 
	.emacclienttxstatsvld(emacclienttxstatsvld),
	.emacclientrxstats(emacclientrxstats), // Bus [27 : 0] 
	.emacclientrxstatsvld(emacclientrxstatsvld),
	.tieemacconfigvec(tieemacconfigvec), // Bus [66 : 0] 
	.txgmiimiiclk(txgmiimiiclk),
	.rxgmiimiiclk(rxgmiimiiclk),
	.speedis100(speedis100),
	.speedis10100(speedis10100),
	.corehassgmii(corehassgmii));

// INST_TAG_END ------ End INSTANTIATION Template ---------

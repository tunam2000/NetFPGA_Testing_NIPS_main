 
 
//----------------------------------------------------------------------
// $Revision: 1.1.2.1 $ $Date: 2007/05/14 13:57:04 $
// Title      : Demo testbench
// Project    : Tri-Mode Ethernet MAC
//----------------------------------------------------------------------
// File       : demo_tb.v
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
//------------------------------------------------------------------------
// Description: This testbench will exercise the ports of the MAC core
//              to demonstrate the functionality.
//----------------------------------------------------------------------
//
// This testbench performs the following operations on the MAC core 
// and its design example:


//  - Four frames are then pushed into the receiver from the PHY 
//    interface (GMII/MII or RGMII):
//    The first is of minimum length (Length/Type = Length = 46 bytes).
//    The second frame sets Length/Type to Type = 0x8000. 
//    The third frame has an error inserted. 
//    The fourth frame only sends 4 bytes of data: the remainder of the 
//    data field is padded up to the minimum frame length i.e. 46 bytes.

//  - These frames are then parsed from the MAC into the MAC's design
//    example.  The design example provides a MAC client loopback 
//    function so that frames which are received without error will be 
//    looped back to the MAC transmitter and transmitted back to the
//    testbench.  The testbench verifies that this data matches that 
//    previously injected into the receiver.

//  - The four frames are then re-sent at both 100Mb/s and 10Mb/s. 

/*----------------------------------------------------------------------
--                         DEMONSTRATION TESTBENCH                     |
--                                                                     |
--                                                                     |
--     ----------------------------------------------                  |
--     |           TOP LEVEL WRAPPER (DUT)          |                  |
--     |  -------------------    ----------------   |                  |
--     |  | CLIENT LOOPBACK |    | TRI-MODE     |   |                  |
--     |  | DESIGN EXAMPLE  |    | ETHERNET MAC |   |                  |
--     |  |                 |    | CORE         |   |                  |
--     |  |                 |    |              |   |       Monitor    |
--     |  |         ------->|--->|          Tx  |-------->  Frames     |   	    
--     |  |         |       |    |          PHY |   |                  |    
--     |  |         |       |    |          I/F |   |                  |
--     |  |         |       |    |              |   |                  |
--     |  |         |       |    |              |   |                  |
--     |  |         |       |    |              |   |                  |
--     |  |         |       |    |          Rx  |   |                  |
--     |  |         |       |    |          PHY |   |                  |   
--     |  |         --------|<---|          I/F |<-------- Generate    |
--     |  |                 |    |              |   |      Frames      |
--     |  -------------------    ----------------   |                  |
--     --------------------------------^-------------                  |
--                                     |                               |
--                                     |                               |
--                                 Stimulate                           |
--                               Management I/F                        |
--                               (if present)                          |
--                                                                     |
------------------------------------------------------------------------
*/


`timescale 1ps / 1ps




// This module abstracts the frame data for simpler manipulation
module frame_typ;

   // data field
   reg [7:0]  data  [0:61];
   reg        valid [0:61];
   reg        error [0:61];

   // Indicate to the testbench that the frame contains an error
   reg        bad_frame;    

`define FRAME_TYP [8*62+62+62+8*4+4+4+8*4+4+4+1:1]

   reg `FRAME_TYP bits;

   function `FRAME_TYP tobits;
      input dummy;
      begin
	  bits = {data[ 0],  data[ 1],  data[ 2],  data[ 3],  data[ 4],
	  	      data[ 5],  data[ 6],  data[ 7],  data[ 8],  data[ 9],
	  	      data[10],  data[11],  data[12],  data[13],  data[14],
	  	      data[15],  data[16],  data[17],  data[18],  data[19],
	  	      data[20],  data[21],  data[22],  data[23],  data[24],
	  	      data[25],  data[26],  data[27],  data[28],  data[29],
	  	      data[30],  data[31],  data[32],  data[33],  data[34], 
	  	      data[35],  data[36],  data[37],  data[38],  data[39], 
	  	      data[40],  data[41],  data[42],  data[43],  data[44], 
	  	      data[45],  data[46],  data[47],  data[48],  data[49], 
	  	      data[50],  data[51],  data[52],  data[53],  data[54], 
	  	      data[55],  data[56],  data[57],  data[58],  data[59], 
	  	      data[60],  data[61],
	  	       
	          valid[ 0], valid[ 1], valid[ 2], valid[ 3], valid[ 4],
	  	      valid[ 5], valid[ 6], valid[ 7], valid[ 8], valid[ 9],
	  	      valid[10], valid[11], valid[12], valid[13], valid[14],
	  	      valid[15], valid[16], valid[17], valid[18], valid[19],
	  	      valid[20], valid[21], valid[22], valid[23], valid[24],
	  	      valid[25], valid[26], valid[27], valid[28], valid[29],
	  	      valid[30], valid[31], valid[32], valid[33], valid[34], 
	  	      valid[35], valid[36], valid[37], valid[38], valid[39], 
	  	      valid[40], valid[41], valid[42], valid[43], valid[44], 
	  	      valid[45], valid[46], valid[47], valid[48], valid[49], 
	  	      valid[50], valid[51], valid[52], valid[53], valid[54], 
	  	      valid[55], valid[56], valid[57], valid[58], valid[59], 
	  	      valid[60], valid[61], 
	  	       
	          error[ 0], error[ 1], error[ 2], error[ 3], error[ 4],
	  	      error[ 5], error[ 6], error[ 7], error[ 8], error[ 9],
	  	      error[10], error[11], error[12], error[13], error[14],
	  	      error[15], error[16], error[17], error[18], error[19],
	  	      error[20], error[21], error[22], error[23], error[24],
	  	      error[25], error[26], error[27], error[28], error[29],
	  	      error[30], error[31], error[32], error[33], error[34], 
	  	      error[35], error[36], error[37], error[38], error[39], 
	  	      error[40], error[41], error[42], error[43], error[44], 
	  	      error[45], error[46], error[47], error[48], error[49], 
	  	      error[50], error[51], error[52], error[53], error[54], 
	  	      error[55], error[56], error[57], error[58], error[59], 
	  	      error[60], error[61], 
	  	      
	  	      bad_frame};
	  tobits = bits;
      end
   endfunction // tobits

   task frombits;
      input `FRAME_TYP frame;
      begin
	  bits = frame;
	         {data[ 0],  data[ 1],  data[ 2],  data[ 3],  data[ 4],
	  	      data[ 5],  data[ 6],  data[ 7],  data[ 8],  data[ 9],
	  	      data[10],  data[11],  data[12],  data[13],  data[14],
	  	      data[15],  data[16],  data[17],  data[18],  data[19],
	  	      data[20],  data[21],  data[22],  data[23],  data[24],
	  	      data[25],  data[26],  data[27],  data[28],  data[29],
	  	      data[30],  data[31],  data[32],  data[33],  data[34], 
	  	      data[35],  data[36],  data[37],  data[38],  data[39], 
	  	      data[40],  data[41],  data[42],  data[43],  data[44], 
	  	      data[45],  data[46],  data[47],  data[48],  data[49], 
	  	      data[50],  data[51],  data[52],  data[53],  data[54], 
	  	      data[55],  data[56],  data[57],  data[58],  data[59], 
	  	      data[60],  data[61],
	  	       
	          valid[ 0], valid[ 1], valid[ 2], valid[ 3], valid[ 4],
	  	      valid[ 5], valid[ 6], valid[ 7], valid[ 8], valid[ 9],
	  	      valid[10], valid[11], valid[12], valid[13], valid[14],
	  	      valid[15], valid[16], valid[17], valid[18], valid[19],
	  	      valid[20], valid[21], valid[22], valid[23], valid[24],
	  	      valid[25], valid[26], valid[27], valid[28], valid[29],
	  	      valid[30], valid[31], valid[32], valid[33], valid[34], 
	  	      valid[35], valid[36], valid[37], valid[38], valid[39], 
	  	      valid[40], valid[41], valid[42], valid[43], valid[44], 
	  	      valid[45], valid[46], valid[47], valid[48], valid[49], 
	  	      valid[50], valid[51], valid[52], valid[53], valid[54], 
	  	      valid[55], valid[56], valid[57], valid[58], valid[59], 
	  	      valid[60], valid[61], 
	  	       
	          error[ 0], error[ 1], error[ 2], error[ 3], error[ 4],
	  	      error[ 5], error[ 6], error[ 7], error[ 8], error[ 9],
	  	      error[10], error[11], error[12], error[13], error[14],
	  	      error[15], error[16], error[17], error[18], error[19],
	  	      error[20], error[21], error[22], error[23], error[24],
	  	      error[25], error[26], error[27], error[28], error[29],
	  	      error[30], error[31], error[32], error[33], error[34], 
	  	      error[35], error[36], error[37], error[38], error[39], 
	  	      error[40], error[41], error[42], error[43], error[44], 
	  	      error[45], error[46], error[47], error[48], error[49], 
	  	      error[50], error[51], error[52], error[53], error[54], 
	  	      error[55], error[56], error[57], error[58], error[59], 
	  	      error[60], error[61],
	  	      
	  	      bad_frame} = bits;
      end
   endtask // frombits
   
endmodule // frame_typ




// This module is the demonstration testbench
module testbench;


  //--------------------------------------------------------------------
  // types to support frame data
  //--------------------------------------------------------------------

   frame_typ frame0();
   frame_typ frame1();
   frame_typ frame2();
   frame_typ frame3();

   frame_typ rx_stimulus_working_frame();
   frame_typ tx_monitor_working_frame();


  //--------------------------------------------------------------------
  // Stimulus - Frame data 
  //--------------------------------------------------------------------
  // The following constant holds the stimulus for the testbench. It is 
  // an ordered array of frames, with frame 0 the first to be injected 
  // into the core transmit interface by the testbench. 
  //--------------------------------------------------------------------
  initial
  begin
    //-----------
    // Frame 0
    //-----------
    frame0.data[0]  = 8'hDA;  frame0.valid[0]  = 1'b1;  frame0.error[0]  = 1'b0; // Destination Address (DA) 
    frame0.data[1]  = 8'h02;  frame0.valid[1]  = 1'b1;  frame0.error[1]  = 1'b0;
    frame0.data[2]  = 8'h03;  frame0.valid[2]  = 1'b1;  frame0.error[2]  = 1'b0;
    frame0.data[3]  = 8'h04;  frame0.valid[3]  = 1'b1;  frame0.error[3]  = 1'b0;
    frame0.data[4]  = 8'h05;  frame0.valid[4]  = 1'b1;  frame0.error[4]  = 1'b0;
    frame0.data[5]  = 8'h06;  frame0.valid[5]  = 1'b1;  frame0.error[5]  = 1'b0;
    frame0.data[6]  = 8'h5A;  frame0.valid[6]  = 1'b1;  frame0.error[6]  = 1'b0; // Source Address	(5A)
    frame0.data[7]  = 8'h02;  frame0.valid[7]  = 1'b1;  frame0.error[7]  = 1'b0; 
    frame0.data[8]  = 8'h03;  frame0.valid[8]  = 1'b1;  frame0.error[8]  = 1'b0; 
    frame0.data[9]  = 8'h04;  frame0.valid[9]  = 1'b1;  frame0.error[9]  = 1'b0;
    frame0.data[10] = 8'h05;  frame0.valid[10] = 1'b1;  frame0.error[10] = 1'b0;
    frame0.data[11] = 8'h06;  frame0.valid[11] = 1'b1;  frame0.error[11] = 1'b0;
    frame0.data[12] = 8'h00;  frame0.valid[12] = 1'b1;  frame0.error[12] = 1'b0;
    frame0.data[13] = 8'h2E;  frame0.valid[13] = 1'b1;  frame0.error[13] = 1'b0; // Length/Type = Length = 46
    frame0.data[14] = 8'h01;  frame0.valid[14] = 1'b1;  frame0.error[14] = 1'b0;  
    frame0.data[15] = 8'h02;  frame0.valid[15] = 1'b1;  frame0.error[15] = 1'b0;
    frame0.data[16] = 8'h03;  frame0.valid[16] = 1'b1;  frame0.error[16] = 1'b0;
    frame0.data[17] = 8'h04;  frame0.valid[17] = 1'b1;  frame0.error[17] = 1'b0;
    frame0.data[18] = 8'h05;  frame0.valid[18] = 1'b1;  frame0.error[18] = 1'b0;
    frame0.data[19] = 8'h06;  frame0.valid[19] = 1'b1;  frame0.error[19] = 1'b0;
    frame0.data[20] = 8'h07;  frame0.valid[20] = 1'b1;  frame0.error[20] = 1'b0; 
    frame0.data[21] = 8'h08;  frame0.valid[21] = 1'b1;  frame0.error[21] = 1'b0; 
    frame0.data[22] = 8'h09;  frame0.valid[22] = 1'b1;  frame0.error[22] = 1'b0;
    frame0.data[23] = 8'h0A;  frame0.valid[23] = 1'b1;  frame0.error[23] = 1'b0; 
    frame0.data[24] = 8'h0B;  frame0.valid[24] = 1'b1;  frame0.error[24] = 1'b0;
    frame0.data[25] = 8'h0C;  frame0.valid[25] = 1'b1;  frame0.error[25] = 1'b0;
    frame0.data[26] = 8'h0D;  frame0.valid[26] = 1'b1;  frame0.error[26] = 1'b0;
    frame0.data[27] = 8'h0E;  frame0.valid[27] = 1'b1;  frame0.error[27] = 1'b0;
    frame0.data[28] = 8'h0F;  frame0.valid[28] = 1'b1;  frame0.error[28] = 1'b0;
    frame0.data[29] = 8'h10;  frame0.valid[29] = 1'b1;  frame0.error[29] = 1'b0;
    frame0.data[30] = 8'h11;  frame0.valid[30] = 1'b1;  frame0.error[30] = 1'b0;
    frame0.data[31] = 8'h12;  frame0.valid[31] = 1'b1;  frame0.error[31] = 1'b0;
    frame0.data[32] = 8'h13;  frame0.valid[32] = 1'b1;  frame0.error[32] = 1'b0;
    frame0.data[33] = 8'h14;  frame0.valid[33] = 1'b1;  frame0.error[33] = 1'b0;
    frame0.data[34] = 8'h15;  frame0.valid[34] = 1'b1;  frame0.error[34] = 1'b0;
    frame0.data[35] = 8'h16;  frame0.valid[35] = 1'b1;  frame0.error[35] = 1'b0;
    frame0.data[36] = 8'h17;  frame0.valid[36] = 1'b1;  frame0.error[36] = 1'b0;
    frame0.data[37] = 8'h18;  frame0.valid[37] = 1'b1;  frame0.error[37] = 1'b0;
    frame0.data[38] = 8'h19;  frame0.valid[38] = 1'b1;  frame0.error[38] = 1'b0;
    frame0.data[39] = 8'h1A;  frame0.valid[39] = 1'b1;  frame0.error[39] = 1'b0;
    frame0.data[40] = 8'h1B;  frame0.valid[40] = 1'b1;  frame0.error[40] = 1'b0;
    frame0.data[41] = 8'h1C;  frame0.valid[41] = 1'b1;  frame0.error[41] = 1'b0;
    frame0.data[42] = 8'h1D;  frame0.valid[42] = 1'b1;  frame0.error[42] = 1'b0;
    frame0.data[43] = 8'h1E;  frame0.valid[43] = 1'b1;  frame0.error[43] = 1'b0;
    frame0.data[44] = 8'h1F;  frame0.valid[44] = 1'b1;  frame0.error[44] = 1'b0; 
    frame0.data[45] = 8'h20;  frame0.valid[45] = 1'b1;  frame0.error[45] = 1'b0;
    frame0.data[46] = 8'h21;  frame0.valid[46] = 1'b1;  frame0.error[46] = 1'b0;
    frame0.data[47] = 8'h22;  frame0.valid[47] = 1'b1;  frame0.error[47] = 1'b0;
    frame0.data[48] = 8'h23;  frame0.valid[48] = 1'b1;  frame0.error[48] = 1'b0;
    frame0.data[49] = 8'h24;  frame0.valid[49] = 1'b1;  frame0.error[49] = 1'b0;
    frame0.data[50] = 8'h25;  frame0.valid[50] = 1'b1;  frame0.error[50] = 1'b0;
    frame0.data[51] = 8'h26;  frame0.valid[51] = 1'b1;  frame0.error[51] = 1'b0; 
    frame0.data[52] = 8'h27;  frame0.valid[52] = 1'b1;  frame0.error[52] = 1'b0;
    frame0.data[53] = 8'h28;  frame0.valid[53] = 1'b1;  frame0.error[53] = 1'b0; 
    frame0.data[54] = 8'h29;  frame0.valid[54] = 1'b1;  frame0.error[54] = 1'b0;
    frame0.data[55] = 8'h2A;  frame0.valid[55] = 1'b1;  frame0.error[55] = 1'b0;
    frame0.data[56] = 8'h2B;  frame0.valid[56] = 1'b1;  frame0.error[56] = 1'b0;
    frame0.data[57] = 8'h2C;  frame0.valid[57] = 1'b1;  frame0.error[57] = 1'b0;
    frame0.data[58] = 8'h2D;  frame0.valid[58] = 1'b1;  frame0.error[58] = 1'b0;
    frame0.data[59] = 8'h2E;  frame0.valid[59] = 1'b1;  frame0.error[59] = 1'b0;	// 46th Byte of Data
    // unused
    frame0.data[60] = 8'h00;  frame0.valid[60] = 1'b0;  frame0.error[60] = 1'b0;
    frame0.data[61] = 8'h00;  frame0.valid[61] = 1'b0;  frame0.error[61] = 1'b0;

    // No error in this frame
    frame0.bad_frame  = 1'b0;


    //-----------
    // Frame 1
    //-----------
    frame1.data[0]  = 8'hDA;  frame1.valid[0]  = 1'b1;  frame1.error[0]  = 1'b0; // Destination Address (DA) 
    frame1.data[1]  = 8'h02;  frame1.valid[1]  = 1'b1;  frame1.error[1]  = 1'b0;
    frame1.data[2]  = 8'h03;  frame1.valid[2]  = 1'b1;  frame1.error[2]  = 1'b0;
    frame1.data[3]  = 8'h04;  frame1.valid[3]  = 1'b1;  frame1.error[3]  = 1'b0;
    frame1.data[4]  = 8'h05;  frame1.valid[4]  = 1'b1;  frame1.error[4]  = 1'b0;
    frame1.data[5]  = 8'h06;  frame1.valid[5]  = 1'b1;  frame1.error[5]  = 1'b0;
    frame1.data[6]  = 8'h5A;  frame1.valid[6]  = 1'b1;  frame1.error[6]  = 1'b0; // Source Address	(5A)
    frame1.data[7]  = 8'h02;  frame1.valid[7]  = 1'b1;  frame1.error[7]  = 1'b0; 
    frame1.data[8]  = 8'h03;  frame1.valid[8]  = 1'b1;  frame1.error[8]  = 1'b0; 
    frame1.data[9]  = 8'h04;  frame1.valid[9]  = 1'b1;  frame1.error[9]  = 1'b0;
    frame1.data[10] = 8'h05;  frame1.valid[10] = 1'b1;  frame1.error[10] = 1'b0;
    frame1.data[11] = 8'h06;  frame1.valid[11] = 1'b1;  frame1.error[11] = 1'b0;
    frame1.data[12] = 8'h80;  frame1.valid[12] = 1'b1;  frame1.error[12] = 1'b0; // Length/Type = Type = 8000
    frame1.data[13] = 8'h00;  frame1.valid[13] = 1'b1;  frame1.error[13] = 1'b0; 
    frame1.data[14] = 8'h01;  frame1.valid[14] = 1'b1;  frame1.error[14] = 1'b0;  
    frame1.data[15] = 8'h02;  frame1.valid[15] = 1'b1;  frame1.error[15] = 1'b0;
    frame1.data[16] = 8'h03;  frame1.valid[16] = 1'b1;  frame1.error[16] = 1'b0;
    frame1.data[17] = 8'h04;  frame1.valid[17] = 1'b1;  frame1.error[17] = 1'b0;
    frame1.data[18] = 8'h05;  frame1.valid[18] = 1'b1;  frame1.error[18] = 1'b0;
    frame1.data[19] = 8'h06;  frame1.valid[19] = 1'b1;  frame1.error[19] = 1'b0;
    frame1.data[20] = 8'h07;  frame1.valid[20] = 1'b1;  frame1.error[20] = 1'b0; 
    frame1.data[21] = 8'h08;  frame1.valid[21] = 1'b1;  frame1.error[21] = 1'b0; 
    frame1.data[22] = 8'h09;  frame1.valid[22] = 1'b1;  frame1.error[22] = 1'b0;
    frame1.data[23] = 8'h0A;  frame1.valid[23] = 1'b1;  frame1.error[23] = 1'b0; 
    frame1.data[24] = 8'h0B;  frame1.valid[24] = 1'b1;  frame1.error[24] = 1'b0;
    frame1.data[25] = 8'h0C;  frame1.valid[25] = 1'b1;  frame1.error[25] = 1'b0;
    frame1.data[26] = 8'h0D;  frame1.valid[26] = 1'b1;  frame1.error[26] = 1'b0;
    frame1.data[27] = 8'h0E;  frame1.valid[27] = 1'b1;  frame1.error[27] = 1'b0;
    frame1.data[28] = 8'h0F;  frame1.valid[28] = 1'b1;  frame1.error[28] = 1'b0;
    frame1.data[29] = 8'h10;  frame1.valid[29] = 1'b1;  frame1.error[29] = 1'b0;
    frame1.data[30] = 8'h11;  frame1.valid[30] = 1'b1;  frame1.error[30] = 1'b0;
    frame1.data[31] = 8'h12;  frame1.valid[31] = 1'b1;  frame1.error[31] = 1'b0;
    frame1.data[32] = 8'h13;  frame1.valid[32] = 1'b1;  frame1.error[32] = 1'b0;
    frame1.data[33] = 8'h14;  frame1.valid[33] = 1'b1;  frame1.error[33] = 1'b0;
    frame1.data[34] = 8'h15;  frame1.valid[34] = 1'b1;  frame1.error[34] = 1'b0;
    frame1.data[35] = 8'h16;  frame1.valid[35] = 1'b1;  frame1.error[35] = 1'b0;
    frame1.data[36] = 8'h17;  frame1.valid[36] = 1'b1;  frame1.error[36] = 1'b0;
    frame1.data[37] = 8'h18;  frame1.valid[37] = 1'b1;  frame1.error[37] = 1'b0;
    frame1.data[38] = 8'h19;  frame1.valid[38] = 1'b1;  frame1.error[38] = 1'b0;
    frame1.data[39] = 8'h1A;  frame1.valid[39] = 1'b1;  frame1.error[39] = 1'b0;
    frame1.data[40] = 8'h1B;  frame1.valid[40] = 1'b1;  frame1.error[40] = 1'b0;
    frame1.data[41] = 8'h1C;  frame1.valid[41] = 1'b1;  frame1.error[41] = 1'b0;
    frame1.data[42] = 8'h1D;  frame1.valid[42] = 1'b1;  frame1.error[42] = 1'b0;
    frame1.data[43] = 8'h1E;  frame1.valid[43] = 1'b1;  frame1.error[43] = 1'b0;
    frame1.data[44] = 8'h1F;  frame1.valid[44] = 1'b1;  frame1.error[44] = 1'b0; 
    frame1.data[45] = 8'h20;  frame1.valid[45] = 1'b1;  frame1.error[45] = 1'b0;
    frame1.data[46] = 8'h21;  frame1.valid[46] = 1'b1;  frame1.error[46] = 1'b0;
    frame1.data[47] = 8'h22;  frame1.valid[47] = 1'b1;  frame1.error[47] = 1'b0;
    frame1.data[48] = 8'h23;  frame1.valid[48] = 1'b1;  frame1.error[48] = 1'b0;
    frame1.data[49] = 8'h24;  frame1.valid[49] = 1'b1;  frame1.error[49] = 1'b0;
    frame1.data[50] = 8'h25;  frame1.valid[50] = 1'b1;  frame1.error[50] = 1'b0;
    frame1.data[51] = 8'h26;  frame1.valid[51] = 1'b1;  frame1.error[51] = 1'b0; 
    frame1.data[52] = 8'h27;  frame1.valid[52] = 1'b1;  frame1.error[52] = 1'b0;
    frame1.data[53] = 8'h28;  frame1.valid[53] = 1'b1;  frame1.error[53] = 1'b0; 
    frame1.data[54] = 8'h29;  frame1.valid[54] = 1'b1;  frame1.error[54] = 1'b0;
    frame1.data[55] = 8'h2A;  frame1.valid[55] = 1'b1;  frame1.error[55] = 1'b0;
    frame1.data[56] = 8'h2B;  frame1.valid[56] = 1'b1;  frame1.error[56] = 1'b0;
    frame1.data[57] = 8'h2C;  frame1.valid[57] = 1'b1;  frame1.error[57] = 1'b0;
    frame1.data[58] = 8'h2D;  frame1.valid[58] = 1'b1;  frame1.error[58] = 1'b0;
    frame1.data[59] = 8'h2E;  frame1.valid[59] = 1'b1;  frame1.error[59] = 1'b0; 
    frame1.data[60] = 8'h2F;  frame1.valid[60] = 1'b1;  frame1.error[60] = 1'b0; // 47th Data byte
    // unused
    frame1.data[61] = 8'h00;  frame1.valid[61] = 1'b0;  frame1.error[61] = 1'b0;

    // No error in this frame
    frame1.bad_frame  = 1'b0;


    //-----------
    // Frame 2
    //-----------
    frame2.data[0]  = 8'hDA;  frame2.valid[0]  = 1'b1;  frame2.error[0]  = 1'b0; // Destination Address (DA) 
    frame2.data[1]  = 8'h02;  frame2.valid[1]  = 1'b1;  frame2.error[1]  = 1'b0;
    frame2.data[2]  = 8'h03;  frame2.valid[2]  = 1'b1;  frame2.error[2]  = 1'b0;
    frame2.data[3]  = 8'h04;  frame2.valid[3]  = 1'b1;  frame2.error[3]  = 1'b0;
    frame2.data[4]  = 8'h05;  frame2.valid[4]  = 1'b1;  frame2.error[4]  = 1'b0;
    frame2.data[5]  = 8'h06;  frame2.valid[5]  = 1'b1;  frame2.error[5]  = 1'b0;
    frame2.data[6]  = 8'h5A;  frame2.valid[6]  = 1'b1;  frame2.error[6]  = 1'b0; // Source Address	(5A)
    frame2.data[7]  = 8'h02;  frame2.valid[7]  = 1'b1;  frame2.error[7]  = 1'b0;  
    frame2.data[8]  = 8'h03;  frame2.valid[8]  = 1'b1;  frame2.error[8]  = 1'b0;  
    frame2.data[9]  = 8'h04;  frame2.valid[9]  = 1'b1;  frame2.error[9]  = 1'b0;
    frame2.data[10] = 8'h05;  frame2.valid[10] = 1'b1;  frame2.error[10] = 1'b0;
    frame2.data[11] = 8'h06;  frame2.valid[11] = 1'b1;  frame2.error[11] = 1'b0;
    frame2.data[12] = 8'h00;  frame2.valid[12] = 1'b1;  frame2.error[12] = 1'b0;
    frame2.data[13] = 8'h2E;  frame2.valid[13] = 1'b1;  frame2.error[13] = 1'b0; // Length/Type = Length = 46
    frame2.data[14] = 8'h01;  frame2.valid[14] = 1'b1;  frame2.error[14] = 1'b0;  
    frame2.data[15] = 8'h02;  frame2.valid[15] = 1'b1;  frame2.error[15] = 1'b0;
    frame2.data[16] = 8'h03;  frame2.valid[16] = 1'b1;  frame2.error[16] = 1'b0;
    frame2.data[17] = 8'h00;  frame2.valid[17] = 1'b1;  frame2.error[17] = 1'b0; // Underrun this frame
    frame2.data[18] = 8'h00;  frame2.valid[18] = 1'b1;  frame2.error[18] = 1'b0;
    frame2.data[19] = 8'h00;  frame2.valid[19] = 1'b1;  frame2.error[19] = 1'b0;
    frame2.data[20] = 8'h00;  frame2.valid[20] = 1'b1;  frame2.error[20] = 1'b0;
    frame2.data[21] = 8'h00;  frame2.valid[21] = 1'b1;  frame2.error[21] = 1'b0; 
    frame2.data[22] = 8'h00;  frame2.valid[22] = 1'b1;  frame2.error[22] = 1'b0;
    frame2.data[23] = 8'h00;  frame2.valid[23] = 1'b1;  frame2.error[23] = 1'b1; // Error asserted 
    frame2.data[24] = 8'h00;  frame2.valid[24] = 1'b1;  frame2.error[24] = 1'b0;
    frame2.data[25] = 8'h00;  frame2.valid[25] = 1'b1;  frame2.error[25] = 1'b0;
    frame2.data[26] = 8'h00;  frame2.valid[26] = 1'b1;  frame2.error[26] = 1'b0;
    frame2.data[27] = 8'h00;  frame2.valid[27] = 1'b1;  frame2.error[27] = 1'b0;
    frame2.data[28] = 8'h00;  frame2.valid[28] = 1'b1;  frame2.error[28] = 1'b0;
    frame2.data[29] = 8'h00;  frame2.valid[29] = 1'b1;  frame2.error[29] = 1'b0;
    frame2.data[30] = 8'h00;  frame2.valid[30] = 1'b1;  frame2.error[30] = 1'b0;
    frame2.data[31] = 8'h00;  frame2.valid[31] = 1'b1;  frame2.error[31] = 1'b0;
    frame2.data[32] = 8'h00;  frame2.valid[32] = 1'b1;  frame2.error[32] = 1'b0;
    frame2.data[33] = 8'h00;  frame2.valid[33] = 1'b1;  frame2.error[33] = 1'b0;
    frame2.data[34] = 8'h00;  frame2.valid[34] = 1'b1;  frame2.error[34] = 1'b0;
    frame2.data[35] = 8'h00;  frame2.valid[35] = 1'b1;  frame2.error[35] = 1'b0;
    frame2.data[36] = 8'h00;  frame2.valid[36] = 1'b1;  frame2.error[36] = 1'b0;
    frame2.data[37] = 8'h00;  frame2.valid[37] = 1'b1;  frame2.error[37] = 1'b0;
    frame2.data[38] = 8'h00;  frame2.valid[38] = 1'b1;  frame2.error[38] = 1'b0;
    frame2.data[39] = 8'h00;  frame2.valid[39] = 1'b1;  frame2.error[39] = 1'b0;
    frame2.data[40] = 8'h00;  frame2.valid[40] = 1'b1;  frame2.error[40] = 1'b0;
    frame2.data[41] = 8'h00;  frame2.valid[41] = 1'b1;  frame2.error[41] = 1'b0;
    frame2.data[42] = 8'h00;  frame2.valid[42] = 1'b1;  frame2.error[42] = 1'b0;
    frame2.data[43] = 8'h00;  frame2.valid[43] = 1'b1;  frame2.error[43] = 1'b0;
    frame2.data[44] = 8'h00;  frame2.valid[44] = 1'b1;  frame2.error[44] = 1'b0; 
    frame2.data[45] = 8'h00;  frame2.valid[45] = 1'b1;  frame2.error[45] = 1'b0;
    frame2.data[46] = 8'h00;  frame2.valid[46] = 1'b1;  frame2.error[46] = 1'b0;
    frame2.data[47] = 8'h00;  frame2.valid[47] = 1'b1;  frame2.error[47] = 1'b0; 
    frame2.data[48] = 8'h00;  frame2.valid[48] = 1'b1;  frame2.error[48] = 1'b0;
    frame2.data[49] = 8'h00;  frame2.valid[49] = 1'b1;  frame2.error[49] = 1'b0;
    frame2.data[50] = 8'h00;  frame2.valid[50] = 1'b1;  frame2.error[50] = 1'b0;
    frame2.data[51] = 8'h00;  frame2.valid[51] = 1'b1;  frame2.error[51] = 1'b0; 
    frame2.data[52] = 8'h00;  frame2.valid[52] = 1'b1;  frame2.error[52] = 1'b0;
    frame2.data[53] = 8'h00;  frame2.valid[53] = 1'b1;  frame2.error[53] = 1'b0; 
    frame2.data[54] = 8'h00;  frame2.valid[54] = 1'b1;  frame2.error[54] = 1'b0;
    frame2.data[55] = 8'h00;  frame2.valid[55] = 1'b1;  frame2.error[55] = 1'b0;
    frame2.data[56] = 8'h00;  frame2.valid[56] = 1'b1;  frame2.error[56] = 1'b0;
    frame2.data[57] = 8'h00;  frame2.valid[57] = 1'b1;  frame2.error[57] = 1'b0;
    frame2.data[58] = 8'h00;  frame2.valid[58] = 1'b1;  frame2.error[58] = 1'b0;
    frame2.data[59] = 8'h00;  frame2.valid[59] = 1'b1;  frame2.error[59] = 1'b0;
    // unused
    frame2.data[60] = 8'h00;  frame2.valid[60] = 1'b0;  frame2.error[60] = 1'b0;
    frame2.data[61] = 8'h00;  frame2.valid[61] = 1'b0;  frame2.error[61] = 1'b0; 

    // Error this frame
    frame2.bad_frame  = 1'b1;


    //-----------
    // Frame 3
    //-----------
    frame3.data[0]  = 8'hDA;  frame3.valid[0]  = 1'b1;  frame3.error[0]  = 1'b0; // Destination Address (DA) 
    frame3.data[1]  = 8'h02;  frame3.valid[1]  = 1'b1;  frame3.error[1]  = 1'b0;
    frame3.data[2]  = 8'h03;  frame3.valid[2]  = 1'b1;  frame3.error[2]  = 1'b0;
    frame3.data[3]  = 8'h04;  frame3.valid[3]  = 1'b1;  frame3.error[3]  = 1'b0;
    frame3.data[4]  = 8'h05;  frame3.valid[4]  = 1'b1;  frame3.error[4]  = 1'b0;
    frame3.data[5]  = 8'h06;  frame3.valid[5]  = 1'b1;  frame3.error[5]  = 1'b0;
    frame3.data[6]  = 8'h5A;  frame3.valid[6]  = 1'b1;  frame3.error[6]  = 1'b0; // Source Address	(5A)
    frame3.data[7]  = 8'h02;  frame3.valid[7]  = 1'b1;  frame3.error[7]  = 1'b0; 
    frame3.data[8]  = 8'h03;  frame3.valid[8]  = 1'b1;  frame3.error[8]  = 1'b0; 
    frame3.data[9]  = 8'h04;  frame3.valid[9]  = 1'b1;  frame3.error[9]  = 1'b0;
    frame3.data[10] = 8'h05;  frame3.valid[10] = 1'b1;  frame3.error[10] = 1'b0;
    frame3.data[11] = 8'h06;  frame3.valid[11] = 1'b1;  frame3.error[11] = 1'b0;
    frame3.data[12] = 8'h00;  frame3.valid[12] = 1'b1;  frame3.error[12] = 1'b0;
    frame3.data[13] = 8'h03;  frame3.valid[13] = 1'b1;  frame3.error[13] = 1'b0; // Length/Type = Length = 03
    frame3.data[14] = 8'h01;  frame3.valid[14] = 1'b1;  frame3.error[14] = 1'b0; // Therefore padding is required 
    frame3.data[15] = 8'h02;  frame3.valid[15] = 1'b1;  frame3.error[15] = 1'b0; 
    frame3.data[16] = 8'h03;  frame3.valid[16] = 1'b1;  frame3.error[16] = 1'b0;
    frame3.data[17] = 8'h00;  frame3.valid[17] = 1'b1;  frame3.error[17] = 1'b0; // Padding starts here
    frame3.data[18] = 8'h00;  frame3.valid[18] = 1'b1;  frame3.error[18] = 1'b0;
    frame3.data[19] = 8'h00;  frame3.valid[19] = 1'b1;  frame3.error[19] = 1'b0;
    frame3.data[20] = 8'h00;  frame3.valid[20] = 1'b1;  frame3.error[20] = 1'b0;
    frame3.data[21] = 8'h00;  frame3.valid[21] = 1'b1;  frame3.error[21] = 1'b0; 
    frame3.data[22] = 8'h00;  frame3.valid[22] = 1'b1;  frame3.error[22] = 1'b0;	
    frame3.data[23] = 8'h00;  frame3.valid[23] = 1'b1;  frame3.error[23] = 1'b0; 
    frame3.data[24] = 8'h00;  frame3.valid[24] = 1'b1;  frame3.error[24] = 1'b0;
    frame3.data[25] = 8'h00;  frame3.valid[25] = 1'b1;  frame3.error[25] = 1'b0;	
    frame3.data[26] = 8'h00;  frame3.valid[26] = 1'b1;  frame3.error[26] = 1'b0;
    frame3.data[27] = 8'h00;  frame3.valid[27] = 1'b1;  frame3.error[27] = 1'b0;
    frame3.data[28] = 8'h00;  frame3.valid[28] = 1'b1;  frame3.error[28] = 1'b0;
    frame3.data[29] = 8'h00;  frame3.valid[29] = 1'b1;  frame3.error[29] = 1'b0;
    frame3.data[30] = 8'h00;  frame3.valid[30] = 1'b1;  frame3.error[30] = 1'b0;
    frame3.data[31] = 8'h00;  frame3.valid[31] = 1'b1;  frame3.error[31] = 1'b0;
    frame3.data[32] = 8'h00;  frame3.valid[32] = 1'b1;  frame3.error[32] = 1'b0;
    frame3.data[33] = 8'h00;  frame3.valid[33] = 1'b1;  frame3.error[33] = 1'b0;
    frame3.data[34] = 8'h00;  frame3.valid[34] = 1'b1;  frame3.error[34] = 1'b0;
    frame3.data[35] = 8'h00;  frame3.valid[35] = 1'b1;  frame3.error[35] = 1'b0;
    frame3.data[36] = 8'h00;  frame3.valid[36] = 1'b1;  frame3.error[36] = 1'b0;
    frame3.data[37] = 8'h00;  frame3.valid[37] = 1'b1;  frame3.error[37] = 1'b0;
    frame3.data[38] = 8'h00;  frame3.valid[38] = 1'b1;  frame3.error[38] = 1'b0;
    frame3.data[39] = 8'h00;  frame3.valid[39] = 1'b1;  frame3.error[39] = 1'b0;
    frame3.data[40] = 8'h00;  frame3.valid[40] = 1'b1;  frame3.error[40] = 1'b0;
    frame3.data[41] = 8'h00;  frame3.valid[41] = 1'b1;  frame3.error[41] = 1'b0;
    frame3.data[42] = 8'h00;  frame3.valid[42] = 1'b1;  frame3.error[42] = 1'b0;
    frame3.data[43] = 8'h00;  frame3.valid[43] = 1'b1;  frame3.error[43] = 1'b0;
    frame3.data[44] = 8'h00;  frame3.valid[44] = 1'b1;  frame3.error[44] = 1'b0; 
    frame3.data[45] = 8'h00;  frame3.valid[45] = 1'b1;  frame3.error[45] = 1'b0;
    frame3.data[46] = 8'h00;  frame3.valid[46] = 1'b1;  frame3.error[46] = 1'b0;
    frame3.data[47] = 8'h00;  frame3.valid[47] = 1'b1;  frame3.error[47] = 1'b0; 
    frame3.data[48] = 8'h00;  frame3.valid[48] = 1'b1;  frame3.error[48] = 1'b0;
    frame3.data[49] = 8'h00;  frame3.valid[49] = 1'b1;  frame3.error[49] = 1'b0;
    frame3.data[50] = 8'h00;  frame3.valid[50] = 1'b1;  frame3.error[50] = 1'b0;
    frame3.data[51] = 8'h00;  frame3.valid[51] = 1'b1;  frame3.error[51] = 1'b0; 
    frame3.data[52] = 8'h00;  frame3.valid[52] = 1'b1;  frame3.error[52] = 1'b0;
    frame3.data[53] = 8'h00;  frame3.valid[53] = 1'b1;  frame3.error[53] = 1'b0; 
    frame3.data[54] = 8'h00;  frame3.valid[54] = 1'b1;  frame3.error[54] = 1'b0;
    frame3.data[55] = 8'h00;  frame3.valid[55] = 1'b1;  frame3.error[55] = 1'b0;
    frame3.data[56] = 8'h00;  frame3.valid[56] = 1'b1;  frame3.error[56] = 1'b0;
    frame3.data[57] = 8'h00;  frame3.valid[57] = 1'b1;  frame3.error[57] = 1'b0;
    frame3.data[58] = 8'h00;  frame3.valid[58] = 1'b1;  frame3.error[58] = 1'b0;
    frame3.data[59] = 8'h00;  frame3.valid[59] = 1'b1;  frame3.error[59] = 1'b0;
    // unused
    frame3.data[60] = 8'h00;  frame3.valid[60] = 1'b0;  frame3.error[60] = 1'b0;
    frame3.data[61] = 8'h00;  frame3.valid[61] = 1'b0;  frame3.error[61] = 1'b0;

    // No error in this frame
    frame3.bad_frame  = 1'b0;

  end

  //--------------------------------------------------------------------
  // CRC engine 
  //--------------------------------------------------------------------
  task calc_crc;
    input  [7:0]  data;
    inout  [31:0] fcs;

    reg [31:0] crc;
    reg        crc_feedback;	  
    integer    I;
  begin

    crc = ~ fcs;

    for (I = 0; I < 8; I = I + 1)
    begin
      crc_feedback = crc[0] ^ data[I];

      crc[0]       = crc[1];
      crc[1]       = crc[2];
      crc[2]       = crc[3];
      crc[3]       = crc[4];
      crc[4]       = crc[5];
      crc[5]       = crc[6]  ^ crc_feedback;
      crc[6]       = crc[7];
      crc[7]       = crc[8];
      crc[8]       = crc[9]  ^ crc_feedback;
      crc[9]       = crc[10] ^ crc_feedback;
      crc[10]      = crc[11];
      crc[11]      = crc[12];
      crc[12]      = crc[13];
      crc[13]      = crc[14];
      crc[14]      = crc[15];
      crc[15]      = crc[16] ^ crc_feedback;
      crc[16]      = crc[17];
      crc[17]      = crc[18];
      crc[18]      = crc[19];
      crc[19]      = crc[20] ^ crc_feedback;
      crc[20]      = crc[21] ^ crc_feedback;
      crc[21]      = crc[22] ^ crc_feedback;
      crc[22]      = crc[23];
      crc[23]      = crc[24] ^ crc_feedback;
      crc[24]      = crc[25] ^ crc_feedback;
      crc[25]      = crc[26];
      crc[26]      = crc[27] ^ crc_feedback;
      crc[27]      = crc[28] ^ crc_feedback;
      crc[28]      = crc[29];
      crc[29]      = crc[30] ^ crc_feedback;
      crc[30]      = crc[31] ^ crc_feedback;
      crc[31]      =           crc_feedback;
    end

    // return the CRC result                                  
    fcs = ~ crc;

    end
  endtask // calc_crc




  // Delay to provide setup and hold timing at the GMII/RGMII.
  parameter dly = 2000;  // 2000 ps


  // testbench signals
  reg         reset;                
  wire        tx_clk;               
  reg  [7:0]  tx_ifg_delay;         
  wire [31:0] tx_statistics_vector; 
  wire        tx_statistics_valid;  
  wire        rx_clk;               
  wire [27:0] rx_statistics_vector; 
  wire        rx_statistics_valid;  
  wire [15:0] pause_val;            
  wire        pause_req;            
  reg [66:0]  configuration_vector;
  reg         gtx_clk;              
  wire        rgmii_txc;          
  wire        rgmii_tx_ctl;           
  wire [3:0]  rgmii_txd;
  reg         rgmii_rxc_1000;
  reg         rgmii_rxc_100;
  reg         rgmii_rxc_10;             
  wire        rgmii_rxc;          
  reg         rgmii_rx_ctl;           
  reg  [3:0]  rgmii_rxd;
  wire        inband_link_status;
  wire [1:0]  inband_clock_speed;
  wire        inband_duplex_status;

  
  // testbench control semaphores
  reg  management_config_finished;
  reg  tx_monitor_finished_1G;
  reg  tx_monitor_finished_10M;
  reg  tx_monitor_finished_100M;
  wire test_half_duplex;

  reg [1:0] current_speed;

  assign test_half_duplex = 1'b0;

  //--------------------------------------------------------------------
  // Wire up Device Under Test
  //--------------------------------------------------------------------
  tri_mode_eth_mac_example_design dut
     (.reset(reset),
      //------------------------------------------------------------------------
      //-- Receiver Interface.
      //------------------------------------------------------------------------
      .rx_clk(rx_clk),
      .rx_statistics_vector(rx_statistics_vector),
      .rx_statistics_valid(rx_statistics_valid),  
      //------------------------------------------------------------------------
      //-- Transmitter Interface
      //------------------------------------------------------------------------
      .tx_clk(tx_clk),
      .tx_ifg_delay(tx_ifg_delay),        
      .tx_statistics_vector(tx_statistics_vector),
      .tx_statistics_valid(tx_statistics_valid), 
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
  
  
  //--------------------------------------------------------------------
  // Flow Control held inactive
  //--------------------------------------------------------------------
  assign pause_req = 1'b0;
  assign pause_val = 16'h0;


  //--------------------------------------------------------------------
  // Clock drivers
  //--------------------------------------------------------------------

  initial                   // drives gtx_clk at 125 MHz
  begin
    gtx_clk <= 1'b0;
	#80000;
    forever
    begin	 
      gtx_clk <= 1'b0;
      #4000;
      gtx_clk <= 1'b1;
      #4000;
    end
  end




  initial
  begin
    rgmii_rxc_1000 <= 1'b0;
    #10000;
    forever
    begin
      rgmii_rxc_1000 <= 1'b0;
      #4000;
      rgmii_rxc_1000 <= 1'b1;
      #4000;
    end
  end

  initial
  begin
    rgmii_rxc_100 <= 1'b0;
    #10000;
    forever
    begin
      rgmii_rxc_100 <= 1'b0;
      #20000;
      rgmii_rxc_100 <= 1'b1;
      #20000;
    end
  end

  initial
  begin
    rgmii_rxc_10 <= 1'b0;
    #10000;
    forever
    begin
      rgmii_rxc_10 <= 1'b0;
      #200000;
      rgmii_rxc_10 <= 1'b1;
      #200000;
    end
  end

  assign rgmii_rxc = (current_speed == 2'b10 ? rgmii_rxc_1000 : 
                       (current_speed == 2'b01 ? rgmii_rxc_100 : rgmii_rxc_10));


  //---------------------------------------------------------------------------
  //-- If the simulation is still going after 500 us then 
  //-- something has gone wrong
  //---------------------------------------------------------------------------
  initial
  begin
    #500000000;
    $display("** ERROR: Simulation Running Forever");
    $stop;
  end

  //--------------------------------------------------------------------
  // Management process. This process sets up the configuration by 
  // turning off flow control, then checks gathered statistics at the 
  // end of transmission
  //--------------------------------------------------------------------

  initial
  begin : p_management   


   $display("** Note: Timing checks are not valid");

    //--------------------------------------------------------------------
    // Set a fixed configuration for the MAC.  Any of the bits within
    // "CONFIGURATION_VECTOR" can alternatively be changed dynamically.
    //--------------------------------------------------------------------
    configuration_vector[47:0] = 48'h0;   // Set Pause Address                 
    configuration_vector[49]   = 1'b0;    // Disable VLAN Mode (Rx)                                      
    configuration_vector[50]   = 1'b1;    // Enable the Receiver          
    configuration_vector[51]   = 1'b0;    // Do not pass FCS in band (Rx)                
    configuration_vector[52]   = 1'b0;    // Disable Jumbo Frames (Rx)
    configuration_vector[53]   = 1'b0;    // Receiver Reset not asserted                     
    configuration_vector[54]   = 1'b0;    // Disable IFG Adjustment    
    configuration_vector[56]   = 1'b0;    // Disable VLAN Mode (Tx)                
    configuration_vector[57]   = 1'b1;    // Enable the Transmitter          
    configuration_vector[58]   = 1'b0;    // MAC will calculate and insert FCS field (Tx)               
    configuration_vector[59]   = 1'b0;    // Disable Jumbo Frames (Tx)
    configuration_vector[60]   = 1'b0;    // Transmitter Reset not asserted                     
    configuration_vector[61]   = 1'b0;    // Disable Pause Frame Transmission
    configuration_vector[62]   = 1'b0;    // Ignore Pause Frames on Reception
    configuration_vector[63]   = 1'b0;    // Enable Length/Type Checking
    configuration_vector[64]   = 1'b0;    // Address Filter is enabled

    configuration_vector[55]   = 1'b0;
    configuration_vector[48]   = 1'b0;
    configuration_vector[65]   = 1'b0;
    configuration_vector[66]   = 1'b1;

   
    current_speed <= 2'b10;
    // reset the core
    $display("** Note: Resetting core...");
      
    reset <= 1'b1;
    #200000

    reset <= 1'b0;
    #500000
    $display("** Note: Timing checks are valid");

    configuration_vector[55]          <= 1'b0;
    configuration_vector[48]          <= 1'b0;
    configuration_vector[65]          <= 1'b0;
    configuration_vector[66]          <= 1'b1;

    // Signal that configuration is complete.  Other processes will now
    // be allowed to run.
    management_config_finished = 1;

    // Wait for monitor process to complete following the end of frame
    // reception and transmission.
    wait (tx_monitor_finished_1G == 1);

    $display("** Note: Timing checks are not valid");

    configuration_vector[55]          <= 1'b0;
    configuration_vector[48]          <= 1'b0;
    configuration_vector[65]          <= 1'b1;
    configuration_vector[66]          <= 1'b0;
    current_speed <= 2'b01;
    #100000;

    // There may be a glitch on the clock output after 
    // a speed change. Reset the core here
    $display("** Note: Resetting core...");
      
    #200000
    @(posedge rx_clk)
    reset <= 1'b1;
    #200000

    reset <= 1'b0;

    $display("** Note: Timing checks are valid");

    wait (tx_monitor_finished_100M == 1);

    $display("** Note: Timing checks are not valid");

    configuration_vector[55]          <= 1'b0;
    configuration_vector[48]          <= 1'b0;
    configuration_vector[65]          <= 1'b0;
    configuration_vector[66]          <= 1'b0;
    current_speed <= 2'b00;
    #100000;

    // There may be a glitch on the clock output after 
    // a speed change. Reset the core here
    $display("** Note: Resetting core...");
      
    #1000000
    @(posedge rx_clk)
    reset <= 1'b1;
    #1000000

    reset <= 1'b0;
 

    $display("** Note: Timing checks are valid");

    wait (tx_monitor_finished_10M == 1);

    // Our work here is done
    $display("** failure: Simulation Stopped");
    $stop;

  end // p_management



  //--------------------------------------------------------------------
  // Stimulus process. This process will inject frames of data into the
  // PHY side of the receiver.
  //--------------------------------------------------------------------

  //  A task to inject the current frame at 1G
  task rx_stimulus_send_frame_1G;
    input   `FRAME_TYP frame;
    integer column_index;
    integer I;
    reg [31:0] fcs;
    begin
      // import the frame into scratch space
      rx_stimulus_working_frame.frombits(frame);

      // Reset the FCS calculation
      fcs = 32'b0;

      column_index = 0;

      // Adding the preamble field
      for (I = 0; I < 15; I = I + 1)
      begin
        #dly; 
        rgmii_rxd   <= 4'h5;
        rgmii_rx_ctl <= 1'b1;
        @(rgmii_rxc);
      end

      // Adding the Start of Frame Delimiter (SFD)
      #dly; 
      rgmii_rxd   <= 4'hD;
      rgmii_rx_ctl <= 1'b1;
      @(rgmii_rxc)

      // loop over columns in frame.
      while (rx_stimulus_working_frame.valid[column_index] !== 1'b0)
      begin
        // send one column of data
        #dly;
        rgmii_rxd    <= rx_stimulus_working_frame.data[column_index][3:0];	 
        rgmii_rx_ctl <= rx_stimulus_working_frame.valid[column_index];
        @(rgmii_rxc)
        #dly;
        rgmii_rxd    <= rx_stimulus_working_frame.data[column_index][7:4];	 
        rgmii_rx_ctl <= rx_stimulus_working_frame.valid[column_index] ^ rx_stimulus_working_frame.error[column_index];
        calc_crc(rx_stimulus_working_frame.data[column_index], fcs);
        
        column_index = column_index + 1;
        @(rgmii_rxc);  // wait for next clock tick
    
      end

      // Send the CRC.
      for (I = 0; I < 4; I = I + 1)
      begin 
        #dly;
        case(I)
           0 : rgmii_rxd    <= fcs[3:0];
           1 : rgmii_rxd    <= fcs[11:8];
           2 : rgmii_rxd    <= fcs[19:16];
           3 : rgmii_rxd    <= fcs[27:24];
        endcase	 
        rgmii_rx_ctl <= 1'b1;
        @(rgmii_rxc)
        #dly;
        case(I)
           0 : rgmii_rxd    <= fcs[7:4];
           1 : rgmii_rxd    <= fcs[15:12];
           2 : rgmii_rxd    <= fcs[23:20];
           3 : rgmii_rxd    <= fcs[31:28];
        endcase	 
        rgmii_rx_ctl <= 1'b1;
        
        @(rgmii_rxc);  // wait for next clock tick
      end

      // Clear the data lines.
      #dly; 
      rgmii_rxd       <= 4'h0;
      rgmii_rx_ctl    <= 1'b0;

      // Adding the minimum Interframe gap for a receiver (8 idles)
      for (I = 0; I < 16; I = I + 1)
        @(rgmii_rxc);

    end 
  endtask // rx_stimulus_send_frame;

  //  A task to inject the current frame at 100M
  task rx_stimulus_send_frame_100M;
    input   `FRAME_TYP frame;
    integer column_index;
    integer I;
    reg [31:0] fcs;
    begin
      // import the frame into scratch space
      rx_stimulus_working_frame.frombits(frame); 

      // Reset the FCS calculation
      fcs = 32'b0;

      @(negedge rgmii_rxc);

      column_index = 0;

      // Adding the preamble field
      for (I = 0; I <= 30; I = I + 1)
      begin
        rgmii_rxd   <= #30000 4'h5;
        rgmii_rx_ctl <= #30000 1'b1;
        @(rgmii_rxc);
      end

      // Adding the Start of Frame Delimiter (SFD)
      rgmii_rxd   <= #30000 4'hD;
      rgmii_rx_ctl <= #30000 1'b1;
      @(rgmii_rxc)
      @(rgmii_rxc)

      // loop over columns in frame.
      while (rx_stimulus_working_frame.valid[column_index] !== 1'b0)
      begin
        // send one column of data
        rgmii_rxd    <= #30000 rx_stimulus_working_frame.data[column_index][3:0];	 
        rgmii_rx_ctl <= #30000 rx_stimulus_working_frame.valid[column_index];
        @(rgmii_rxc)
        @(rgmii_rxc)
        rgmii_rxd    <= #30000 rx_stimulus_working_frame.data[column_index][7:4];	 
        rgmii_rx_ctl <= #30000 rx_stimulus_working_frame.valid[column_index] ^ rx_stimulus_working_frame.error[column_index];
        calc_crc(rx_stimulus_working_frame.data[column_index], fcs);
        @(rgmii_rxc)
        @(rgmii_rxc);  // wait for next clock tick
    	column_index = column_index + 1;
      end

      // Send the CRC.
      for (I = 0; I < 4; I = I + 1)
      begin
       case(I)
           0 : rgmii_rxd    <= #30000 fcs[3:0];
           1 : rgmii_rxd    <= #30000 fcs[11:8];
           2 : rgmii_rxd    <= #30000 fcs[19:16];
           3 : rgmii_rxd    <= #30000 fcs[27:24];
        endcase	 
        rgmii_rx_ctl <= #30000 1'b1;
        @(rgmii_rxc)
        @(rgmii_rxc)
        case(I)
           0 : rgmii_rxd    <= #30000 fcs[7:4];
           1 : rgmii_rxd    <= #30000 fcs[15:12];
           2 : rgmii_rxd    <= #30000 fcs[23:20];
           3 : rgmii_rxd    <= #30000 fcs[31:28];
        endcase	 
        rgmii_rx_ctl <= #30000 1'b1;
        @(rgmii_rxc)  
        @(rgmii_rxc); // wait for next clock tick
      end

      // Clear the data lines. 
      rgmii_rxd       <= #30000 4'h0;
      rgmii_rx_ctl    <= #30000 1'b0;

      // Adding the minimum Interframe gap for a receiver (8 idles)
      for (I = 0; I < 32; I = I + 1)
        @(rgmii_rxc);

    end 
  endtask // rx_stimulus_send_frame;

  //  A task to inject the current frame at 10M
  task rx_stimulus_send_frame_10M;
    input   `FRAME_TYP frame;
    integer column_index;
    integer I;
    reg [31:0] fcs;
    begin
      // import the frame into scratch space
      rx_stimulus_working_frame.frombits(frame);

      @(negedge rgmii_rxc);

      // Reset the FCS calculation
      fcs = 32'b0;

      column_index = 0;

      // Adding the preamble field
      for (I = 0; I <= 30; I = I + 1)
      begin
        rgmii_rxd   <= #390000 4'h5;
        rgmii_rx_ctl <= #390000 1'b1;
        @(rgmii_rxc);
      end

      // Adding the Start of Frame Delimiter (SFD)
      rgmii_rxd   <= #390000 4'hD;
      rgmii_rx_ctl <= #390000 1'b1;
      @(rgmii_rxc)
      @(rgmii_rxc)

      // loop over columns in frame.
      while (rx_stimulus_working_frame.valid[column_index] !== 1'b0)
      begin
        // send one column of data
        rgmii_rxd    <= #390000 rx_stimulus_working_frame.data[column_index][3:0];	 
        rgmii_rx_ctl <= #390000 rx_stimulus_working_frame.valid[column_index];
        @(rgmii_rxc)
        @(rgmii_rxc)
        rgmii_rxd    <= #390000 rx_stimulus_working_frame.data[column_index][7:4];	 
        rgmii_rx_ctl <= #390000 rx_stimulus_working_frame.valid[column_index] ^ rx_stimulus_working_frame.error[column_index];
        calc_crc(rx_stimulus_working_frame.data[column_index], fcs);
        @(rgmii_rxc)
        @(rgmii_rxc);  // wait for next clock tick
    	column_index = column_index + 1;
      end

      // Send the CRC.
      for (I = 0; I < 4; I = I + 1)
      begin
        case(I)
           0 : rgmii_rxd    <= #390000 fcs[3:0];
           1 : rgmii_rxd    <= #390000 fcs[11:8];
           2 : rgmii_rxd    <= #390000 fcs[19:16];
           3 : rgmii_rxd    <= #390000 fcs[27:24];
        endcase	 
        rgmii_rx_ctl <= #390000 1'b1;
        @(rgmii_rxc)
        @(rgmii_rxc)
        case(I)
           0 : rgmii_rxd    <= #390000 fcs[7:4];
           1 : rgmii_rxd    <= #390000 fcs[15:12];
           2 : rgmii_rxd    <= #390000 fcs[23:20];
           3 : rgmii_rxd    <= #390000 fcs[31:28];
        endcase	 
        rgmii_rx_ctl <= #390000 1'b1;     
        @(rgmii_rxc)  
        @(rgmii_rxc); // wait for next clock tick
      end

      // Clear the data lines. 
      rgmii_rxd       <= #390000 4'h0;
      rgmii_rx_ctl    <= #390000 1'b0;

      // Adding the minimum Interframe gap for a receiver (8 idles)
      for (I = 0; I < 32; I = I + 1)
        @(rgmii_rxc);

    end 
  endtask // rx_stimulus_send_frame;


  // loop over all the frames in the stimulus vector 
  initial
  begin : p_rx_stimulus 

    // Initialise stimulus    
    rgmii_rxd     <= 4'h0;
    rgmii_rx_ctl  <= 1'b0;
    tx_ifg_delay   = 8'h0;

    // Wait for the Management MDIO transaction to finish.
    while (management_config_finished !== 1)
      @(negedge rgmii_rxc);
   
    // Inject four frames into the receiver PHY interface
    //      -- frame 0 = standard frame
    //      -- frame 1 = type frame
    //      -- frame 2 = frame containing an error
    //      -- frame 3 = standard frame with padding
    $display("Rx Stimulus: sending 4 frames at 1G... ");

    rx_stimulus_send_frame_1G(frame0.tobits(0));
    rx_stimulus_send_frame_1G(frame1.tobits(1));
    rx_stimulus_send_frame_1G(frame2.tobits(2));
    rx_stimulus_send_frame_1G(frame3.tobits(3));

    wait (tx_monitor_finished_1G == 1);
    #1000000

    $display("Rx Stimulus: sending 4 frames at 100M ... ");

    rx_stimulus_send_frame_100M(frame0.tobits(0));
    rx_stimulus_send_frame_100M(frame1.tobits(1));
    rx_stimulus_send_frame_100M(frame2.tobits(2));
    rx_stimulus_send_frame_100M(frame3.tobits(3));

    wait (tx_monitor_finished_100M == 1);
    #1000000

    $display("Rx Stimulus: sending 4 frames at 10M ... ");

    rx_stimulus_send_frame_10M(frame0.tobits(0));
    rx_stimulus_send_frame_10M(frame1.tobits(1));
    rx_stimulus_send_frame_10M(frame2.tobits(2));
    rx_stimulus_send_frame_10M(frame3.tobits(3));
	 
  end // p_rx_stimulus



  //--------------------------------------------------------------------
  // Monitor process. This process checks the data coming out of the 
  // receiver to make sure that it matches that inserted into the 
  // transmitter.
  //--------------------------------------------------------------------

  // A task to compare the current frame being transmitted with the
  // injected frame (1G) 
  task tx_monitor_check_frame_1G;
    input `FRAME_TYP frame;
    integer column_index;
    integer I;
    reg [31:0] fcs;
    reg [7:0]  rgmii_column;
    reg [1:0]  rgmii_valid;   
  begin
    // import the frame into scratch space
    tx_monitor_working_frame.frombits(frame);

    column_index = 0;

    // If the current frame had an error inserted then it would have 
    // been dropped by the FIFO in the design example.  Therefore 
    // exit this task and move immediately on to the next frame.
    if (tx_monitor_working_frame.bad_frame !== 1'b1)
    begin

      // reset the fcs calculation
      fcs = 32'b0;

      // wait until the first real column of data to come out of RX client
      while (rgmii_tx_ctl !== 1'b1)
        @(rgmii_txc);

      // Parse over the preamble field
      while (rgmii_txd === 4'h5)
        @(rgmii_txc);

      // Parse over the SFD
      @(rgmii_txc);

      // Start comparing transmitted data to received data
      $display("** Note: Comparing Transmitted Frame with Injected Frame");

      // frame has started, loop over columns of frame
      while (tx_monitor_working_frame.valid[column_index] !== 1'b0)
      begin  

        rgmii_column[3:0] = rgmii_txd[3:0];
        rgmii_valid[0]    = rgmii_tx_ctl;
        @(rgmii_txc);
        rgmii_column[7:4]= rgmii_txd[3:0];
        rgmii_valid[1]    = rgmii_tx_ctl;
          
        // The transmitted Destination Address was the Source Address
        // of the injected frame
        if (column_index < 6) 
        begin 

          if (rgmii_valid[0] !== tx_monitor_working_frame.valid[column_index+6])
            $display("** ERROR: rgmii_tx_ctl incorrect during Destination Address at %t", $realtime);
          if (rgmii_valid[1] !== tx_monitor_working_frame.valid[column_index+6])
            $display("** ERROR: rgmii_tx_ctl incorrect during Destination Address at %t", $realtime);

          if (rgmii_column !== tx_monitor_working_frame.data[(column_index+6)])
            $display("** ERROR: rgmii_txd incorrect during Destination Address at %t", $realtime);
        end

        // The transmitted Source Address was the Destination Address
        // of the injected frame
	else if (column_index < 12)
	begin

          if (rgmii_valid[0] !== tx_monitor_working_frame.valid[column_index-6])
            $display("** ERROR: rgmii_tx_ctl incorrect during Source Address at %t", $realtime); 
          if (rgmii_valid[1] !== tx_monitor_working_frame.valid[column_index-6])
            $display("** ERROR: rgmii_tx_ctl incorrect during Source Address at %t", $realtime);

          if (rgmii_column !== tx_monitor_working_frame.data[(column_index-6)])
            $display("** ERROR: rgmii_txd incorrect during Source Address at %t", $realtime);
        end

        // check all other data in the frame 
        else
        begin  

          if (rgmii_valid[0] !== tx_monitor_working_frame.valid[column_index])
            $display("** ERROR: rgmii_tx_ctl incorrect at %t", $realtime); 
          if (rgmii_valid[1] !== tx_monitor_working_frame.valid[column_index])
            $display("** ERROR: rgmii_tx_ctl incorrect at %t", $realtime);

          if (rgmii_column !== tx_monitor_working_frame.data[(column_index)])
            $display("** ERROR: rgmii_txd incorrect at %t", $realtime);
        end 

        // calculate expected crc for the frame
        calc_crc(rgmii_column, fcs);

        // wait for next column of data
        column_index = column_index + 1;
        @(rgmii_txc);
      end 
      		 
      // Check the FCS
      // Having checked all data columns, txd must contain FCS.
      for (I = 0; I < 4; I = I + 1)
      begin  
        rgmii_column[3:0] = rgmii_txd[3:0];
        rgmii_valid[0]    = rgmii_tx_ctl;
        @(rgmii_txc);
        rgmii_column[7:4] = rgmii_txd[3:0]; 
        rgmii_valid[1]    = rgmii_tx_ctl;

        if (rgmii_valid !== 2'b11)
          $display("** ERROR: rgmii_tx_ctl incorrect during FCS field at %t", $realtime);

        case(I)
           0 : if (rgmii_column !== fcs[7:0])
                  $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime);
           1 :  if (rgmii_column !== fcs[15:8])
                  $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime);
           2 :  if (rgmii_column !== fcs[23:16])
                  $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime);
           3 :  if (rgmii_column !== fcs[31:24])
                  $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime);
        endcase	 
 
        @(rgmii_txc);
      end  
    end 
   end
  endtask // tx_monitor_check_frame

  // A task to compare the current frame being transmitted with the
  // injected frame (10/100M) 
  task tx_monitor_check_frame_10100M;
    input `FRAME_TYP frame;
    integer column_index;
    integer I;
    reg [31:0] fcs;
    reg [7:0]  rgmii_column;
    reg [1:0]  rgmii_valid;  
  begin
    // import the frame into scratch space
    tx_monitor_working_frame.frombits(frame);

    column_index = 0;

    // If the current frame had an error inserted then it would have 
    // been dropped by the FIFO in the design example.  Therefore 
    // exit this task and move immediately on to the next frame.
    if (tx_monitor_working_frame.bad_frame !== 1'b1)
    begin  

      // reset the fcs calculation
      fcs = 32'b0;

      // wait until the first real column of data to come out of RX client
      while (rgmii_tx_ctl !== 1'b1)
        @(posedge rgmii_txc);

      // Parse over the preamble field
      while (rgmii_txd === 4'h5)
        @(posedge rgmii_txc);

      // Parse over the SFD
      @(posedge rgmii_txc);

      // Start comparing transmitted data to received data
      $display("** Note: Comparing Transmitted Frame with Injected Frame");

      // frame has started, loop over columns of frame
      while (tx_monitor_working_frame.valid[column_index] !== 1'b0)
      begin

        rgmii_column[3:0] = rgmii_txd[3:0];
        rgmii_valid[0]    = rgmii_tx_ctl;
        @(posedge rgmii_txc);
        rgmii_column[7:4]= rgmii_txd[3:0];
        rgmii_valid[1]    = rgmii_tx_ctl;
          
        // The transmitted Destination Address was the Source Address
        // of the injected frame
        if (column_index < 6) 
        begin

           if (rgmii_valid[0] !== tx_monitor_working_frame.valid[column_index+6])
            $display("** ERROR: rgmii_tx_ctl incorrect during Destination Address at %t", $realtime);
           if (rgmii_valid[1] !== tx_monitor_working_frame.valid[column_index+6])
            $display("** ERROR: rgmii_tx_ctl incorrect during Destination Address at %t", $realtime);

          if (rgmii_column !== tx_monitor_working_frame.data[(column_index+6)])
            $display("** ERROR: rgmii_txd incorrect during Destination Address at %t", $realtime);
        end

        // The transmitted Source Address was the Destination Address
        // of the injected frame
	else if (column_index < 12)
	begin
	  if (rgmii_valid[0] !== tx_monitor_working_frame.valid[column_index-6])
            $display("** ERROR: rgmii_tx_ctl incorrect during Source Address at %t", $realtime);
          if (rgmii_valid[1] !== tx_monitor_working_frame.valid[column_index-6])
            $display("** ERROR: rgmii_tx_ctl incorrect during Source Address at %t", $realtime);

          if (rgmii_column !== tx_monitor_working_frame.data[(column_index-6)])
            $display("** ERROR: rgmii_txd incorrect during Source Address at %t", $realtime);
        end

        // check all other data in the frame 
        else
        begin  
          if (rgmii_valid[0] !== tx_monitor_working_frame.valid[column_index])
            $display("** ERROR: rgmii_tx_ctl incorrect at %t", $realtime);
          if (rgmii_valid[1] !== tx_monitor_working_frame.valid[column_index])
            $display("** ERROR: rgmii_tx_ctl incorrect at %t", $realtime);

          if (rgmii_column !== tx_monitor_working_frame.data[(column_index)])
            $display("** ERROR: rgmii_txd incorrect at %t", $realtime); 
	      if (rgmii_tx_ctl !== tx_monitor_working_frame.valid[column_index])
            $display("** ERROR: rgmii_tx_ctl incorrect");
        end

        // calculate expected crc for the frame
        calc_crc(rgmii_column, fcs);

        // wait for next column of data
        column_index = column_index + 1;
        @(posedge rgmii_txc);
      end 
      		 
      // Check the FCS
      // Having checked all data columns, txd must contain FCS.
      for (I = 0; I < 4; I = I + 1)
      begin
        rgmii_column[3:0] = rgmii_txd[3:0];
        rgmii_valid[0]    = rgmii_tx_ctl;
        @(posedge rgmii_txc);
        rgmii_column[7:4] = rgmii_txd[3:0];
        rgmii_valid[1]    = rgmii_tx_ctl;

        if (rgmii_valid !== 2'b11)
          $display("** ERROR: rgmii_tx_ctl incorrect during FCS field at %t", $realtime);

        case(I)
           0 : if (rgmii_column !== fcs[7:0])
                  $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime);
           1 :  if (rgmii_column !== fcs[15:8])
                  $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime);
           2 :  if (rgmii_column !== fcs[23:16])
                  $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime);
           3 :  if (rgmii_column !== fcs[31:24])
                  $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime);
        endcase	 

        @(posedge rgmii_txc);
      end
    
    end 
   end
  endtask // tx_monitor_check_frame


  
  // loop over all the frames in the stimulus vector 
  initial
  begin : p_tx_monitor 
    tx_monitor_finished_1G    <= 0;
    tx_monitor_finished_100M  <= 0;
    tx_monitor_finished_10M   <= 0;

    // Compare the transmitted frame to the received frames   
    //      -- frame 0 = minimum length frame
    //      -- frame 1 = type frame
    //      -- frame 2 = errored frame
    //      -- frame 3 = padded frame
   
    // first, wait for reset to be deasserted
    wait (reset == 1'b0);
    #1000000

    // then get synced up with the clock
    @(posedge rgmii_txc)
   
    // parse all the frames in the stimulus vector
    tx_monitor_check_frame_1G(frame0.tobits(0));
    tx_monitor_check_frame_1G(frame1.tobits(0));
    tx_monitor_check_frame_1G(frame2.tobits(0));
    tx_monitor_check_frame_1G(frame3.tobits(0));

    #200000
    tx_monitor_finished_1G  <= 1;

    // then get synced up with the clock
    @(posedge rgmii_txc)
   
    // parse all the frames in the stimulus vector
    tx_monitor_check_frame_10100M(frame0.tobits(0));
    tx_monitor_check_frame_10100M(frame1.tobits(0));
    tx_monitor_check_frame_10100M(frame2.tobits(0));
    tx_monitor_check_frame_10100M(frame3.tobits(0));

    #200000
    tx_monitor_finished_100M  <= 1;

    // then get synced up with the clock
    @(posedge rgmii_txc)
   
    // parse all the frames in the stimulus vector
    tx_monitor_check_frame_10100M(frame0.tobits(0));
    tx_monitor_check_frame_10100M(frame1.tobits(0));
    tx_monitor_check_frame_10100M(frame2.tobits(0));
    tx_monitor_check_frame_10100M(frame3.tobits(0));

    #200000
    tx_monitor_finished_10M  <= 1;

  end // p_tx_monitor 	
  


endmodule


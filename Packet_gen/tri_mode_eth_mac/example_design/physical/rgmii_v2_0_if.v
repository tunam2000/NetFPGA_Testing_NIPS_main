//----------------------------------------------------------------------
// $Revision: 1.1.2.1 $ $Date: 2007/05/14 13:57:04 $
//----------------------------------------------------------------------
// File       : rgmii_v2_0_if.v
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
// Description:  This module creates a version 2.0 Reduced Gigabit Media  
//               Independent Interface (RGMII v2.0) by instantiating   
//               Input/Output buffers and Input/Output double data rate  
//               (DDR) flip-flops as required.
//
//               This interface is used to connect the Ethernet MAC to
//               an external Ethernet PHY.
//----------------------------------------------------------------------

`timescale 1 ps / 1 ps


module rgmii_v2_0_if (
        tx_reset,
        rx_reset,                         
        speedis10100,                  

        // RGMII Interface
        rgmii_txd,                     
        rgmii_tx_ctl,                  
        rgmii_txc,                     
        rgmii_rxd,                     
        rgmii_rx_ctl,                  

        link_status,                   
        clock_speed,                   
        duplex_status,                 

        // MAC Interface
        txd_from_mac,                  
        tx_en_from_mac,                
        tx_er_from_mac,                
        tx_clk,                        
        tx_clk90,
                       
        crs_to_mac,                    
        col_to_mac,                    
        rxd_to_mac,                    
        rx_dv_to_mac,                 
        rx_er_to_mac,                 
        rx_clk                          
        );

    input        tx_reset;
    input        rx_reset;                         
    input        speedis10100;                  

    output [3:0] rgmii_txd;                     
    output       rgmii_tx_ctl;                  
    output       rgmii_txc;                     
    input  [3:0] rgmii_rxd;                     
    input        rgmii_rx_ctl;                  

    output       link_status;                   
    output       clock_speed;                   
    output       duplex_status;                 

    input  [7:0] txd_from_mac;                  
    input        tx_en_from_mac;                
    input        tx_er_from_mac;                
    input        tx_clk;                        
    input        tx_clk90;
                         
    output       crs_to_mac;                    
    output       col_to_mac;                    
    output [7:0] rxd_to_mac;                    
    output       rx_dv_to_mac;                 
    output       rx_er_to_mac;                 
    input        rx_clk;   


  //--------------------------------------------------------------------
  // internal signals 
  //--------------------------------------------------------------------
 
  wire not_tx_clk90;                       // Inverted version of tx_clk90.
  wire not_tx_clk;                         // Inverted version of tx_clk.
  reg  [7:0] gmii_txd_rising;              // gmii_txd signal registered on the rising edge of tx_clk.
  reg  gmii_tx_en_rising;                  // gmii_tx_en signal registered on the rising edge of tx_clk.

  reg  rgmii_tx_ctl_rising;	           // RGMII control signal registered on the rising edge of tx_clk.
  reg  [3:0] gmii_txd_falling;	           // gmii_txd signal registered on the falling edge of tx_clk.
  reg  rgmii_tx_ctl_falling;	           // RGMII control signal registered on the falling edge of tx_clk.
  wire rgmii_txc_obuf;                     // RGMII receiver clock output.
  
  wire rgmii_tx_ctl_obuf;                  // RGMII transmit control signal output.
  wire [3:0] rgmii_txd_obuf;               // RGMII transmit data output.
 
  wire rgmii_tx_ctl_int;                   // Internal RGMII transmit control signal.
  
  wire rgmii_rx_ctl_ibuf;                  // RGMII receiver control input.
  wire [3:0] rgmii_rxd_ibuf;               // RGMII receiver data input.
  
 
  
  wire not_rx_clk;                         // Inverted version of the rx_clk signal.
  reg  [7:0] rgmii_rxd_ddr;                // RGMII double data rate data.
  reg  rgmii_rx_dv_ddr;                    // RGMII double data rate data valid.
  reg  rgmii_rx_ctl_ddr;                   // RGMII double data rate control signal.
  reg  [7:0] rgmii_rxd_reg;                // RGMII data.
  reg  rgmii_rx_dv_reg;                    // RGMII data valid.
  reg  rgmii_rx_ctl_reg;                   // Internal RGMII receiver control signal.

  reg  gmii_rx_dv_reg;          // gmii_rx_dv_ibuf registered in IOBs.
  reg  gmii_rx_er_reg;          // gmii_rx_er_ibuf registered in IOBs.
  reg  [7:0] gmii_rxd_reg;      // gmii_rxd_ibuf registered in IOBs.

  wire inband_ce;               // RGMII inband status registers clock enable
  
  reg  link_status;                   
  reg  [1:0] clock_speed;                   
  reg  duplex_status;  

  assign rxd_to_mac      = gmii_rxd_reg;  
  assign rx_dv_to_mac    = gmii_rx_dv_reg;
  assign rx_er_to_mac    = gmii_rx_er_reg;

  //--------------------------------------------------------------------
  // RGMII Transmitter Clock Management :
  // 
  //--------------------------------------------------------------------
  
  // Instantiate a DDR output register.  This is a good way to drive
  // RGMII_TXC since the clock-to-PAD delay will be the same as that
  // for data driven from IOB Ouput flip-flops eg rgmii_rxd[3:0].
  // This is set to produce a 90 degree phase shifted clock w.r.t.
  // gtx_clk_bufg so that the clock edges are centralised within the
  // rgmii_txd[3:0] valid window.
  FDDRRSE gmii_tx_clk_ddr_iob (
      .Q (rgmii_txc_obuf),
      .D0(1'b1),
      .D1(1'b0),
      .C0(tx_clk90),
      .C1(not_tx_clk90),
      .CE(1'b1),
      .R (1'b0),
      .S (1'b0)
      );

  assign not_tx_clk90 = ~(tx_clk90);
  
  //  drive clock through Output Buffers and onto PADS.
  OBUF drive_rgmii_txc     (.I(rgmii_txc_obuf),     .O(rgmii_txc));
  
  //-------------------------------------------------------------------
  // RGMII Transmitter Logic :
  // drive TX signals through IOBs onto RGMII interface
  //-------------------------------------------------------------------

   // Encode rgmii ctl signal
   assign rgmii_tx_ctl_int = tx_en_from_mac ^ tx_er_from_mac;
     // Register all output signals on rising edge of gtx_clk_bufg
   always @ (posedge tx_clk or posedge tx_reset)
   begin
     if (tx_reset)
        begin
           gmii_txd_rising     <= 8'b0;
           gmii_tx_en_rising   <= 1'b0;
           rgmii_tx_ctl_rising <= 1'b0;
	end
     else
        begin
           gmii_txd_rising     <= txd_from_mac;
           gmii_tx_en_rising   <= tx_en_from_mac;
           rgmii_tx_ctl_rising <= rgmii_tx_ctl_int;
	end
   end

   // Register falling edge RGMII output signals on rising edge of not_gtx_clk_bufg
   always @ (posedge not_tx_clk or posedge tx_reset)
   begin
     if (tx_reset)
        begin
           gmii_txd_falling     <= 4'b0;
           rgmii_tx_ctl_falling <= 1'b0;
	end
     else
        begin
           if (speedis10100 == 1'b0)
           begin
             gmii_txd_falling     <= gmii_txd_rising[7:4];
             rgmii_tx_ctl_falling <= rgmii_tx_ctl_rising;
           end
           else
           begin
             gmii_txd_falling     <= gmii_txd_rising[3:0];
             rgmii_tx_ctl_falling <= rgmii_tx_ctl_rising;
           end  
        end
   end

   assign not_tx_clk = ~(tx_clk);

   // Instantiate Double Data Rate Output flip-flops to convert output signals into RGMII format.
   FDDRRSE rgmii_txd_out3 (
         .Q (rgmii_txd_obuf[3]),
         .D0(gmii_txd_rising[3]),
         .D1(gmii_txd_falling[3]),
         .C0(tx_clk),
         .C1(not_tx_clk),
         .CE(1'b1),
         .R (tx_reset),
         .S (1'b0)
         );

   FDDRRSE rgmii_txd_out2 (
         .Q (rgmii_txd_obuf[2]),
         .D0(gmii_txd_rising[2]),
         .D1(gmii_txd_falling[2]),
         .C0(tx_clk),
         .C1(not_tx_clk),
         .CE(1'b1),
         .R (tx_reset),
         .S (1'b0)
         );

   FDDRRSE rgmii_txd_out1 (
         .Q (rgmii_txd_obuf[1]),
         .D0(gmii_txd_rising[1]),
         .D1(gmii_txd_falling[1]),
         .C0(tx_clk),
         .C1(not_tx_clk),
         .CE(1'b1),
         .R (tx_reset),
         .S (1'b0)
         );

   FDDRRSE rgmii_txd_out0 (
         .Q (rgmii_txd_obuf[0]),
         .D0(gmii_txd_rising[0]),
         .D1(gmii_txd_falling[0]),
         .C0(tx_clk),
         .C1(not_tx_clk),
         .CE(1'b1),
         .R (tx_reset),
         .S (1'b0)
         );

   FDDRRSE rgmii_tx_ctl_out (
         .Q (rgmii_tx_ctl_obuf),
         .D0(gmii_tx_en_rising),
         .D1(rgmii_tx_ctl_falling),
         .C0(tx_clk),
         .C1(not_tx_clk),
         .CE(1'b1),
         .R (tx_reset),
         .S (1'b0)
         );
  
   //  Drive RGMII Tx signals through Output Buffers and onto PADS.
   OBUF drive_rgmii_tx_ctl  (.I(rgmii_tx_ctl_obuf),     .O(rgmii_tx_ctl));

   OBUF drive_rgmii_txd3    (.I(rgmii_txd_obuf[3]),     .O(rgmii_txd[3]));
   OBUF drive_rgmii_txd2    (.I(rgmii_txd_obuf[2]),     .O(rgmii_txd[2]));
   OBUF drive_rgmii_txd1    (.I(rgmii_txd_obuf[1]),     .O(rgmii_txd[1]));
   OBUF drive_rgmii_txd0    (.I(rgmii_txd_obuf[0]),     .O(rgmii_txd[0]));
    
   //-------------------------------------------------------------------
   // RGMII Receiver Logic : receive RGMII_RX signals through IOBs from
   // RGMII interface and convert to gmii_rx signals.
   //-------------------------------------------------------------------

   //  Drive input RGMII Rx signals from PADS through Input Buffers.
   IBUF drive_rgmii_rx_ctl (.I(rgmii_rx_ctl), .O(rgmii_rx_ctl_ibuf));

   IBUF drive_rgmii_rxd3   (.I(rgmii_rxd[3]), .O(rgmii_rxd_ibuf[3]));
   IBUF drive_rgmii_rxd2   (.I(rgmii_rxd[2]), .O(rgmii_rxd_ibuf[2]));
   IBUF drive_rgmii_rxd1   (.I(rgmii_rxd[1]), .O(rgmii_rxd_ibuf[1]));
   IBUF drive_rgmii_rxd0   (.I(rgmii_rxd[0]), .O(rgmii_rxd_ibuf[0]));


     // Infer Double Data Rate Input flip-flops.
   always @ (posedge rx_clk or posedge rx_reset)
   begin
      if (rx_reset)
	 begin
            rgmii_rxd_ddr[3:0]   <= 4'b0;
            rgmii_rx_dv_ddr      <= 1'b0;
	 end
      else
	 begin
            rgmii_rxd_ddr[3:0]   <= rgmii_rxd_ibuf;
            rgmii_rx_dv_ddr      <= rgmii_rx_ctl_ibuf;
         end
   end

   always @ (posedge not_rx_clk or posedge rx_reset)
   begin
      if (rx_reset)
	 begin
            rgmii_rxd_ddr[7:4]    <= 4'b0;
            rgmii_rx_ctl_ddr      <= 1'b0;
	 end
      else
	 begin
            rgmii_rxd_ddr[7:4]    <= rgmii_rxd_ibuf;
            rgmii_rx_ctl_ddr      <= rgmii_rx_ctl_ibuf;
         end
   end

   assign not_rx_clk = ~(rx_clk);

   // Register DDR signals internally to FPGA fabric
   always @ (posedge rx_clk or posedge rx_reset)
   begin
      if (rx_reset)
         begin
            rgmii_rxd_reg[3:0] <= 4'b0;
            rgmii_rx_dv_reg    <= 1'b0;
	 end
      else
	 begin
            rgmii_rxd_reg[3:0] <= rgmii_rxd_ddr[3:0];
            rgmii_rx_dv_reg    <= rgmii_rx_dv_ddr;
         end
   end

   always @ (posedge not_rx_clk or posedge rx_reset)
   begin
      if (rx_reset)
	 begin
            rgmii_rxd_reg[7:4] <= 4'b0;
            rgmii_rx_ctl_reg   <= 1'b0;
	 end
      else
	 begin
            rgmii_rxd_reg[7:4] <= rgmii_rxd_ddr[7:4];
            rgmii_rx_ctl_reg   <= rgmii_rx_ctl_ddr;
         end
   end


   // Register all input signals on rising edge of gmii_rx_clk_bufg to syncronise.
   always @ (posedge rx_clk or posedge rx_reset)
   begin
       if (rx_reset)
	  begin
             gmii_rxd_reg[7:0] <= 8'b0;
             gmii_rx_dv_reg    <= 1'b0;
             gmii_rx_er_reg    <= 1'b0;
	  end
       else
	  begin
             gmii_rxd_reg[7:0] <= rgmii_rxd_reg[7:0];
             gmii_rx_dv_reg    <= rgmii_rx_dv_reg;
             gmii_rx_er_reg    <= rgmii_rx_ctl_reg ^ rgmii_rx_dv_reg;
          end
   end


  //--------------------------------------------------------------------
  // RGMII Inband Status Registers
  // extract the inband status from received rgmii data
  //--------------------------------------------------------------------

   // Enable inband status registers during Interframe Gap
   assign inband_ce = !(gmii_rx_dv_reg || gmii_rx_er_reg);

   always @ (posedge rx_clk or posedge rx_reset)
   begin
      if (rx_reset)
	  begin
            link_status         <= 1'b0;
            clock_speed[1:0]    <= 2'b0;
            duplex_status       <= 1'b0;
      end
      else
        if (inband_ce)
	    begin
            link_status      <= gmii_rxd_reg[0];
            clock_speed[1:0] <= gmii_rxd_reg[2:1];
            duplex_status    <= gmii_rxd_reg[3];
        end
   end

   // Route inband status to output buffers.  These are designed to be
   // internal connections within the FPGA fabric.  IOB's are placed on
   // these only for the purpose of allowing them to be visible from the
   // demonstration testbench provided.
   
   assign col_to_mac = (tx_en_from_mac | tx_er_from_mac) & (gmii_rx_dv_reg | gmii_rx_er_reg);
   assign crs_to_mac = (tx_en_from_mac | tx_er_from_mac) | (gmii_rx_dv_reg | gmii_rx_er_reg);   

endmodule

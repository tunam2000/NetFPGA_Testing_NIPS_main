`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:10:20 10/18/2013 
// Design Name: 
// Module Name:    test_gen_mux 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module test_gen_mux
#(
      parameter DATA_WIDTH = 64,
      parameter CTRL_WIDTH = DATA_WIDTH/8,
      parameter UDP_REG_SRC_WIDTH = 2
   )
(
	output     [DATA_WIDTH-1:0]         out_data_0,
	output     [CTRL_WIDTH-1:0]         out_ctrl_0,
	output                              out_wr_0,
	input                               out_rdy_0,
	
	input  [DATA_WIDTH-1:0]             in_data_0,
      input  [CTRL_WIDTH-1:0]             in_ctrl_0,
      output                              in_rdy_0,
      input                               in_wr_0,
		
	input  [DATA_WIDTH-1:0]             in_data_8,
      input  [CTRL_WIDTH-1:0]             in_ctrl_8,
      input                               in_wr_8,
      output                              in_rdy_8,
		
		input  [DATA_WIDTH-1:0]             in_data_a,
      input  [CTRL_WIDTH-1:0]             in_ctrl_a,
      output                              in_rdy_a,
      input                               in_wr_a,
		input											in_reply_a,
		input select,
		// --- Misc
      input                                 clk,
      input reset,
		input [31:0] pkt_numbers_1,
		input port_enable_1

    );
	 wire  [DATA_WIDTH-1:0]             out_data_c;
      wire  [CTRL_WIDTH-1:0]             out_ctrl_c;
		wire out_wr_c;
		wire out_rdy_c;
		wire out_reply_c;
TCP_SYN_GEN_main TCP_SYN_GEN_main_port_1
	(
		.out_data_end       (out_data_c),
		.out_ctrl_end       (out_ctrl_c),
		.out_wr_end         (out_wr_c),
		.out_rdy_end        (out_rdy_c),
		.out_reply_end      (out_reply_c),
		
		.packet_numbers (pkt_numbers_1),
		.port_enable	 (port_enable_1),
		// --- Misc
	                              .clk(clk),
	                               .reset(reset)
	);
port_mux_new
   #(
      .DATA_WIDTH (DATA_WIDTH),
      .CTRL_WIDTH (CTRL_WIDTH)
   ) port_mux_3 (
      // --- data path interface
      .out_data                             (out_data_0),
      .out_ctrl                             (out_ctrl_0),
      .out_wr                               (out_wr_0),
      .out_rdy                              (out_rdy_0),

      .in_data_0                            (in_data_0),
      .in_ctrl_0                            (in_ctrl_0),
      .in_wr_0                              (in_wr_0),
      .in_rdy_0                             (in_rdy_0),

      .in_data_1                            (in_data_8),
      .in_ctrl_1                            (in_ctrl_8),
      .in_wr_1                              (in_wr_8),
      .in_rdy_1                             (in_rdy_8),
		
		.in_data_2                            (in_data_a),
      .in_ctrl_2                            (in_ctrl_a),
      .in_wr_2                              (in_wr_a),
      .in_rdy_2                             (in_rdy_a),
		
		.in_data_3                            (out_data_c),
      .in_ctrl_3                            (out_ctrl_c),
      .in_wr_3                              (out_wr_c),
      .in_rdy_3                             (out_rdy_c),


      // --- Register interface
      .select                               (select),
		.in_reply_2										(in_reply_a),
		.in_reply_3										(out_reply_c),
      // --- Misc
      .clk                                  (clk),
      .reset                                (reset)
   );
	

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:20:11 10/15/2013 
// Design Name: 
// Module Name:    TCP_SYN_GEN 
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
module TCP_SYN_GEN
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
	output                              out_reply_0,
	
	output     [DATA_WIDTH-1:0]         out_data_1,
	output     [CTRL_WIDTH-1:0]         out_ctrl_1,
	output                              out_wr_1,
	input                               out_rdy_1,
	output                              out_reply_1,
// --- Register interface
	input                               reg_req_in,
	input                               reg_ack_in,
	input                               reg_rd_wr_L_in,
	input  [`UDP_REG_ADDR_WIDTH-1:0]    reg_addr_in,
	input  [`CPCI_NF2_DATA_WIDTH-1:0]   reg_data_in,
	input  [UDP_REG_SRC_WIDTH-1:0]      reg_src_in,

	output                              reg_req_out,
	output                              reg_ack_out,
	output                              reg_rd_wr_L_out,
	output [`UDP_REG_ADDR_WIDTH-1:0]    reg_addr_out,
	output [`CPCI_NF2_DATA_WIDTH-1:0]   reg_data_out,
	output [UDP_REG_SRC_WIDTH-1:0]      reg_src_out,

	// --- Misc
	input                               clk,
	input                               reset

    );
	 
	wire      [31:0] IP_dest_begin_0;
	wire      [31:0] IP_dest_end_0;
	wire      [31:0] IP_source_begin_0;
	wire      [31:0] IP_source_end_0;
	wire      [47:0] Mac_dest_begin_0;
	wire      [47:0] Mac_source_begin_0;
	wire      [47:0] Mac_dest_end_0;
	wire      [47:0] Mac_source_end_0;
	wire      [15:0] port_dest_begin_0;
	wire		 [15:0] port_dest_end_0;
	wire		 [15:0] port_source_begin_0;
	wire		 [15:0] port_source_end_0;
	wire      [31:0] pkt_numbers_0;
	wire      port_enable_0;
	
	wire      [31:0] IP_dest_begin_1;
	wire      [31:0] IP_dest_end_1;
	wire      [31:0] IP_source_begin_1;
	wire      [31:0] IP_source_end_1;
	wire      [47:0] Mac_dest_begin_1;
	wire      [47:0] Mac_source_begin_1;
	wire      [47:0] Mac_dest_end_1;
	wire      [47:0] Mac_source_end_1;
	wire      [15:0] port_dest_begin_1;
	wire		 [15:0] port_dest_end_1;
	wire		 [15:0] port_source_begin_1;
	wire		 [15:0] port_source_end_1;
	wire      [31:0] pkt_numbers_1;
	wire      port_enable_1;
	
	
	wire    [447:0]software_regs_0;
	wire    [447:0]software_regs_1;
	
	wire                              reg_req_out_1;
	wire                              reg_ack_out_1;
	wire                              reg_rd_wr_L_out_1;
	wire [`UDP_REG_ADDR_WIDTH-1:0]    reg_addr_out_1;
	wire [`CPCI_NF2_DATA_WIDTH-1:0]   reg_data_out_1;
	wire [UDP_REG_SRC_WIDTH-1:0]      reg_src_out_1;
	
	wire                           	 reg_req_out_2;
	wire                              reg_ack_out_2;
	wire                              reg_rd_wr_L_out_2;
	wire [`UDP_REG_ADDR_WIDTH-1:0]    reg_addr_out_2;
	wire [`CPCI_NF2_DATA_WIDTH-1:0]   reg_data_out_2;
	wire [UDP_REG_SRC_WIDTH-1:0]      reg_src_out_2;
	
	wire send_done_0,send_done_1;
	
	TCP_SYN_GEN_main TCP_SYN_GEN_main_port_0
	(
		.out_data_end       (out_data_0),
		.out_ctrl_end       (out_ctrl_0),
		.out_wr_end         (out_wr_0),
		.out_rdy_end        (out_rdy_0),
		.out_reply_end      (out_reply_0),
		.IP_dest_begin(IP_dest_begin_0),
		.IP_dest_end(IP_dest_end_0),
	.IP_source_begin(IP_source_begin_0),
	.IP_source_end(IP_source_end_0),
	.Mac_dest_begin(Mac_dest_begin_0),
	.Mac_source_begin(Mac_source_begin_0),
	.Mac_dest_end(Mac_dest_end_0),
	.Mac_source_end(Mac_source_end_0),
	.port_dest_begin(port_dest_begin_0),
	.port_dest_end(port_dest_end_0),
	.port_source_begin(port_source_begin_0),
	.port_source_end(port_source_end_0),
	.packet_numbers(pkt_numbers_0),
	.port_enable(port_enable_0),
	.send_done(send_done_0),
		// --- Misc
		.clk                              (clk),
      .reset                            (reset)
		
	);
	
TCP_SYN_GEN_main TCP_SYN_GEN_main_port_1
	(
		.out_data_end       (out_data_1),
		.out_ctrl_end       (out_ctrl_1),
		.out_wr_end         (out_wr_1),
		.out_rdy_end        (out_rdy_1),
		.out_reply_end      (out_reply_1),
		.IP_dest_begin(IP_dest_begin_1),
		.IP_dest_end(IP_dest_end_1),
	.IP_source_begin(IP_source_begin_1),
	.IP_source_end(IP_source_end_1),
	.Mac_dest_begin(Mac_dest_begin_1),
	.Mac_source_begin(Mac_source_begin_1),
	.Mac_dest_end(Mac_dest_end_1),
	.Mac_source_end(Mac_source_end_1),
	.port_dest_begin(port_dest_begin_1),
	.port_dest_end(port_dest_end_1),
	.port_source_begin(port_source_begin_1),
	.port_source_end(port_source_end_1),
	.packet_numbers(pkt_numbers_1),
	.port_enable(port_enable_1),
	.send_done(send_done_1),
		// --- Misc
		.clk                              (clk),
      .reset                            (reset)
		
	);
		
//syn_gen_regs
//     #(.UDP_REG_SRC_WIDTH    (UDP_REG_SRC_WIDTH),
//       .RATE_LIMIT_BLOCK_TAG (19'h54) //0x2001500
//   ) syn_gen_regs
//   (
//      // Registers
//      .reg_req_in       (reg_req_in),
//      .reg_ack_in       (reg_ack_in),
//      .reg_rd_wr_L_in   (reg_rd_wr_L_in),
//      .reg_addr_in      (reg_addr_in),
//      .reg_data_in      (reg_data_in),
//      .reg_src_in       (reg_src_in),
//
//      .reg_req_out      (reg_req_out),
//      .reg_ack_out      (reg_ack_out),
//      .reg_rd_wr_L_out  (reg_rd_wr_L_out),
//      .reg_addr_out     (reg_addr_out),
//      .reg_data_out     (reg_data_out),
//      .reg_src_out      (reg_src_out),
//
//      // Outputs
//      .pkt_numbers_0                   (pkt_numbers_0),
//      .pkt_numbers_1                  	(pkt_numbers_1),
//      .port_enable_0                	(port_enable_0),
//      .port_enable_1                 	(port_enable_1),
//
//      // Inputs
//      .clk                              (clk),
//      .reset                            (reset)
//   );

	generic_sw_regs #(
      .UDP_REG_SRC_WIDTH     (UDP_REG_SRC_WIDTH),
      .TAG                   (18'h2a), //1500
      .REG_ADDR_WIDTH        (5),
      .NUM_REGS_USED         (14)
   ) tcp_gen_regs_0 (
      .reg_req_in                            (reg_req_in),
      .reg_ack_in                            (reg_ack_in),
      .reg_rd_wr_L_in                        (reg_rd_wr_L_in),
      .reg_addr_in                           (reg_addr_in),
      .reg_data_in                           (reg_data_in),
      .reg_src_in                            (reg_src_in),

      .reg_req_out                           (reg_req_out_1),
      .reg_ack_out                           (reg_ack_out_1),
      .reg_rd_wr_L_out                       (reg_rd_wr_L_out_1),
      .reg_addr_out                          (reg_addr_out_1),
      .reg_data_out                          (reg_data_out_1),
      .reg_src_out                           (reg_src_out_1),

      .software_regs                         (software_regs_0),

      .clk                                 (clk),
      .reset                               (reset)
    );
	 generic_sw_regs #(
      .UDP_REG_SRC_WIDTH     (UDP_REG_SRC_WIDTH),
      .TAG                   (18'h2c), //1600
      .REG_ADDR_WIDTH        (5),
      .NUM_REGS_USED         (14)
   ) tcp_gen_regs_1 (
      .reg_req_in                            (reg_req_out_1),
      .reg_ack_in                            (reg_ack_out_1),
      .reg_rd_wr_L_in                        (reg_rd_wr_L_out_1),
      .reg_addr_in                           (reg_addr_out_1),
      .reg_data_in                           (reg_data_out_1),
      .reg_src_in                            (reg_src_out_1),

      .reg_req_out                           (reg_req_out_2),
      .reg_ack_out                           (reg_ack_out_2),
      .reg_rd_wr_L_out                       (reg_rd_wr_L_out_2),
      .reg_addr_out                          (reg_addr_out_2),
      .reg_data_out                          (reg_data_out_2),
      .reg_src_out                           (reg_src_out_2),

      .software_regs                         (software_regs_1),


      .clk                                 (clk),
      .reset                               (reset)
    );
	 
	 generic_hw_regs #(
      .UDP_REG_SRC_WIDTH     (UDP_REG_SRC_WIDTH),
      .TAG                   (18'h34), //1a00
      .REG_ADDR_WIDTH        (5),
      .NUM_REGS_USED         (1)
   ) tcp_gen_regs_2 (
      .reg_req_in                            (reg_req_out_2),
      .reg_ack_in                            (reg_ack_out_2),
      .reg_rd_wr_L_in                        (reg_rd_wr_L_out_2),
      .reg_addr_in                           (reg_addr_out_2),
      .reg_data_in                           (reg_data_out_2),
      .reg_src_in                            (reg_src_out_2),

      .reg_req_out                           (reg_req_out),
      .reg_ack_out                           (reg_ack_out),
      .reg_rd_wr_L_out                       (reg_rd_wr_L_out),
      .reg_addr_out                          (reg_addr_out),
      .reg_data_out                          (reg_data_out),
      .reg_src_out                           (reg_src_out),

      .hardware_regs                         ({30'h0,send_done_1,send_done_0}),


      .clk                                 (clk),
      .reset                               (reset)
    );
	 
	assign port_enable_0 = software_regs_0[0];
	assign pkt_numbers_0 = software_regs_0[63:32];	
	assign Mac_dest_begin_0 = software_regs_0[111:64] ;
	assign Mac_dest_end_0 = software_regs_0[159:112];
	assign Mac_source_begin_0= software_regs_0[207:160];	
	assign Mac_source_end_0 = software_regs_0[255:208];
	assign IP_dest_begin_0 = software_regs_0[287:256];
	assign IP_dest_end_0 = software_regs_0[319:288];//
	assign IP_source_begin_0 = software_regs_0[351:320];
	assign IP_source_end_0 = software_regs_0[383:352];	
	assign port_dest_begin_0 = software_regs_0[399:384];
	assign port_dest_end_0 = software_regs_0[415:400];
	assign port_source_begin_0 = software_regs_0[431:416];
	assign port_source_end_0 = software_regs_0[447:432];
	
	assign port_enable_1 = software_regs_1[0];
	assign pkt_numbers_1 = software_regs_1[63:32];	
	assign Mac_dest_begin_1 = software_regs_1[111:64] ;
	assign Mac_dest_end_1 = software_regs_1[159:112];
	assign Mac_source_begin_1= software_regs_1[207:160];	
	assign Mac_source_end_1 = software_regs_1[255:208];
	assign IP_dest_begin_1 = software_regs_1[287:256];
	assign IP_dest_end_1 = software_regs_1[319:288];
	assign IP_source_begin_1 = software_regs_1[351:320];
	assign IP_source_end_1 = software_regs_1[383:352];	
	assign port_dest_begin_1 = software_regs_1[399:384];
	assign port_dest_end_1 = software_regs_1[415:400];
	assign port_source_begin_1 = software_regs_1[431:416];
	assign port_source_end_1 = software_regs_1[447:432];
endmodule

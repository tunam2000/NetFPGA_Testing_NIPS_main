`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:19:27 10/18/2013
// Design Name:   test_gen_mux
// Module Name:   /home/mtnguyen/ISEp_Packet_gen/Packet_gen/sim_test_gen_mux.v
// Project Name:  Packet_gen
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: test_gen_mux
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "mydefines.v"
module sim_test_gen_mux;

	// Inputs
	reg out_rdy_0;
	reg [63:0] in_data_0;
	reg [7:0] in_ctrl_0;
	reg in_wr_0;
	reg [63:0] in_data_8;
	reg [7:0] in_ctrl_8;
	reg in_wr_8;
	reg [63:0] in_data_a;
	reg [7:0] in_ctrl_a;
	reg in_wr_a;
	reg in_reply_a;
	reg select;
	reg clk;
	reg reset;
	reg [31:0] pkt_numbers_1;
	reg port_enable_1;

	// Outputs
	wire [63:0] out_data_0;
	wire [7:0] out_ctrl_0;
	wire out_wr_0;
	wire in_rdy_0;
	wire in_rdy_8;
	wire in_rdy_a;

	// Instantiate the Unit Under Test (UUT)
	test_gen_mux uut (
		.out_data_0(out_data_0), 
		.out_ctrl_0(out_ctrl_0), 
		.out_wr_0(out_wr_0), 
		.out_rdy_0(out_rdy_0), 
		.in_data_0(in_data_0), 
		.in_ctrl_0(in_ctrl_0), 
		.in_rdy_0(in_rdy_0), 
		.in_wr_0(in_wr_0), 
		.in_data_8(in_data_8), 
		.in_ctrl_8(in_ctrl_8), 
		.in_wr_8(in_wr_8), 
		.in_rdy_8(in_rdy_8), 
		.in_data_a(in_data_a), 
		.in_ctrl_a(in_ctrl_a), 
		.in_rdy_a(in_rdy_a), 
		.in_wr_a(in_wr_a), 
		.in_reply_a(in_reply_a), 
		.select(select), 
		.clk(clk), 
		.reset(reset), 
		.pkt_numbers_1(pkt_numbers_1), 
		.port_enable_1(port_enable_1)
	);

	initial begin
		// Initialize Inputs
		out_rdy_0 = 0;
		
		in_data_0 = 0;
		in_ctrl_0 = 0;
		in_wr_0 = 0;
		
		in_data_8 = 0;
		in_ctrl_8 = 0;
		in_wr_8 = 0;
		
		in_data_a = 0;
		in_ctrl_a = 0;
		in_wr_a = 0;
		in_reply_a = 0;
		
		select = 0;
		clk = 0;
		reset = 1;
		pkt_numbers_1 = 0;
		port_enable_1 = 0;
		#100
		reset = 0;
		#5
		out_rdy_0 = 1;
		#20
		port_enable_1 = 1;
		pkt_numbers_1 = 2;
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      always #5 clk  = ~clk;
endmodule


`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:38:36 10/18/2013
// Design Name:   TCP_SYN_GEN_main
// Module Name:   /home/mtnguyen/ISEp_Packet_gen/Packet_gen/test_tcp_gen.v
// Project Name:  Packet_gen
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TCP_SYN_GEN_main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_tcp_gen;

	// Inputs
	reg out_rdy_end;
	reg [31:0] IP_dest_begin;
	reg [31:0] IP_dest_end;
	reg [31:0] IP_source;
	reg [47:0] Mac_dest;
	reg [47:0] Mac_source;
	reg [15:0] port_dest_begin;
	reg [15:0] port_dest_end;
	reg [15:0] port_source;
	reg [31:0] packet_numbers;
	reg port_enable;
	reg clk;
	reg reset;

	// Outputs
	wire [63:0] out_data_end;
	wire [7:0] out_ctrl_end;
	wire out_wr_end;
	wire out_reply_end;

	// Instantiate the Unit Under Test (UUT)
	TCP_SYN_GEN_main uut (
		.out_data_end(out_data_end), 
		.out_ctrl_end(out_ctrl_end), 
		.out_wr_end(out_wr_end), 
		.out_rdy_end(out_rdy_end), 
		.out_reply_end(out_reply_end), 
//		.IP_dest_begin(IP_dest_begin), 
//		.IP_dest_end(IP_dest_end), 
//		.IP_source(IP_source), 
//		.Mac_dest(Mac_dest), 
//		.Mac_source(Mac_source), 
//		.port_dest_begin(port_dest_begin), 
//		.port_dest_end(port_dest_end), 
//		.port_source(port_source), 
		.packet_numbers(packet_numbers), 
		.port_enable(port_enable), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		out_rdy_end = 0;
		packet_numbers = 0;
		port_enable = 0;
		clk = 0;
		reset = 0;
		#5
		reset = 1;
		#5
		reset = 0;
		port_enable = 1;
		packet_numbers = 2;
		#200
		out_rdy_end = 1;
		
		
		// Wait 100 ns for global reset to finish
		#300
		port_enable = 0;
		#20 
		port_enable = 1;
        
		// Add stimulus here

	end
      always #5 clk  = ~clk;
endmodule


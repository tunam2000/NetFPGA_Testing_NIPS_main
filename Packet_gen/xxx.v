`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:03:54 10/22/2013
// Design Name:   TCP_SYN_GEN_main
// Module Name:   /home/tdnguyen/Desktop/ISEp_Packet_gen/Packet_gen/xxx.v
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

module xxx;

	// Inputs
	reg out_rdy_end;
	reg [31:0] IP_dest_begin;
	reg [31:0] IP_dest_end;
	reg [31:0] IP_source_begin;
	reg [31:0] IP_source_end;
	reg [47:0] Mac_dest_begin;
	reg [47:0] Mac_source_begin;
	reg [47:0] Mac_dest_end;
	reg [47:0] Mac_source_end;
	reg [15:0] port_dest_begin;
	reg [15:0] port_dest_end;
	reg [15:0] port_source_begin;
	reg [15:0] port_source_end;
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
		.IP_dest_begin(IP_dest_begin), 
		.IP_dest_end(IP_dest_end), 
		.IP_source_begin(IP_source_begin), 
		.IP_source_end(IP_source_end), 
		.Mac_dest_begin(Mac_dest_begin), 
		.Mac_source_begin(Mac_source_begin), 
		.Mac_dest_end(Mac_dest_end), 
		.Mac_source_end(Mac_source_end), 
		.port_dest_begin(port_dest_begin), 
		.port_dest_end(port_dest_end), 
		.port_source_begin(port_source_begin), 
		.port_source_end(port_source_end), 
		.packet_numbers(packet_numbers), 
		.port_enable(port_enable), 
		.clk(clk), 
		.reset(reset)
	);
	initial forever #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		out_rdy_end = 0;
		IP_dest_begin = 0;
		IP_dest_end = 0;
		IP_source_begin = 0;
		IP_source_end = 0;
		Mac_dest_begin = 0;
		Mac_source_begin = 0;
		Mac_dest_end = 0;
		Mac_source_end = 0;
		port_dest_begin = 0;
		port_dest_end = 0;
		port_source_begin = 0;
		port_source_end = 0;
		packet_numbers = 0;
		port_enable = 0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
      out_rdy_end = 0;
		IP_dest_begin = 32'h03;
		IP_dest_end = 32'h5;
		IP_source_begin = 32'h01;
		IP_source_end = 32'h5;
		Mac_dest_begin = 48'h1;
		Mac_source_begin = 48'h1;
		Mac_dest_end = 3;
		Mac_source_end = 4;
		port_dest_begin = 16'h1;
		port_dest_end = 5;
		port_source_begin = 16'h1;
		port_source_end = 8;
		packet_numbers = 20;
		port_enable = 0;
		reset = 0; 
		
			#100;
      out_rdy_end = 1;
		port_enable = 1;		
		
		// Add stimulus here

	end
      
endmodule


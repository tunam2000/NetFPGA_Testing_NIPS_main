`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:23:10 10/15/2013 
// Design Name: 
// Module Name:    TCP_SYN_GEN_main 
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
module TCP_SYN_GEN_main
#(
      parameter DATA_WIDTH = 64,
      parameter CTRL_WIDTH = DATA_WIDTH/8
   )
(
output     [DATA_WIDTH-1:0]         out_data_end,
output     [CTRL_WIDTH-1:0]         out_ctrl_end,
output reg                             out_wr_end,
input                               out_rdy_end,
output reg                             out_reply_end,
input      [31:0] IP_dest_begin,
input      [31:0] IP_dest_end,
input      [31:0] IP_source_begin,
input      [31:0] IP_source_end,
input      [47:0] Mac_dest_begin,
input      [47:0] Mac_source_begin,
input      [47:0] Mac_dest_end,
input      [47:0] Mac_source_end,
input      [15:0] port_dest_begin,
input	 [15:0] port_dest_end,
input	 [15:0] port_source_begin,
input	 [15:0] port_source_end,
input      [31:0] packet_numbers,
input	 port_enable,
output reg send_done,
// --- Misc
   input                               clk,
   input                               reset
    );
localparam IDLE       = 0;
localparam END        = 1;
localparam GEN_PKT1        = 5;
localparam GEN_PKT2        = 6;
localparam GEN_PKT3        = 7;
localparam GEN_PKT5        = 8;
localparam GEN_PKT6       = 9;
localparam GEN_PKT7       = 10;
localparam GEN_PKT8       = 11;
localparam GEN_PKT9       = 12;
localparam GEN_PKT4       = 13;
localparam GEN_PKT10       = 15;
localparam GEN_PKT11       = 16;
localparam GEN_PKT12       = 17;
localparam GEN_PKT13       = 14;
 
reg [4:0]            state, state_nxt;

reg [CTRL_WIDTH-1:0] out_ctrl_nxt;
   reg [DATA_WIDTH-1:0] out_data_nxt;
   reg                  out_wr_nxt;
reg [CTRL_WIDTH-1:0] out_ctrl;
   reg [DATA_WIDTH-1:0] out_data;
   reg                  out_wr;
reg [31:0] pkt_cnt;
reg  begin_a_packet;
reg  begin_a_packet_nxt;
reg  end_a_packet;
reg  end_a_packet_nxt;
wire in_fifo_emty;
reg send_done_nxt;
//-------reg-Thanh

wire [31:0] SEQ;
assign SEQ = pkt_cnt;
reg [23:0] checksum_IP, checksum_TCP; 
wire [15:0] checksum_16bit_IP, checksum_16bit_TCP;
//wire [31:0] SEQ_plus1, ACK_plus1;
reg [47:0] D_MAC_adj, S_MAC_adj;
reg [31:0] D_IP_adj, S_IP_adj;
reg [15:0] D_PORT_adj, S_PORT_adj;


wire [15:0] identify;
assign identify = pkt_cnt[15:0];
assign checksum_16bit_IP = ~(checksum_IP[15:0] + {8'h00,checksum_IP[23:16]});
assign checksum_16bit_TCP = ~(checksum_TCP[15:0] + {8'h00,checksum_TCP[23:16]});
//--------end---reg--Thanh
//----------------------- Modules ---------------------------------
   small_fifo #(.WIDTH(CTRL_WIDTH+DATA_WIDTH), .MAX_DEPTH_BITS(2), .PROG_FULL_THRESHOLD(3))
      input_fifo_gen
        (.din           ({out_ctrl, out_data}),  // Data in
         .wr_en         (out_wr),             // Write enable
         .rd_en         (in_fifo_rd_en),    // Read the next word
         .dout          ({out_ctrl_end, out_data_end}),
         .full          (),
         .nearly_full   (in_fifo_nearly_full),
         .empty         (in_fifo_empty),
         .reset         (reset),
         .clk           (clk)
         );
assign in_fifo_rd_en = out_rdy_end && !in_fifo_empty;
always @(posedge clk) begin
      out_wr_end <= reset ? 0 : in_fifo_rd_en;
out_reply_end <= reset ? 0 : !in_fifo_empty;
   end
	

always @(*) begin
	state_nxt = state;
	out_ctrl_nxt = 8'h0;
	out_data_nxt = 64'h0;
	out_wr_nxt = 1'h0;
	begin_a_packet_nxt = 'h0;
	end_a_packet_nxt = 'h0;
	send_done_nxt = 1'b0;
if(reset) begin
	state_nxt = IDLE;
	
end
else begin
	case (state)
	IDLE:begin
	if(port_enable == 1'b1)begin
	state_nxt = GEN_PKT1;
	end	
	end
	GEN_PKT1:begin
		if(!in_fifo_nearly_full)begin
			state_nxt = GEN_PKT2;
			out_data_nxt = {16'h4,16'd8,16'h3,16'd62};
			out_ctrl_nxt = 8'hff;
			out_wr_nxt = 1'b1;
			begin_a_packet_nxt = 1;
		end	
	end
	GEN_PKT2:begin
		if(!in_fifo_nearly_full)begin
			state_nxt = GEN_PKT3;
			out_data_nxt = {D_MAC_adj,S_MAC_adj[47:32]};
			out_ctrl_nxt = 8'h00;
			out_wr_nxt = 1'b1;
		end	
	end
	GEN_PKT3:begin
		if(!in_fifo_nearly_full)begin
			state_nxt = GEN_PKT4;
			out_data_nxt = {S_MAC_adj[31:0],32'h08004500};
			out_ctrl_nxt = 8'h00;
			out_wr_nxt = 1'b1;
		end	
	end
	GEN_PKT4:begin
		if(!in_fifo_nearly_full)begin
			state_nxt = GEN_PKT5;
			out_data_nxt = {16'd48,identify,32'h40008006};
			out_ctrl_nxt = 8'h00;
			out_wr_nxt = 1'b1;
		end	
	end
	GEN_PKT5:begin
		if(!in_fifo_nearly_full)begin
			state_nxt = GEN_PKT6;
			out_data_nxt = {checksum_16bit_IP,S_IP_adj,D_IP_adj[31:16]};
			out_ctrl_nxt = 8'h00;
			out_wr_nxt = 1'b1;
		end	
	end
	GEN_PKT6:begin
		if(!in_fifo_nearly_full)begin
			state_nxt = GEN_PKT7;
			out_data_nxt = {D_IP_adj[15:0],S_PORT_adj,D_PORT_adj,SEQ[31:16]};//SYN, ack is zero
			out_ctrl_nxt = 8'h00;
			out_wr_nxt = 1'b1;
		end	
	end
	GEN_PKT7:begin
		if(!in_fifo_nearly_full)begin
			state_nxt = GEN_PKT8;
			out_data_nxt = {SEQ[15:0],32'h0000,16'h7002};
			out_ctrl_nxt = 8'h00;
			out_wr_nxt = 1'b1;
		end	
	end
	GEN_PKT8:begin
	if(!in_fifo_nearly_full)begin
			state_nxt = GEN_PKT9;
			out_data_nxt = {16'h16d0,checksum_16bit_TCP,32'h00000204};
			out_ctrl_nxt = 8'h00;
			out_wr_nxt = 1'b1;
			end_a_packet_nxt = 1'b1;
		end	
	end
	GEN_PKT9:begin
		if(!in_fifo_nearly_full)begin
			if(pkt_cnt == packet_numbers)begin
				state_nxt = END;
			end 
			else begin
				state_nxt = GEN_PKT1;
			end
			out_data_nxt = 64'h05b4010104020000;
			out_ctrl_nxt = 8'h04;
			out_wr_nxt = 1'b1;
		end	
	end
	END:begin
		send_done_nxt = 1'b1;
		if(port_enable==1'b0)begin
			state_nxt = IDLE;
		end
	end
	endcase
end
end //end always @*



always @(posedge clk)begin
	state       <= state_nxt;
	out_data <= out_data_nxt;
	out_ctrl <= out_ctrl_nxt;
	out_wr <= out_wr_nxt;
	begin_a_packet <= begin_a_packet_nxt;
	end_a_packet <= end_a_packet_nxt;
	send_done <= send_done_nxt;
end



always @(posedge clk) begin
	if(reset || port_enable == 1'b0) begin
		pkt_cnt <=32'h0;
	end
	else begin
		if(!in_fifo_nearly_full) begin	
			if(begin_a_packet)begin
				pkt_cnt <= pkt_cnt+1; //cho nay coi chung sai 
			end 
			case(state)	
			GEN_PKT1: begin
				checksum_IP <= 24'h10537;
				checksum_TCP <= 24'h0935f; //6c9f
			end
			GEN_PKT2: begin
				checksum_IP <= checksum_IP + identify + S_IP_adj[31:16];
				checksum_TCP <= checksum_TCP + S_IP_adj[31:16] + S_IP_adj[15:0];
			end
			GEN_PKT3: begin
				checksum_IP <= checksum_IP + S_IP_adj[15:0] + D_IP_adj[31:16];
				checksum_TCP <= checksum_TCP + D_IP_adj[31:16] + D_IP_adj[15:0];
			end
			GEN_PKT4: begin
				checksum_IP <= checksum_IP + D_IP_adj[15:0] ;
				checksum_TCP <= checksum_TCP + S_PORT_adj + D_PORT_adj;
			end
			GEN_PKT5: begin
				checksum_IP <= checksum_IP ;
				checksum_TCP <= checksum_TCP  + SEQ[31:16] + SEQ[15:0];
			end
			default: begin
				checksum_IP <= checksum_IP;
				checksum_TCP <= checksum_TCP;
			end
			endcase
		end
	end
end


///vong lap tinh du lieu tao goi
always @(posedge clk)begin
	if(reset || port_enable == 1'b0)begin
		  D_MAC_adj <= Mac_dest_begin;
		  S_MAC_adj <= Mac_source_begin;	
		  D_IP_adj <= IP_dest_begin;	
		  S_IP_adj <= IP_source_begin;
		  D_PORT_adj <= port_dest_begin;
		  S_PORT_adj <= port_source_begin;
	end
	else begin
		if(end_a_packet)begin
			if(Mac_dest_begin != Mac_dest_end)begin
				if(D_MAC_adj == Mac_dest_end)begin
					D_MAC_adj <= Mac_dest_begin;
				end
				else begin
					D_MAC_adj <= D_MAC_adj +1;
				end
			end
		
			if(Mac_source_begin != Mac_source_end)begin
				if(S_MAC_adj == Mac_source_end)begin
					S_MAC_adj <= Mac_source_begin;
				end
				else begin
					S_MAC_adj <= S_MAC_adj +1;
				end
			end
			
			if(IP_dest_begin != IP_dest_end)begin
				if(D_IP_adj == IP_dest_end)begin
					D_IP_adj <= IP_dest_begin;
				end
				else begin
					D_IP_adj <= D_IP_adj +1;
				end
			end
			
			if(IP_source_begin != IP_source_end)begin
				if(S_IP_adj == IP_source_end)begin
					S_IP_adj <= IP_source_begin;
				end
				else begin
					S_IP_adj <= S_IP_adj +1;
				end
			end
		
			if(port_dest_begin != port_dest_end)begin
				if(D_PORT_adj == port_dest_end)begin
					D_PORT_adj <= port_dest_begin;
				end
				else begin
					D_PORT_adj <= D_PORT_adj +1;
				end
			end
			
			if(port_source_begin != port_source_end)begin
				if(S_PORT_adj == port_source_end)begin
					S_PORT_adj <= port_source_begin;
				end
				else begin
					S_PORT_adj <= S_PORT_adj +1;
				end
			end
				
		end
	end	
end



endmodule

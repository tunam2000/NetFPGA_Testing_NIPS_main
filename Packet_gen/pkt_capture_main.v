///////////////////////////////////////////////////////////////////////////////
// vim:set shiftwidth=3 softtabstop=3 expandtab:
// $Id: pkt_capture_main.v 5900 2010-02-09 20:35:23Z grg $
//
// Module: pkt_capture_main.v
// Project: Packet generator
// Description: Main packet capture module
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module pkt_capture_main
   #(
      parameter DATA_WIDTH = 64,
      parameter CTRL_WIDTH = DATA_WIDTH/8,
      parameter IO_QUEUE_STAGE_NUM = `IO_QUEUE_STAGE_NUM,
      parameter TIMESTAMP_CTRL  = 'hfe,
      parameter BYTE_CNT_WIDTH = 40,
      parameter TIME_WIDTH = 64
   )
   (
      // --- data path interface
      output reg [DATA_WIDTH-1:0]         out_data,
      output reg [CTRL_WIDTH-1:0]         out_ctrl,
      output reg                          out_wr,
      input                               out_rdy,
		
		output reg [DATA_WIDTH-1:0]         out_data_a,
      output reg [CTRL_WIDTH-1:0]         out_ctrl_a,
      output reg                          out_wr_a,
      input                               out_rdy_a,
		output reg 		                    out_reply_a,
		
		output reg [DATA_WIDTH-1:0]         out_data_b,
      output reg [CTRL_WIDTH-1:0]         out_ctrl_b,
      output reg                          out_wr_b,
      input                               out_rdy_b,
		output reg 		                    out_reply_b,

      input  [DATA_WIDTH-1:0]             in_data,
      input  [CTRL_WIDTH-1:0]             in_ctrl,
      input                               in_wr,
      output                              in_rdy,

      // --- Register interface
      input [3:0]                         enable,
      input [3:0]                         drop,

      output [`CPCI_NF2_DATA_WIDTH - 1:0] pkt_cnt_0,
      output [BYTE_CNT_WIDTH - 1:0]       byte_cnt_0,
      output [TIME_WIDTH - 1:0]           time_first_0,
      output [TIME_WIDTH - 1:0]           time_last_0,

      output [`CPCI_NF2_DATA_WIDTH - 1:0] pkt_cnt_1,
      output [BYTE_CNT_WIDTH - 1:0]       byte_cnt_1,
      output [TIME_WIDTH - 1:0]           time_first_1,
      output [TIME_WIDTH - 1:0]           time_last_1,

		output [31:0]  tcp_count_0 ,
		output [31:0]  udp_count_0 ,
		output [31:0]  icmp_count_0 ,
		output [31:0]  SYN_ACK_count_0,
		output [31:0]  SYN_count_0 ,
		output [31:0]  ACK_count_0 ,
		
		output [31:0]  tcp_count_1 ,
		output [31:0]  udp_count_1 ,
		output [31:0]  icmp_count_1 ,
		output [31:0]  SYN_ACK_count_1,
		output [31:0]  SYN_count_1 ,
		output [31:0]  ACK_count_1 ,

		

      // --- Misc
      input                               clk,
      input                               reset
   );

   // Include the log2 function
   `LOG2_FUNC

   //--------------------- Internal Parameter-------------------------
   localparam IN_MODULE_HDRS  = 0;
   localparam ADD_PKT_HDR     = 1;
   localparam ADD_TIMESTAMP   = 2;
   localparam IN_PACKET       = 3;
   localparam DROP_HDR        = 4;
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
	
   localparam DA              = {`PKT_CAP_DA};
   localparam SA              = {`PKT_CAP_SA};
   localparam ETHERTYPE       = `PKT_CAP_ETHERTYPE;

   localparam NUM_MACS        = 4;
   localparam NUM_MACS_WIDTH  = log2(NUM_MACS);

   //---------------------- Wires/Regs -------------------------------
   reg [15:0]           one_hot_src;
   reg [NUM_MACS_WIDTH-1:0] src;
   reg [NUM_MACS_WIDTH-1:0] src_held;
   reg [NUM_MACS_WIDTH-1:0] src_held_nxt;
   reg [4:0]            state, state_nxt;
   reg [4:0]            state_d1;
   wire [15:0]          enable_mapped;
   wire [15:0]          drop_mapped;

   reg [31:0]           pkt_cnt[NUM_MACS-1:0];
   reg [39:0]           byte_cnt[NUM_MACS-1:0];
   reg [63:0]           time_first[NUM_MACS-1:0];
   reg [63:0]           time_last[NUM_MACS-1:0];

   reg [15:0]           pkt_len;

   reg [NUM_MACS-1:0]   first_pkt;
   wire [NUM_MACS-1:0]  want_reset;
   reg [NUM_MACS-1:0]   enable_d1;

   reg                  process_pkt;
   reg                  process_pkt_nxt;
   reg                  capture_pkt;
   reg                  in_pkt;
   reg                  in_pkt_nxt;
   reg                  drop_pkt;
   reg                  drop_pkt_nxt;

   wire [DATA_WIDTH-1:0] fifo_out_data;
   wire [CTRL_WIDTH-1:0] fifo_out_ctrl;
   reg  [CTRL_WIDTH-1:0] fifo_out_ctrl_d1;
	reg  [DATA_WIDTH-1:0] fifo_out_data_d1;
	

  
   reg [CTRL_WIDTH-1:0] out_ctrl_nxt;
   reg [DATA_WIDTH-1:0] out_data_nxt;
   reg                  out_wr_nxt;

	reg [CTRL_WIDTH-1:0] out_ctrl_reply_nxt[NUM_MACS_WIDTH-1:0];
   reg [DATA_WIDTH-1:0] out_data_reply_nxt[NUM_MACS_WIDTH-1:0];
   reg                  out_wr_reply_nxt[NUM_MACS_WIDTH-1:0];
	reg                  out_reply_nxt [NUM_MACS_WIDTH-1:0];
	wire [1:0]                out_rdy_reply ;
	assign               out_rdy_reply = {out_rdy_b,out_rdy_a};
	
	
   reg                  in_fifo_rd_en;

   integer              i;
	
	reg[31:0] tcp_count[NUM_MACS-1:0];
	reg[31:0] udp_count[NUM_MACS-1:0];
	reg[31:0] icmp_count[NUM_MACS-1:0];
	reg[31:0] ACK_count[NUM_MACS-1:0];
	reg[31:0] SYN_ACK_count[NUM_MACS-1:0];
	reg[31:0] SYN_count[NUM_MACS-1:0];
	reg[31:0] in_pkt_64bit_count[NUM_MACS-1:0];
	reg is_pkt_TCP;
	reg is_SYN_TCP;
	reg is_SYN_ACK;
	reg is_ACK_TCP;
	reg is_SYN_TCP_nxt;
	reg is_SYN_ACK_nxt;
	reg is_ACK_TCP_nxt;
	
	reg [47:0] D_MAC, D_MAC_nxt, S_MAC, S_MAC_nxt;
	reg [31:0] D_IP, D_IP_nxt, S_IP, S_IP_nxt;
	reg [15:0] D_PORT, D_PORT_nxt, S_PORT, S_PORT_nxt;
	
	reg [31:0] SEQ, SEQ_nxt, ACK, ACK_nxt;
	reg [23:0] checksum_IP, checksum_IP_nxt, checksum_TCP, checksum_TCP_nxt;
	
	wire [15:0] checksum_16bit_IP, checksum_16bit_TCP;
	assign checksum_16bit_IP = ~(checksum_IP[15:0] + {8'h00,checksum_IP[23:16]});
	assign checksum_16bit_TCP = ~(checksum_TCP[15:0] + {8'h00,checksum_TCP[23:16]});
	wire [31:0] SEQ_plus1, ACK_plus1;
	assign SEQ_plus1 = SEQ +1;//(is_SYN_TCP)? SEQ + 1 : SEQ;
	assign ACK_plus1 = ACK +1;//(is_SYN_ACK)? ACK : ACK + 1;
	
	wire [15:0] identify;
	assign identify = pkt_cnt[src_held][15:0];
	
   //----------------------- Modules ---------------------------------
   fallthrough_small_fifo #(.WIDTH(CTRL_WIDTH+DATA_WIDTH), .MAX_DEPTH_BITS(2), .PROG_FULL_THRESHOLD(3))
      input_fifo
        (.din           ({in_ctrl, in_data}),  // Data in
         .wr_en         (in_wr),             // Write enable
         .rd_en         (in_fifo_rd_en),    // Read the next word
         .dout          ({fifo_out_ctrl, fifo_out_data}),
         .full          (),
         .nearly_full   (in_fifo_nearly_full),
         .empty         (in_fifo_empty),
         .reset         (reset),
         .clk           (clk)
         );

   //----------------------- Logic ---------------------------------

   assign in_rdy = !in_fifo_nearly_full;
   assign want_reset = ~enable_d1 & enable;

   /* pkt is from the cpu if it comes in on an odd numbered port */
   assign pkt_is_from_cpu = in_data[`IOQ_SRC_PORT_POS];

   /* Decode the source port */
   always @(*) begin
      one_hot_src = 0;
      one_hot_src[fifo_out_data[`IOQ_SRC_PORT_POS+15:`IOQ_SRC_PORT_POS]] = 1'b1;
      src = fifo_out_data[`IOQ_SRC_PORT_POS+NUM_MACS_WIDTH:`IOQ_SRC_PORT_POS+1];
   end
   assign enable_mapped = {
      8'b0,
      1'b0, enable[3],
      1'b0, enable[2],
      1'b0, enable[1],
      1'b0, enable[0]
      };

   assign drop_mapped = {
      8'b0,
      1'b0, drop[3] & enable[3],
      1'b0, drop[2] & enable[2],
      1'b0, drop[1] & enable[1],
      1'b0, drop[0] & enable[0]
      };

   // Track location and modify packet
   always @* begin
      state_nxt = state;
      in_pkt_nxt = in_pkt;
      drop_pkt_nxt = drop_pkt;
      process_pkt_nxt = process_pkt;
      src_held_nxt = src_held;

      out_ctrl_nxt = fifo_out_ctrl;
      out_data_nxt = fifo_out_data;
      out_wr_nxt = 1'b0;
		
		out_ctrl_reply_nxt[0] = 'h0;
      out_data_reply_nxt[0] = 'h0;
      out_wr_reply_nxt[0] = 1'b0;
		out_reply_nxt[0] = 1'b0;
		
		out_ctrl_reply_nxt[1] = 'h0;
      out_data_reply_nxt[1] = 'h0;
      out_wr_reply_nxt[1] = 1'b0;
		out_reply_nxt[1] = 1'b0;

      in_fifo_rd_en = 1'b0;
		
		is_SYN_TCP_nxt =is_SYN_TCP;
		is_SYN_ACK_nxt =is_SYN_ACK;
		is_ACK_TCP_nxt =is_ACK_TCP;
		
		D_MAC_nxt = D_MAC;
		S_MAC_nxt = S_MAC;
		D_IP_nxt = D_IP;
		S_IP_nxt = S_IP;
		D_PORT_nxt = D_PORT;
		S_PORT_nxt = S_PORT;
		SEQ_nxt = SEQ;
		ACK_nxt = ACK;
		checksum_IP_nxt = checksum_IP;
		checksum_TCP_nxt = checksum_TCP;
		
      if(reset) begin
         state_nxt = IN_MODULE_HDRS;
         in_pkt_nxt = 1'b0;
         drop_pkt_nxt = 1'b0;

         process_pkt_nxt = 1'b0;
         src_held_nxt = 'h0;
			is_SYN_TCP_nxt =1'h0;
			is_SYN_ACK_nxt =1'h0;
			is_ACK_TCP_nxt =1'h0;
			
			D_MAC_nxt = 48'h00;
			S_MAC_nxt = 48'h00;
			D_IP_nxt = 32'h00;
			S_IP_nxt = 32'h00;
			D_PORT_nxt = 16'h00;
			S_PORT_nxt = 16'h00;
			SEQ_nxt = 32'h00;
			ACK_nxt = 32'h00;
			checksum_IP_nxt = 24'h00;
			checksum_TCP_nxt = 24'h00;
      end
      else begin
         case (state)
            IN_MODULE_HDRS: begin
               if (!in_fifo_empty && out_rdy) begin
                  // By default we want to write out the words that come in
                  in_fifo_rd_en = 1'b1;
                  out_wr_nxt = 1;

                  // Record that we've started processing a packet
                  in_pkt_nxt = 1'b1;

                  // Work out how to modify the data
							
                  if (fifo_out_ctrl == IO_QUEUE_STAGE_NUM) begin
                     process_pkt_nxt = |(enable_mapped & one_hot_src);
                     if ( |(drop_mapped & one_hot_src) ) begin
                        state_nxt = DROP_HDR;
                        drop_pkt_nxt = 1'b1;
                        out_wr_nxt = 0;
                     end
                     src_held_nxt = src;

                     // Update the length if we're keeping the timestamp header
                     if (enable_mapped & one_hot_src) begin
                        out_data_nxt[`IOQ_BYTE_LEN_POS+15:`IOQ_BYTE_LEN_POS] = fifo_out_data[`IOQ_BYTE_LEN_POS+15:`IOQ_BYTE_LEN_POS] + 'd24;
                        out_data_nxt[`IOQ_WORD_LEN_POS+15:`IOQ_WORD_LEN_POS] = fifo_out_data[`IOQ_WORD_LEN_POS+15:`IOQ_WORD_LEN_POS] + 'd3;
                     end
                  end
                  else if (fifo_out_ctrl == TIMESTAMP_CTRL) begin
                     // Work out if we're adding the timestamp in which case
                     // we need to add a DA/SA and ethertype
                     if (process_pkt) begin
                        state_nxt = ADD_PKT_HDR;
                        out_data_nxt = {DA, SA[47:32]};
                        out_ctrl_nxt = 'h0;

                        // Don't pull out any more words -- we need to write
                        // the timestamp into the packet
                        in_fifo_rd_en = 1'b0;
                     end
                     else begin
                        // Drop the timestamp
                        out_wr_nxt = 'h0;
                     end
                  end
                  else if (fifo_out_ctrl == 0) begin
                     state_nxt = IN_PACKET;
                  end
               end
            end // case: IN_MODULE_HDRS
				
				
            ADD_PKT_HDR: begin
               if (out_rdy) begin
                  state_nxt = ADD_TIMESTAMP;
                  out_data_nxt = {SA[31:0], ETHERTYPE, 16'h0};
                  out_ctrl_nxt = 'h0;
                  out_wr_nxt = 'h1;
               end
            end

            ADD_TIMESTAMP: begin
               // Note: assumption is that the timestamp header is the last
               // one in the packet
               if (!in_fifo_empty && out_rdy) begin
                  state_nxt = IN_PACKET;

                  in_fifo_rd_en = 1'b1;

                  out_ctrl_nxt = 'h0;
                  out_wr_nxt = 1'b1;
               end
            end

            IN_PACKET: begin
               if (!in_fifo_empty && (out_rdy || drop_pkt)) begin
                  in_fifo_rd_en = 1'b1;
                  out_wr_nxt = ~drop_pkt;

                  if (fifo_out_ctrl != 0) begin
							if(fifo_out_ctrl != 8'hfe && fifo_out_ctrl != 8'hff && fifo_out_ctrl != 8'hfd && (is_SYN_TCP || is_SYN_ACK))begin
								state_nxt = GEN_PKT1;
							end
							else begin
								state_nxt = IN_MODULE_HDRS;
							end
							in_pkt_nxt = 1'b0;
							process_pkt_nxt = 1'b0;
							drop_pkt_nxt = 1'b0;							
                  end
               end
            end
				
            DROP_HDR: begin
               // Note: assumption is that the timestamp header is the last
               // one in the packet
               if (!in_fifo_empty) begin
                  if (fifo_out_ctrl == 0)
                     state_nxt = IN_PACKET;

                  in_fifo_rd_en = 1'b1;

                  out_wr_nxt = 1'b0;
               end
            end
				GEN_PKT1: begin
					in_fifo_rd_en = 1'b0;
					out_wr_nxt = 1'b0;
					out_reply_nxt[src_held] = 1'h1;
					if(out_rdy_reply!=2'h0)begin
						state_nxt = GEN_PKT2;
						out_data_reply_nxt[src_held]= {16'h4,16'd8,16'h3,16'd62};			
						out_ctrl_reply_nxt[src_held] = 'hff;
						out_wr_reply_nxt[src_held] = 1'b1;
					end
						
				end //case:GEN_PKT
				GEN_PKT2: begin
					out_reply_nxt[src_held] = 1'h1;
					if(out_rdy_reply!=2'h0)begin
						state_nxt = GEN_PKT3;
						out_data_reply_nxt[src_held] = {S_MAC,D_MAC[47:32]};					
						out_ctrl_reply_nxt[src_held] = 'h0;
						out_wr_reply_nxt[src_held] = 1'b1;
						out_wr_nxt = 1'b0;
						in_fifo_rd_en = 1'b0;
					end
				end //case:GEN_PKT
				GEN_PKT3: begin
					out_reply_nxt[src_held] = 1'h1;
					if(out_rdy_reply!=2'h0)begin
						state_nxt = GEN_PKT4;
						out_data_reply_nxt[src_held] = {D_MAC[31:0],32'h08004500};					
						out_ctrl_reply_nxt[src_held] = 'h0;
						out_wr_reply_nxt[src_held] = 1'b1;
						out_wr_nxt = 1'b0;
						in_fifo_rd_en = 1'b0;
					end
				end //case:GEN_PKT
				GEN_PKT4: begin
					out_reply_nxt[src_held] = 1'h1;
					if(out_rdy_reply!=2'h0)begin
						state_nxt = GEN_PKT5;
						//if (src_held == 0)out_data_reply_nxt[src_held] = {16'd48,pkt_cnt_0[15:0],32'h40008006};//ttl = 128, pkt_cnt?????? -> identify	
						out_data_reply_nxt[src_held] = {16'd48,identify,32'h40008006};//ttl = 128, pkt_cnt?????? -> identify					
						out_ctrl_reply_nxt[src_held] = 'h0;
						out_wr_reply_nxt[src_held] = 1'b1;
						out_wr_nxt = 1'b0;
						in_fifo_rd_en = 1'b0;
					end	
				end //case:GEN_PKT
				GEN_PKT5: begin
					out_reply_nxt[src_held] = 1'h1;
					if(out_rdy_reply!=2'h0)begin
						state_nxt = GEN_PKT6;
						out_data_reply_nxt[src_held] = {checksum_16bit_IP,D_IP,S_IP[31:16]};					
						out_ctrl_reply_nxt[src_held] = 'h0;
						out_wr_reply_nxt[src_held] = 1'b1;
						out_wr_nxt = 1'b0;
						in_fifo_rd_en = 1'b0;
					end
				end //case:GEN_PKT
				GEN_PKT6: begin
					out_reply_nxt[src_held] = 1'h1;
					if(out_rdy_reply!=2'h0)begin
						state_nxt = GEN_PKT7;
						if (is_SYN_TCP) out_data_reply_nxt[src_held] = {S_IP[15:0],D_PORT,S_PORT,ACK_plus1[31:16]};					
						if (is_SYN_ACK) out_data_reply_nxt[src_held] = {S_IP[15:0],D_PORT,S_PORT,ACK[31:16]};	
						out_ctrl_reply_nxt[src_held] = 'h0;
						out_wr_reply_nxt[src_held] = 1'b1;
						out_wr_nxt = 1'b0;
						in_fifo_rd_en = 1'b0;
					end	
				end //case:GEN_PKT
				GEN_PKT7: begin
					out_reply_nxt[src_held] = 1'h1;
					if(out_rdy_reply!=2'h0)begin
						state_nxt = GEN_PKT8;
						if (is_SYN_TCP) out_data_reply_nxt[src_held] = {ACK_plus1[15:0],SEQ_plus1,16'h7012}; //swap SEQ and ACK					
						if (is_SYN_ACK) out_data_reply_nxt[src_held] = {ACK[15:0],SEQ,16'h7010};					
						out_ctrl_reply_nxt[src_held] = 'h0;
						out_wr_reply_nxt[src_held] = 1'b1;
						out_wr_nxt = 1'b0;
						in_fifo_rd_en = 1'b0;
					end	
				end //case:GEN_PKT
				GEN_PKT8: begin
					out_reply_nxt[src_held] = 1'h1;
					if(out_rdy_reply!=2'h0)begin
						state_nxt = GEN_PKT9;
						out_data_reply_nxt[src_held] = {16'h16d0,checksum_16bit_TCP,32'h00000204};//'h16d05bdc00000204;					
						out_ctrl_reply_nxt[src_held] = 'h0;
						out_wr_reply_nxt[src_held] = 1'b1;
						out_wr_nxt = 1'b0;
						in_fifo_rd_en = 1'b0;
					end	
				end //case:GEN_PKT
				GEN_PKT9: begin
					out_reply_nxt[src_held] = 1'h1;
					if(out_rdy_reply!=2'h0)begin
						state_nxt = GEN_PKT10;
						out_data_reply_nxt[src_held] = 'h0564010104020000;//set  MSS ...					
						out_ctrl_reply_nxt[src_held] = 'h4;
						out_wr_reply_nxt[src_held] = 1'b1;
						out_wr_nxt = 1'b0;
						in_fifo_rd_en = 1'b0;
					end
					is_SYN_TCP_nxt =1'h0;
					is_SYN_ACK_nxt =1'h0;
					is_ACK_TCP_nxt =1'h0;
				end //case:GEN_PKT
				GEN_PKT10: begin
					out_reply_nxt[src_held] = 1'h0;
					out_wr_reply_nxt[src_held] = 1'b0;
					in_fifo_rd_en = 1'b0;
					out_wr_nxt = 1'b0;
					if (!in_fifo_empty && out_rdy)begin
						state_nxt = IN_MODULE_HDRS;				
					end
				end //case:GEN_PKT
         endcase // case(state)
      end
   end // always @ (*)

   always @(posedge clk) begin
      state       <= state_nxt;
      in_pkt      <= in_pkt_nxt;
      drop_pkt    <= drop_pkt_nxt;
      process_pkt <= process_pkt_nxt;
      src_held    <= src_held_nxt;

      out_ctrl    <= out_ctrl_nxt;
      out_data    <= out_data_nxt;
      out_wr      <= out_wr_nxt;
		
		out_ctrl_a    <= out_ctrl_reply_nxt[0];
      out_data_a    <= out_data_reply_nxt[0];
      out_wr_a      <= out_wr_reply_nxt[0];
		out_reply_a   <= out_reply_nxt[0];
		
		out_ctrl_b    <= out_ctrl_reply_nxt[1];
      out_data_b    <= out_data_reply_nxt[1];
      out_wr_b      <= out_wr_reply_nxt[1];
		out_reply_b   <= out_reply_nxt[1];
   end

   // Counter/timer management
   always @(posedge clk) begin
      if(reset) begin
         for (i = 0; i < NUM_MACS; i = i + 1) begin
            pkt_cnt[i] <= 32'h0;
            byte_cnt[i] <= 40'h0;
            time_first[i] <= 64'h0;
            time_last[i] <= 64'h0;

            first_pkt[i] <= 1'b1;

            capture_pkt <= 1'b0;
				tcp_count[i]	<= 32'h0;
				udp_count[i]	<=	32'h0;
				icmp_count[i]	<=	32'h0;
				in_pkt_64bit_count[i]<=32'h0;
				ACK_count[i] <= 32'h0;
				SYN_count[i] <= 32'h0;
				SYN_ACK_count[i] <= 32'h0;
         end

         fifo_out_ctrl_d1 <= 'hab;
			fifo_out_data_d1 <= 'h0;
         state_d1 <= 'h0;
			is_pkt_TCP <= 1'h0;
			is_SYN_TCP <=1'h0;
			is_SYN_ACK <=1'h0;
			is_ACK_TCP <=1'h0;
			
			D_MAC <= 48'h00;
			S_MAC <= 48'h00;
			D_IP <= 32'h00;
			S_IP <= 32'h00;
			D_PORT <= 16'h00;
			S_PORT <= 16'h00;
			SEQ <= 32'h00;
			ACK <= 32'h00;
			checksum_IP <= 24'h00;
			checksum_TCP <= 24'h00;
      end
      else begin
         // Update the registers
         if (|want_reset) begin
            for (i = 0; i < NUM_MACS; i = i + 1) begin
               if (want_reset[i]) begin
                  pkt_cnt[i] <= 32'h0;
                  byte_cnt[i] <= 40'h0;
                  time_first[i] <= 64'h0;
                  time_last[i] <= 64'h0;

                  first_pkt[i] <= 1'b1;

                  capture_pkt <= 1'b0;
						tcp_count[i]	<= 32'h0;
						udp_count[i]	<=	32'h0;
						icmp_count[i]	<=	32'h0;
						in_pkt_64bit_count[i]<=32'h0;
						is_pkt_TCP <=1'h0;
						is_SYN_TCP <=1'h0;
						is_SYN_ACK <=1'h0;
						is_ACK_TCP <=1'h0;
						ACK_count[i] <= 32'h0;
						SYN_count[i] <= 32'h0;
						SYN_ACK_count[i] <= 32'h0;
               end
            end
         end
         else begin
					is_SYN_TCP <=is_SYN_TCP_nxt;
					is_SYN_ACK <=is_SYN_ACK_nxt;
					is_ACK_TCP <=is_ACK_TCP_nxt;
					
					D_MAC <= D_MAC_nxt;
					S_MAC <= S_MAC_nxt;
					D_IP <= D_IP_nxt;
					S_IP <= S_IP_nxt;
					D_PORT <= D_PORT_nxt;
					S_PORT <= S_PORT_nxt;
					SEQ <= SEQ_nxt;
					ACK <= ACK_nxt;
					checksum_IP <= checksum_IP_nxt;
					checksum_TCP <= checksum_TCP_nxt;
					
            if (in_fifo_rd_en) begin
               fifo_out_ctrl_d1 <= fifo_out_ctrl;
               state_d1 <= state;
					fifo_out_data_d1 <= fifo_out_data;
					
					
					
               // Handle packet length/packet count registers
               if (fifo_out_ctrl == IO_QUEUE_STAGE_NUM && state != IN_PACKET) begin
                  if (enable_mapped & one_hot_src) begin
                     capture_pkt <= 1'b1;
                     pkt_cnt[src] <= pkt_cnt[src] + 'h1;

                     // Add 4 to the byte count for the FCS
                     pkt_len <= fifo_out_data[`IOQ_BYTE_LEN_POS+15:`IOQ_BYTE_LEN_POS] + 'h4;
                  end
               end
               else if (capture_pkt && fifo_out_ctrl_d1 == IO_QUEUE_STAGE_NUM && state_d1 != IN_PACKET) begin
                  byte_cnt[src_held] <= byte_cnt[src_held] + pkt_len;
               end

               if (capture_pkt && fifo_out_ctrl == TIMESTAMP_CTRL && state != IN_PACKET) begin
                  if (first_pkt[src_held]) begin
                     time_first[src_held] <= fifo_out_data;
                  end
                  time_last[src_held] <= fifo_out_data;
                  first_pkt[src_held] <= 1'b0;
               end
               else if (capture_pkt && fifo_out_ctrl_d1 == TIMESTAMP_CTRL && state_d1 != IN_PACKET) begin
                  time_last[src_held] <= time_last[src_held] + (pkt_len * 8);
               end
					////////////////////////modified////////////////////////////
					
					if(capture_pkt && fifo_out_ctrl == 8'h0)begin						
								in_pkt_64bit_count[src_held]<= in_pkt_64bit_count[src_held]+1;												
					end
					else if (capture_pkt && fifo_out_ctrl != 8'hff && fifo_out_ctrl != 8'hfe && fifo_out_ctrl != 8'hfd && fifo_out_ctrl != 8'h00)begin
								in_pkt_64bit_count[src_held]<=32'h0;
								
					end
					
					
					if (capture_pkt && in_pkt_64bit_count[src_held]==32'h3)begin
						if (fifo_out_ctrl_d1==8'h0)begin
							if(fifo_out_data_d1[7:0] == 8'h06)begin
								tcp_count[src_held]	<= tcp_count[src_held]+1;
								is_pkt_TCP <= 1'h1;
							end
							else if(fifo_out_data_d1[7:0] == 8'h11)begin
								udp_count[src_held]	<=	udp_count[src_held]+1;
							end
							else if(fifo_out_data_d1[7:0] == 8'h01)begin
								icmp_count[src_held]	<=	icmp_count[src_held]+1;
							end
						end
					end
					if (capture_pkt && in_pkt_64bit_count[src_held]==32'h6 && is_pkt_TCP == 1'h1)begin
						is_pkt_TCP <= 1'h0;
						if(fifo_out_data_d1[7:0] == 8'h12)begin //SYN-ACK
							SEQ <= {SEQ[31:16],fifo_out_data_d1[63:48]};
							ACK <= fifo_out_data_d1[47:16];
							is_SYN_ACK <=1'h1;
							SYN_ACK_count[src_held] <= SYN_ACK_count[src_held]+1;
							checksum_TCP <= checksum_TCP + fifo_out_data_d1[47:32]+ fifo_out_data_d1[32:16] + fifo_out_data_d1[63:48];// incorrect
						end
						else if(fifo_out_data_d1[7:0] == 8'h02)begin //SYN
							SEQ <= {SEQ[31:16],fifo_out_data_d1[63:48]};
							ACK <= fifo_out_data_d1[47:16];
							is_SYN_TCP <=1'h1;
							SYN_count[src_held] <= SYN_count[src_held]+1;
						end
						else if(fifo_out_data_d1[7:0] == 8'h10)begin //ACK
							is_ACK_TCP <=1'h1;
							ACK_count[src_held] <= ACK_count[src_held]+1;
						end
					end
					
					if (capture_pkt && in_pkt_64bit_count[src_held]==32'h1)begin
						if (fifo_out_ctrl_d1==8'h0)begin
							D_MAC <= fifo_out_data_d1[63:16];
							S_MAC <= {fifo_out_data_d1[15:0],32'h00000000};
							checksum_IP <= 24'h10536; // modified
							checksum_TCP <= 24'h023b3;
						end
					end
					
					if (capture_pkt && in_pkt_64bit_count[src_held]==32'h2)begin
						if (fifo_out_ctrl_d1==8'h0)begin
							S_MAC <= {S_MAC[47:32],fifo_out_data_d1[63:32]};
							checksum_IP <= checksum_IP + identify;
						end
					end
					
					if (capture_pkt && in_pkt_64bit_count[src_held]==32'h4)begin
						if (fifo_out_ctrl_d1==8'h0)begin
							S_IP <= fifo_out_data_d1[47:16];
							D_IP <= {fifo_out_data_d1[15:0],16'h000000};
							checksum_IP <= checksum_IP+fifo_out_data_d1[47:32]+fifo_out_data_d1[31:16]+fifo_out_data_d1[15:0];
							checksum_TCP <= checksum_TCP + fifo_out_data_d1[47:32]+fifo_out_data_d1[31:16]+fifo_out_data_d1[15:0];
						end
					end
					
					if (capture_pkt && in_pkt_64bit_count[src_held]==32'h5)begin
						if (fifo_out_ctrl_d1==8'h0)begin
							D_IP <= {D_IP[31:16],fifo_out_data_d1[63:48]};
							S_PORT <= fifo_out_data_d1[47:32];
							D_PORT <= fifo_out_data_d1[31:16];
							SEQ <= {fifo_out_data_d1[15:0],16'h0000000};
							checksum_IP <= checksum_IP+fifo_out_data_d1[63:48];
							checksum_TCP <= checksum_TCP + fifo_out_data_d1[63:48]+fifo_out_data_d1[47:32]+fifo_out_data_d1[31:16]+fifo_out_data_d1[15:0];
						end
					end
					//////////////////////////////////
            end
         end
      end
   end // always @ (*)

   always @(posedge clk)
   begin
      enable_d1 <= enable;
   end

   // Map the counters/timers arrays to the output signals
   assign pkt_cnt_0 = pkt_cnt[0];
   assign byte_cnt_0 = byte_cnt[0];
   assign time_first_0 = time_first[0];
   assign time_last_0 = time_last[0];

   assign pkt_cnt_1 = pkt_cnt[1];
   assign byte_cnt_1 = byte_cnt[1];
   assign time_first_1 = time_first[1];
   assign time_last_1 = time_last[1];

   assign tcp_count_0 = tcp_count[0];
	assign udp_count_0 = udp_count[0];
   assign icmp_count_0 = icmp_count[0];
	assign SYN_ACK_count_0 = SYN_ACK_count[0];
   assign SYN_count_0 = SYN_count[0];
	assign ACK_count_0 = ACK_count[0];

   assign tcp_count_1 = tcp_count[1];
	assign udp_count_1 = udp_count[1];
   assign icmp_count_1 = icmp_count[1];
	assign SYN_ACK_count_1 = SYN_ACK_count[1];
   assign SYN_count_1 = SYN_count[1];
	assign ACK_count_1 = ACK_count[1];

endmodule


`timescale 1ns/1ps
module port_mux_new
   #(
      parameter DATA_WIDTH = 64,
      parameter CTRL_WIDTH = DATA_WIDTH/8
   )
   (
      // --- data path interface
      output     [DATA_WIDTH-1:0]           out_data,
      output     [CTRL_WIDTH-1:0]           out_ctrl,
      output reg                            out_wr,
      input                                 out_rdy,

      input  [DATA_WIDTH-1:0]               in_data_0,
      input  [CTRL_WIDTH-1:0]               in_ctrl_0,
      input                                 in_wr_0,
      output                                in_rdy_0,

      input  [DATA_WIDTH-1:0]               in_data_1,
      input  [CTRL_WIDTH-1:0]               in_ctrl_1,
      input                                 in_wr_1,
      output                                in_rdy_1,
		
		input  [DATA_WIDTH-1:0]               in_data_2,
      input  [CTRL_WIDTH-1:0]               in_ctrl_2,
      input                                 in_wr_2,
      output                                in_rdy_2,

		input  [DATA_WIDTH-1:0]               in_data_3,
      input  [CTRL_WIDTH-1:0]               in_ctrl_3,
      input                                 in_wr_3,
      output                                in_rdy_3,

      // --- Register interface
      input                                 select,
		input 											in_reply_2,
		input                                  in_reply_3,
      // --- Misc
      input                                 clk,
      input                                 reset
   );

   function integer log2;
      input integer number;
      begin
         log2=0;
         while(2**log2<number) begin
            log2=log2+1;
         end
      end
   endfunction // log2

   //--------------------- Internal Parameter-------------------------
   localparam IDLE             = 0;
   localparam IN_MODULE_HDRS   = 1;
   localparam IN_PACKET        = 2;

   //---------------------- Wires/Regs -------------------------------
   reg   [1:0]             state, state_nxt;
   reg  [1:0]                     active, active_nxt;

   wire  [CTRL_WIDTH-1:0]  in_ctrl_active;
   wire                    in_wr_active;

   wire  [DATA_WIDTH-1:0]  in_data[3:0];
   wire  [CTRL_WIDTH-1:0]  in_ctrl[3:0];
   wire                    in_wr[3:0];
   reg                     in_rdy[3:0];
	
	
	wire	[1:0]						in_select;

   //----------------------- Modules ---------------------------------
   small_fifo #(.WIDTH(CTRL_WIDTH+DATA_WIDTH), .MAX_DEPTH_BITS(2), .PROG_FULL_THRESHOLD(3))
      input_fifo
        (.din           ({in_ctrl[active], in_data[active]}),  // Data in
         .wr_en         (in_wr[active]),             // Write enable
         .rd_en         (in_fifo_rd_en),    // Read the next word
         .dout          ({out_ctrl, out_data}),
         .full          (),
         .nearly_full   (in_fifo_nearly_full),
         .empty         (in_fifo_empty),
         .reset         (reset),
         .clk           (clk)
         );

   //----------------------- Logic ---------------------------------


   assign in_ctrl_active = in_ctrl[active];
   assign in_wr_active = in_wr[active];

   always @(*) begin

      state_nxt        = state;
      active_nxt       = active;

      if (active == 2'h0) begin
         in_rdy[0] = !in_fifo_nearly_full;
         in_rdy[1] = 1'b0;
			in_rdy[2] = 1'b0;
			in_rdy[3] = 1'b0;
      end
      else if (active == 2'h1)begin
         in_rdy[1] = !in_fifo_nearly_full;
         in_rdy[0] = 1'b0;
			in_rdy[2] = 1'b0;
			in_rdy[3] = 1'b0;
      end
		else if (active == 2'h2)begin
         in_rdy[2] = !in_fifo_nearly_full;
         in_rdy[0] = 1'b0;
			in_rdy[1] = 1'b0;
			in_rdy[3] = 1'b0;
      end
		else if (active == 2'h3)begin
         in_rdy[3] = !in_fifo_nearly_full;
         in_rdy[0] = 1'b0;
			in_rdy[1] = 1'b0;
			in_rdy[2] = 1'b0;
      end

      case(state)
         IDLE: begin
            // If the active input is writing then jump to the module headers
            // state (we need to process this packet)
            if (in_wr_active) begin
               state_nxt = IN_MODULE_HDRS;
            end

            // Otherwise if we're trying to switch inputs deaassert in_rdy and
            // record that we're switching
				else begin
					if(in_reply_2 && !in_reply_3 )begin
						if(active !=2'h2)begin
							in_rdy[active] = 1'b0;
							active_nxt = 2'h2;
						end
					end
					else if(in_reply_3 && !in_reply_2)begin
						if(active !=2'h3)begin
							in_rdy[active] = 1'b0;
							active_nxt = 2'h3;
						end
					end
					else if(in_reply_3 && in_reply_2)begin
						if(active !=2'h2)begin
							in_rdy[active] = 1'b0;
							active_nxt = 2'h2;
						end
					end
					else begin
						if (active != in_select)begin
							in_rdy[active] = 1'b0;
							active_nxt = in_select;
						end
					end
				end
               
         end

         IN_MODULE_HDRS: begin
            if(in_wr_active && in_ctrl_active==0) begin
               state_nxt = IN_PACKET;
            end
         end // case: IN_MODULE_HDRS

         IN_PACKET: begin
            if(in_wr_active && in_ctrl_active!=0) begin
               state_nxt = IDLE;

               // If we want to switch now is the time to do it
					if(in_reply_2 && !in_reply_3 )begin
						if(active !=2'h2)begin
							in_rdy[active] = 1'b0;
							active_nxt = 2'h2;
						end
					end
					else if(in_reply_3 && !in_reply_2)begin
						if(active !=2'h3)begin
							in_rdy[active] = 1'b0;
							active_nxt = 2'h3;
						end
					end
					else if(in_reply_3 && in_reply_2)begin
						if(active !=2'h2)begin
							in_rdy[active] = 1'b0;
							active_nxt = 2'h2;
						end
					end
					else begin
						if (active != in_select)begin
							in_rdy[active] = 1'b0;
							active_nxt = in_select;
						end
					end
				end
         end
      endcase // case(state)
   end // always @ (*)

   always @(posedge clk) begin
      if(reset) begin
         state <= IDLE;
         active <= 2'h0;
      end
      else begin
         state <= state_nxt;
         active <= active_nxt;
      end
   end

   /* handle outputs */
   assign in_fifo_rd_en = out_rdy && !in_fifo_empty;
   always @(posedge clk) begin
      out_wr <= reset ? 0 : in_fifo_rd_en;
   end

   // Convert input signals to arrays
   assign in_data[0] = in_data_0;
   assign in_ctrl[0] = in_ctrl_0;
   assign in_wr[0]   = in_wr_0;
   assign in_rdy_0   = in_rdy[0];

   assign in_data[1] = in_data_1;
   assign in_ctrl[1] = in_ctrl_1;
   assign in_wr[1]   = in_wr_1;
   assign in_rdy_1   = in_rdy[1];
	
	assign in_data[2] = in_data_2;
   assign in_ctrl[2] = in_ctrl_2;
   assign in_wr[2]   = in_wr_2;
   assign in_rdy_2   = in_rdy[2];
	
	assign in_data[3] = in_data_3;
   assign in_ctrl[3] = in_ctrl_3;
   assign in_wr[3]   = in_wr_3;
   assign in_rdy_3   = in_rdy[3];
	
	assign in_select = {1'h0,select};
endmodule

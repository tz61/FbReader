
`timescale 1 ns / 1 ps

module axi4_fbreader_to_hdmi_v1_0_M00_AXI #(
    // Users to add parameters here

    // User parameters ends
    // Do not modify the parameters beyond this line

    // Base address of targeted slave
    parameter FB0_ADDR = 32'h81000000,
    parameter FB1_ADDR = 32'h8112c000,
    parameter FB0_ALT_ADDR = 32'h81258000,
    parameter FB1_ALT_ADDR = 32'h81384000,
    parameter AUDIO_BASE_ADDR = 32'h814B0000,
    parameter AUDIO_FILE_SIZE = 32'h50bfe0,  // for one 5min song 5.0468 MiB max

    // Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
    parameter integer FB_BEATS_LEN = 64,
    parameter integer AUDIO_BEATS_LEN = 256,
    // Thread ID Width
    parameter integer C_M_AXI_ID_WIDTH = 1,
    // Width of Address Bus
    parameter integer C_M_AXI_ADDR_WIDTH = 32,
    // Width of Data Bus
    parameter integer C_M_AXI_DATA_WIDTH = 64
) (
    output logic left_out,
    output logic right_out,
    input logic [3:0] audio_type_in,
    input logic write_audio_type_en,  // generate a pulse on this signal's rising edge
    // Initiate AXI transactions
    input logic INIT_AXI_TXN,
    // Asserts when transaction is complete
    output logic MACHINE_BUSY,
    // Asserts when ERROR is detected
    output logic ERROR,
    // Global Clock Signal.
    input logic M_AXI_ACLK,
    // Global Reset Singal. This Signal is Active Low
    input logic M_AXI_ARESETN,
    // Master Interface Read Address.
    output logic [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
    // Read address. This signal indicates the initial
    // address of a read burst transaction.
    output logic [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
    // Burst length. The burst length gives the exact number of transfers in a burst
    output logic [7 : 0] M_AXI_ARLEN,
    // Burst size. This signal indicates the size of each transfer in the burst
    output logic [2 : 0] M_AXI_ARSIZE,
    // Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
    output logic [1 : 0] M_AXI_ARBURST,
    // Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
    output logic M_AXI_ARLOCK,
    // Memory type. This signal indicates how transactions
    // are required to progress through a system.
    output logic [3 : 0] M_AXI_ARCACHE,
    // Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
    output logic [2 : 0] M_AXI_ARPROT,
    // Quality of Service, QoS identifier sent for each read transaction
    output logic [3 : 0] M_AXI_ARQOS,
    // Write address valid. This signal indicates that
    // the channel is signaling valid read address and control information
    output logic M_AXI_ARVALID,
    // Read address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
    input logic M_AXI_ARREADY,
    // Master Read Data
    input logic [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
    // Read response. This signal indicates the status of the read transfer
    input logic [1 : 0] M_AXI_RRESP,
    // Read last. This signal indicates the last transfer in a read burst
    input logic M_AXI_RLAST,
    // Read valid. This signal indicates that the channel
    // is signaling the required read data.
    input logic M_AXI_RVALID,
    // Read ready. This signal indicates that the master can
    // accept the read data and response information.
    output logic M_AXI_RREADY,
    input logic [9:0] drawX,
    input logic v_blank,  // if blank then it is 1
    output logic [7:0] R,
    output logic [7:0] G,
    output logic [7:0] B
);
  logic [63:0] doutb_fb0, doutb_fb1;
  logic [8:0] bram_read_addr;
  logic [8:0] bram_write_addr;
  logic bram0_wea, bram1_wea;
  logic bram_enb;
  always_comb begin
    if (drawX[9:1] <= 9'h13F) begin
      bram_enb = 1'b1;
      bram_read_addr = drawX[9:1];
      if (doutb_fb1[7:0] == 1) begin  // draw 2D over 3D canvas
        if (drawX[0] == 0) begin
          R = doutb_fb1[31:24];
          G = doutb_fb1[23:16];
          B = doutb_fb1[15:8];
        end else begin
          R = doutb_fb1[63:56];
          G = doutb_fb1[55:48];
          B = doutb_fb1[47:40];
        end
      end else begin
        if (drawX[0] == 0) begin
          R = doutb_fb0[31:24];
          G = doutb_fb0[23:16];
          B = doutb_fb0[15:8];
        end else begin
          R = doutb_fb0[63:56];
          G = doutb_fb0[55:48];
          B = doutb_fb0[47:40];
        end
      end
    end else begin
      bram_enb = 1'b0;
      bram_read_addr = 9'h00;
      R = 8'h00;
      G = 8'h00;
      B = 8'h00;
    end
  end
  // BRAM for FB0 (3D Rendering)
  blk_mem_gen_0 bram0 (
      // Port A in
      .addra(bram_write_addr),
      .clka (M_AXI_ACLK),
      .dina (M_AXI_RDATA),
      .ena  (1'b1),
      .wea  (bram0_wea),
      //Port B out
      .addrb(bram_read_addr),
      .clkb (M_AXI_ACLK),
      .doutb(doutb_fb0),
      .enb  (bram_enb)
  );
  // BRAM for FB1 (2D Rendering)
  blk_mem_gen_0 bram1 (
      // Port A in
      .addra(bram_write_addr),
      .clka (M_AXI_ACLK),
      .dina (M_AXI_RDATA),
      .ena  (1'b1),
      .wea  (bram1_wea),
      //Port B out
      .addrb(bram_read_addr),
      .clkb (M_AXI_ACLK),
      .doutb(doutb_fb1),
      .enb  (bram_enb)
  );

  localparam integer FB_BURST_COUNT = 5;  // 5*(64*2)=640 pixels
  localparam integer AUDIO_BURST_COUNT = 1;  // 1*(256*1) 

  typedef enum logic [3:0] {
    IDLE = 4'h0,
    FB0_READ = 4'h1,
    FB1_READ = 4'h2,
    CLEAR_AUDIO_EVENT_FIFO = 4'h3,
    FILL_AUDIO_PREPARE = 4'h4,
    FILL_AUDIO_LAUNCH = 4'h5,
    FILL_AUDIO_PROCESS = 4'h6,
    FILL_AUDIO_WAIT = 4'h7
  } state_t;
  state_t mst_exec_state;

  // AXI4LITE signals
  //AXI4 internal temp signals
  logic [C_M_AXI_ADDR_WIDTH-1 : 0] axi_araddr;
  logic [C_M_AXI_ADDR_WIDTH-1 : 0] axi_addr_base;
  logic axi_arvalid;
  logic axi_rready;
  //write beat count in a burst
  //read beat count in a burst
  logic [8 : 0] read_index;
  logic [8:0] cur_beats_len;

  logic [2:0] read_burst_counter;
  logic [2:0] cur_burst_count;
  // hex(640*4*480)= 0x12c000, 21 bits
  logic [20:0] line_stride_addr_counter;
  logic [20:0] ch1_addr_stride, ch2_addr_stride, ch3_addr_stride, ch4_addr_stride;
  logic start_single_burst_read;
  logic burst_read_active;
  //Interface response error flags
  logic read_resp_error;
  logic rnext;
  logic init_txn_ff;
  logic init_txn_ff2;
  logic init_txn_pulse;
  logic init_burst_pulse;

  logic v_blank_ff;
  logic v_blank_ff2;
  logic v_blank_pulse;


  // Audio id max 16 songs
  logic [2:0] cur_fill_ch;  //0 is invalid, 1 for ch1, 2 for ch2, 3 for ch3, 4 for ch4
  logic [4:0] ch1_sound_id, ch2_sound_id, ch3_sound_id, ch4_sound_id;
  logic ch1_half_empty, ch2_half_empty, ch3_half_empty, ch4_half_empty;
  logic ch1_busy, ch2_busy, ch3_busy, ch4_busy;  // busy means an audio is not done yet
  // busy will be cleared if this channel's filling stride reaches the size of the audio file(5M)
  // or the audio sample is h'11451419 for too long.
  // (magic number in creating audio data marking the end of the audio)
  logic [4:0] ch1_end_counter, ch2_end_counter, ch3_end_counter, ch4_end_counter;
  localparam MAGIC_END_NUM = 32'h00110045;
  localparam MAGIC_END_DURATION = 16;  // enouph to detect the end of the audio
  logic ch1_empty, ch2_empty, ch3_empty, ch4_empty;  // only used to blank the audio
  logic [2:0] fill_audio_wait_counter;
  logic [2:0] clear_audio_event_fifo_counter;  // max 7
  logic [8:0] fill_audio_wait_axi_counter;
  logic ch1_wr_en, ch2_wr_en, ch3_wr_en, ch4_wr_en;
  logic ch1_rd_en, ch2_rd_en, ch3_rd_en, ch4_rd_en;
  logic ch1_audio_done, ch2_audio_done, ch3_audio_done, ch4_audio_done;
  logic [31 : 0] ch1_dout, ch2_dout, ch3_dout, ch4_dout;
  logic [15:0] left_mixer, right_mixer;
  logic clk_200mhz;
  logic [11:0] counter_44k1;  // max 4095
  logic write_audio_type_pulse, read_audio_type_pulse;
  logic [3:0] audio_type_out;
  logic write_audio_type_en_ff1;
  logic write_audio_type_en_ff2;
  logic audio_event_fifo_empty;
  assign write_audio_type_pulse = (~write_audio_type_en_ff2) && write_audio_type_en_ff1;
  always_ff @(posedge M_AXI_ACLK) begin
    if (~M_AXI_ARESETN) begin
      write_audio_type_en_ff1 <= 1'b0;
      write_audio_type_en_ff2 <= 1'b0;
    end else begin
      write_audio_type_en_ff1 <= write_audio_type_en;
      write_audio_type_en_ff2 <= write_audio_type_en_ff1;
    end
  end
  //Read Address (AR)
  assign M_AXI_ARID = 'b0;
  assign M_AXI_ARADDR = axi_araddr + axi_addr_base;
  //Burst LENgth is number of transaction beats, minus 1
  //Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
  assign M_AXI_ARSIZE = 'b011;  //011,8bytes per transfer
  //INCR burst type is usually used, except for keyhole bursts
  assign M_AXI_ARBURST = 2'b01;
  assign M_AXI_ARLOCK = 1'b0;
  //Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
  assign M_AXI_ARCACHE = 4'b0011;
  assign M_AXI_ARPROT = 3'h0;
  assign M_AXI_ARQOS = 4'h0;
  assign M_AXI_ARVALID = axi_arvalid;
  //Read and Read Response (R)
  assign M_AXI_RREADY = axi_rready;
  //Example design I/O
  assign init_txn_pulse = (!init_txn_ff2) && init_txn_ff;
  assign v_blank_pulse = (!v_blank_ff2) && v_blank_ff;

  //Generate a pulse to initiate AXI transaction.
  always_ff @(posedge M_AXI_ACLK) begin
    // Initiates AXI transaction delay    
    if (M_AXI_ARESETN == 0) begin
      init_txn_ff  <= 1'b0;
      init_txn_ff2 <= 1'b0;
    end else begin
      init_txn_ff  <= INIT_AXI_TXN;
      init_txn_ff2 <= init_txn_ff;
    end
  end
  // Generate a pulse to reset the line stride counter
  always_ff @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 0) begin
      v_blank_ff  <= 1'b0;
      v_blank_ff2 <= 1'b0;
    end else begin
      v_blank_ff  <= v_blank;
      v_blank_ff2 <= v_blank_ff;
    end
  end
  always_ff @(posedge M_AXI_ACLK) begin
    // if v_blank_pulse or reset, reset the line stride counter
    if (M_AXI_ARESETN == 0 || v_blank_pulse) begin
      line_stride_addr_counter <= 21'h0;
    end else begin
      if (M_AXI_RLAST && axi_rready && (read_burst_counter == (FB_BURST_COUNT - 1)) && (mst_exec_state == FB1_READ))
        line_stride_addr_counter <= line_stride_addr_counter + FB_BEATS_LEN*FB_BURST_COUNT*C_M_AXI_DATA_WIDTH/8;
      //640*4=2560,0xA00
    end
  end
  // TODO Channel mixing
  // store left channel in high 16 bits, right channel in low 16 bits
  assign left_mixer  = ch1_dout[31:16];
  assign right_mixer = ch1_dout[15:0];

  always_ff @(posedge M_AXI_ACLK) begin
    if (~M_AXI_ARESETN) begin
      counter_44k1 <= 0;
      ch1_end_counter <= 0;
      ch2_end_counter <= 0;
      ch3_end_counter <= 0;
      ch4_end_counter <= 0;
      ch1_audio_done <= 1'b0;
      ch2_audio_done <= 1'b0;
      ch3_audio_done <= 1'b0;
      ch4_audio_done <= 1'b0;
      ch1_rd_en <= 1'b0;
      ch2_rd_en <= 1'b0;
      ch3_rd_en <= 1'b0;
      ch4_rd_en <= 1'b0;
    end else begin
      if (~ch1_busy) begin
        ch1_audio_done <= 1'b0;
      end
      if (~ch2_busy) begin
        ch2_audio_done <= 1'b0;
      end
      if (~ch3_busy) begin
        ch3_audio_done <= 1'b0;
      end
      if (~ch4_busy) begin
        ch4_audio_done <= 1'b0;
      end
      if (counter_44k1 == (1134 * 2 - 1)) begin  // 100e3/1134/2 = 44.0917kHz
        counter_44k1 <= 0;
        ch1_rd_en <= 1'b1;
        ch2_rd_en <= 1'b1;
        ch3_rd_en <= 1'b1;
        ch4_rd_en <= 1'b1;
        if (ch1_dout == MAGIC_END_NUM) begin
          ch1_end_counter <= ch1_end_counter + 1;
          if (ch1_end_counter == MAGIC_END_DURATION - 1) begin
            ch1_audio_done <= 1'b1;
          end
        end else begin
          ch1_end_counter <= 0;  // break if MAGIC_END_NUM is not continuous
        end
        if (ch2_dout == MAGIC_END_NUM) begin
          ch2_end_counter <= ch2_end_counter + 1;
          if (ch2_end_counter == MAGIC_END_DURATION - 1) begin
            ch2_audio_done  <= 1'b1;
            ch2_end_counter <= 0;
          end
        end else begin
          ch2_end_counter <= 0;
        end
        if (ch3_dout == MAGIC_END_NUM) begin
          ch3_end_counter <= ch3_end_counter + 1;
          if (ch3_end_counter == MAGIC_END_DURATION - 1) begin
            ch3_audio_done  <= 1'b1;
            ch3_end_counter <= 0;
          end
        end else begin
          ch3_end_counter <= 0;
        end
        if (ch4_dout == MAGIC_END_NUM) begin
          ch4_end_counter <= ch4_end_counter + 1;
          if (ch4_end_counter == MAGIC_END_DURATION - 1) begin
            ch4_audio_done  <= 1'b1;
            ch4_end_counter <= 0;
          end
        end else begin
          ch4_end_counter <= 0;
        end
      end else begin
        counter_44k1 <= counter_44k1 + 1;
      end
      // only generate a pulse
      if (ch1_rd_en) begin
        ch1_rd_en <= 1'b0;
      end
      if (ch2_rd_en) begin
        ch2_rd_en <= 1'b0;
      end
      if (ch3_rd_en) begin
        ch3_rd_en <= 1'b0;
      end
      if (ch4_rd_en) begin
        ch4_rd_en <= 1'b0;
      end
    end
  end
  clk_gen_audio clk_gen_audio_inst (
      .reset(~M_AXI_ARESETN),
      .clk_in1(M_AXI_ACLK),  // assume it is 100mhz
      .clk_200mhz(clk_200mhz)
  );
  pwm_gen pwm_left (
      .clk_200mhz(clk_200mhz),
      .rst(~M_AXI_ARESETN),
      .din(left_mixer[15:4]),  // not a better way
      .dout(left_out)
  );
  pwm_gen pwm_right (
      .clk_200mhz(clk_200mhz),
      .rst(~M_AXI_ARESETN),
      .din(right_mixer[15:4]),
      .dout(right_out)
  );
  channel_fifo ch1_audio_fifo (
      .clk (M_AXI_ACLK),
      .srst(~M_AXI_ARESETN),

      .din(M_AXI_RDATA),
      .wr_en(ch1_wr_en),
      .dout(ch1_dout),
      .rd_en(ch1_rd_en),
      .prog_empty(ch1_half_empty),
      .empty(ch1_empty)
  );
  channel_fifo ch2_audio_fifo (
      .clk (M_AXI_ACLK),
      .srst(~M_AXI_ARESETN),

      .din(M_AXI_RDATA),
      .wr_en(ch2_wr_en),
      .dout(ch2_dout),
      .rd_en(ch2_rd_en),
      .prog_empty(ch2_half_empty),
      .empty(ch2_empty)
  );
  channel_fifo ch3_audio_fifo (
      .clk (M_AXI_ACLK),
      .srst(~M_AXI_ARESETN),

      .din(M_AXI_RDATA),
      .wr_en(ch3_wr_en),
      .dout(ch3_dout),
      .rd_en(ch3_rd_en),
      .prog_empty(ch3_half_empty),
      .empty(ch3_empty)
  );
  channel_fifo ch4_audio_fifo (
      .clk (M_AXI_ACLK),
      .srst(~M_AXI_ARESETN),

      .din(M_AXI_RDATA),
      .wr_en(ch4_wr_en),
      .dout(ch4_dout),
      .rd_en(ch4_rd_en),
      .prog_empty(ch4_half_empty),
      .empty(ch4_empty)
  );
  //
  event_fifo audio_event_fifo (
      .din  (audio_type_in),
      .wr_en(write_audio_type_pulse),
      .dout (audio_type_out),
      .rd_en(read_audio_type_pulse),
      .empty(audio_event_fifo_empty),
      .clk  (M_AXI_ACLK),
      .srst (~M_AXI_ARESETN)
  );
  always_ff @(posedge M_AXI_ACLK) begin
    // if v_blank_pulse or reset, reset the line stride counter
    if (M_AXI_ARESETN == 0) begin
      ch1_addr_stride <= 21'h0;
      ch2_addr_stride <= 21'h0;
      ch3_addr_stride <= 21'h0;
      ch4_addr_stride <= 21'h0;
    end else begin
      if (~ch1_busy) begin
        ch1_addr_stride <= 21'h0;
      end
      if (~ch2_busy) begin
        ch2_addr_stride <= 21'h0;
      end
      if (~ch3_busy) begin
        ch3_addr_stride <= 21'h0;
      end
      if (~ch4_busy) begin
        ch4_addr_stride <= 21'h0;
      end
      if (M_AXI_RLAST && axi_rready && (read_burst_counter == (FB_BURST_COUNT - 1)) && (mst_exec_state == FILL_AUDIO_PROCESS)) begin
        if (cur_fill_ch == 1) begin
          ch1_addr_stride <= ch1_addr_stride + AUDIO_BEATS_LEN*AUDIO_BURST_COUNT*C_M_AXI_DATA_WIDTH/8; // 256*1*8=2048Bytes
        end else if (cur_fill_ch == 2) begin
          ch2_addr_stride <= ch2_addr_stride + AUDIO_BEATS_LEN*AUDIO_BURST_COUNT*C_M_AXI_DATA_WIDTH/8; // 256*1*8=2048Bytes
        end else if (cur_fill_ch == 3) begin
          ch3_addr_stride <= ch3_addr_stride + AUDIO_BEATS_LEN*AUDIO_BURST_COUNT*C_M_AXI_DATA_WIDTH/8; // 256*1*8=2048Bytes
        end else if (cur_fill_ch == 4) begin
          ch4_addr_stride <= ch4_addr_stride + AUDIO_BEATS_LEN*AUDIO_BURST_COUNT*C_M_AXI_DATA_WIDTH/8; // 256*1*8=2048Bytes
        end
      end
    end
  end
  //----------------------------
  //Read Address Channel
  //----------------------------
  always_ff @(posedge M_AXI_ACLK) begin

    if (M_AXI_ARESETN == 0 || init_burst_pulse == 1'b1) begin
      axi_arvalid <= 1'b0;
    end  // If previously not valid , start next transaction              
    else if (~axi_arvalid && start_single_burst_read) begin
      axi_arvalid <= 1'b1;
    end else if (M_AXI_ARREADY && axi_arvalid) begin
      axi_arvalid <= 1'b0;
    end else axi_arvalid <= axi_arvalid;
  end


  // Next address after ARREADY indicates previous address acceptance  
  always_ff @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 0 || init_burst_pulse == 1'b1) begin
      if (mst_exec_state == FB0_READ || mst_exec_state == FB1_READ) begin
        axi_araddr <= line_stride_addr_counter;
      end else begin
        if (cur_fill_ch == 1) axi_araddr <= ch1_addr_stride;
        else if (cur_fill_ch == 2) axi_araddr <= ch2_addr_stride;
        else if (cur_fill_ch == 3) axi_araddr <= ch3_addr_stride;
        else if (cur_fill_ch == 4) axi_araddr <= ch4_addr_stride;
      end
    end else if (M_AXI_ARREADY && axi_arvalid) begin
      //Burst size in bytes One beat, 64*8=512 Byte, 128 pixels, 5 beat=640 pixels
      axi_araddr <= axi_araddr + cur_beats_len * C_M_AXI_DATA_WIDTH / 8;
    end else axi_araddr <= axi_araddr;
  end

  //--------------------------------
  //Read Data (and Response) Channel
  //--------------------------------
  assign rnext = M_AXI_RVALID && axi_rready;
  // Burst length counter. Uses extra counter register bit to indicate    
  // terminal count to reduce decode logic                                
  always_ff @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 0 || init_burst_pulse == 1'b1 || start_single_burst_read) begin
      read_index <= 0;
    end else if (rnext && (read_index != cur_beats_len - 1)) begin
      read_index <= read_index + 1;
    end else read_index <= read_index;
  end

  assign bram_write_addr = (read_burst_counter << 6) | read_index;
  // 320 max, 64+ 64*read_burst_counter

  /*                                                                      
	 The Read Data channel returns the results of the read request          
	                                                                        
	 In this example the data checker is always able to accept              
	 more data, so no need to throttle the RREADY signal                    
	 */
  always_ff @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 0 || init_burst_pulse == 1'b1) begin
      axi_rready <= 1'b0;
    end  // accept/acknowledge rdata/rresp with axi_rready by the master     
         // when M_AXI_RVALID is asserted by slave                           
    else if (M_AXI_RVALID) begin
      if (M_AXI_RLAST && axi_rready) begin
        axi_rready <= 1'b0;
      end else begin
        axi_rready <= 1'b1;
      end
    end
    // retain the previous value                 
  end

  //Flag any read response errors                                         
  assign read_resp_error = axi_rready & M_AXI_RVALID & M_AXI_RRESP[1];
  //----------------------------------
  //Example design error register
  //----------------------------------

  //Register and hold any data mismatches, or read/write interface errors 

  always_ff @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 0 || init_burst_pulse == 1'b1) begin
      ERROR <= 1'b0;
    end else begin
      if (read_resp_error) ERROR <= 1'b1;
      else ERROR <= ERROR;
    end
  end

  // data flow control
  always_comb begin
    ch1_wr_en = 1'b0;
    ch2_wr_en = 1'b0;
    ch3_wr_en = 1'b0;
    ch4_wr_en = 1'b0;
    bram0_wea = 1'b0;
    bram1_wea = 1'b0;
    if (mst_exec_state == FB0_READ) begin
      bram0_wea = rnext;
    end else if (mst_exec_state == FB1_READ) begin
      bram1_wea = rnext;
    end else if (mst_exec_state == FILL_AUDIO_PROCESS) begin
      if (cur_fill_ch == 1) ch1_wr_en = rnext;
      else if (cur_fill_ch == 2) ch2_wr_en = rnext;
      else if (cur_fill_ch == 3) ch3_wr_en = rnext;
      else if (cur_fill_ch == 4) ch4_wr_en = rnext;
    end
  end
  // read_burst_counter counter keeps track with the number of burst transaction initiated                   
  // against the number of burst transactions the master needs to initiate                                   
  always_ff @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 0) begin
      read_burst_counter <= 'b0;
      // end else if (M_AXI_ARREADY && axi_arvalid) begin, to prevent generating erroneous bram addr(eg from 0x0 to 0x40)
    end else if (M_AXI_RLAST && axi_rready) begin
      if (read_burst_counter != cur_burst_count) begin
        read_burst_counter <= read_burst_counter + 1'b1;
      end
    end else if (read_burst_counter == cur_burst_count) begin
      read_burst_counter <= 0;
    end else begin
      read_burst_counter <= read_burst_counter;
    end
  end

  //implement master command interface state machine                                                        

  always_ff @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 1'b0) begin
      // reset condition                                                                                  
      // All the signals are assigned default values under reset condition                                
      mst_exec_state                 <= IDLE;
      start_single_burst_read        <= 1'b0;
      MACHINE_BUSY                   <= 1'b0;
      axi_addr_base                  <= FB0_ADDR;
      init_burst_pulse               <= 1'b0;
      M_AXI_ARLEN                    <= FB_BEATS_LEN - 1;
      cur_beats_len                  <= FB_BEATS_LEN;
      cur_burst_count                <= FB_BURST_COUNT;
      cur_fill_ch                    <= 0;  // Invalid
      fill_audio_wait_counter        <= 0;
      fill_audio_wait_axi_counter    <= 0;
      clear_audio_event_fifo_counter <= 0;
      read_audio_type_pulse          <= 1'b0;
      ch1_busy                       <= 1'b0;
      ch2_busy                       <= 1'b0;
      ch3_busy                       <= 1'b0;
      ch4_busy                       <= 1'b0;
      ch1_sound_id                   <= 16;  // for test
      ch2_sound_id                   <= 16;
      ch3_sound_id                   <= 16;
      ch4_sound_id                   <= 16;
    end else begin
      // state transition                                                                                 
      case (mst_exec_state)
        IDLE:
        // This state is responsible to wait for user defined C_M_START_COUNT                           
        // number of clock cycles.                                                                      
        if (init_txn_pulse == 1'b1) begin
          mst_exec_state   <= FB0_READ;
          axi_addr_base    <= FB0_ADDR;
          M_AXI_ARLEN      <= FB_BEATS_LEN - 1;
          cur_beats_len    <= FB_BEATS_LEN;
          cur_burst_count  <= FB_BURST_COUNT;
          init_burst_pulse <= 1'b1;
          MACHINE_BUSY     <= 1'b1;
        end else begin
          MACHINE_BUSY   <= 1'b0;
          mst_exec_state <= IDLE;
        end
        FB0_READ:  // state 'h01
        // This state is responsible to issue start_single_read pulse to                                
        // initiate a read transaction. Read transactions will be                                       
        // issued until burst_read_active signal is asserted.                                           
        // read controller 
        // tz61: Adding a additional reg for reg_done signal delays the IDLE transition by 
        // 1 cycle and initiates a new read transaction. 
        // And also only need to check counter, since ready and valid are deasserted in next cycle
        // so need to wait another 1 cycle
        if (read_burst_counter == cur_burst_count) begin
          // do FB1 read
          mst_exec_state <= FB1_READ;
          axi_addr_base <= FB1_ADDR;
          init_burst_pulse <= 1'b1;  // at start of each bunch of burst for FB1 Read
        end else begin
          init_burst_pulse <= 1'b0;  // disable pulse
          if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read) begin
            start_single_burst_read <= 1'b1;
          end else begin
            start_single_burst_read <= 1'b0; //Negate to generate a pulse                            
          end
        end
        FB1_READ:  // state 'h02
        if (read_burst_counter == cur_burst_count) begin
          // on default just skip clear event fifo state
          mst_exec_state <= FILL_AUDIO_PREPARE;
          read_audio_type_pulse <= 1'b0;
          if (~audio_event_fifo_empty) begin
            if ((~ch1_busy) || (~ch2_busy) || (~ch3_busy) || (~ch4_busy)) begin
              // don't miss a fifo read if all channels are busy
              // only goto it when fifo is not empty and any channel is not busy
              read_audio_type_pulse <= 1'b1;
              mst_exec_state <= CLEAR_AUDIO_EVENT_FIFO;
              clear_audio_event_fifo_counter <= 0;
            end
          end
        end else begin
          init_burst_pulse <= 1'b0;  // disable pulse
          if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read) begin
            start_single_burst_read <= 1'b1;
          end else begin
            start_single_burst_read <= 1'b0; //Negate to generate a pulse                            
          end
        end
        CLEAR_AUDIO_EVENT_FIFO: begin  // draw in at max 4 times
          clear_audio_event_fifo_counter <= clear_audio_event_fifo_counter + 1;
          if (clear_audio_event_fifo_counter == 4 || audio_event_fifo_empty) begin
            mst_exec_state <= FILL_AUDIO_PREPARE;
            read_audio_type_pulse <= 1'b0;
          end else begin
            if (~ch1_busy) begin
              ch1_sound_id <= audio_type_out;
              ch1_busy <= 1'b1;
            end else if (~ch2_busy) begin
              ch2_sound_id <= audio_type_out;
              ch2_busy <= 1'b1;
            end else if (~ch3_busy) begin
              ch3_sound_id <= audio_type_out;
              ch3_busy <= 1'b1;
            end else if (~ch4_busy) begin
              ch4_sound_id <= audio_type_out;
              ch4_busy <= 1'b1;
            end
          end
        end
        FILL_AUDIO_PREPARE: begin
          mst_exec_state <= FILL_AUDIO_LAUNCH;
          M_AXI_ARLEN    <= AUDIO_BEATS_LEN - 1;
          cur_beats_len    <= AUDIO_BEATS_LEN;
          cur_burst_count  <= AUDIO_BURST_COUNT;
        end
        // Max 5min, 5*60=300s
        // 300(second)*44100*2(channel)*2(16bit depth) = 52920000(B)(hex 'h50bfe0)
        // 5.0468 MiB max
        FILL_AUDIO_LAUNCH: begin  // state 'h03 , four bullet to load audio data
          // if any of four channel is half empty
          // axi_araddr set by channel stride
          fill_audio_wait_counter <= fill_audio_wait_counter + 1;
          if (fill_audio_wait_counter == 4) begin
            mst_exec_state          <= IDLE;
            fill_audio_wait_counter <= 0;
            cur_fill_ch             <= 0;
            fill_audio_wait_counter <= 0;
          end else begin
            mst_exec_state   <= FILL_AUDIO_PROCESS;
            init_burst_pulse <= 1'b1;  // at start of each bunch of burst for FB1 Read
            if (ch1_half_empty && ch1_busy) begin
              axi_addr_base <= AUDIO_BASE_ADDR + ch1_sound_id * AUDIO_FILE_SIZE;
              cur_fill_ch   <= 1;
            end else if (ch2_half_empty && ch2_busy) begin
              axi_addr_base <= AUDIO_BASE_ADDR + ch2_sound_id * AUDIO_FILE_SIZE;
              cur_fill_ch   <= 2;
            end else if (ch3_half_empty && ch3_busy) begin
              axi_addr_base <= AUDIO_BASE_ADDR + ch3_sound_id * AUDIO_FILE_SIZE;
              cur_fill_ch   <= 3;
            end else if (ch4_half_empty && ch4_busy) begin
              axi_addr_base <= AUDIO_BASE_ADDR + ch4_sound_id * AUDIO_FILE_SIZE;
              cur_fill_ch   <= 4;
            end else begin
              mst_exec_state <= FILL_AUDIO_WAIT;
              fill_audio_wait_axi_counter <= 0;
              cur_fill_ch <= 0;  // invalid
              init_burst_pulse <= 1'b0;  // disable burst pulse
            end
          end
        end
        FILL_AUDIO_PROCESS: begin
          if (read_burst_counter == cur_burst_count) begin
            // a single channel's filling is done
            // check whether a channel is still busy
            if (ch1_addr_stride == AUDIO_FILE_SIZE || ch1_audio_done) begin
              ch1_busy <= 0;
            end else if (ch2_addr_stride == AUDIO_FILE_SIZE || ch2_audio_done) begin
              ch2_busy <= 0;
            end else if (ch3_addr_stride == AUDIO_FILE_SIZE || ch3_audio_done) begin
              ch3_busy <= 0;
            end else if (ch4_addr_stride == AUDIO_FILE_SIZE || ch4_audio_done) begin
              ch4_busy <= 0;
            end
            mst_exec_state <= FILL_AUDIO_LAUNCH;  // return to FILL_AUDIO_LAUNCH
          end else begin
            init_burst_pulse <= 1'b0;  // disable pulse
            if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read) begin
              start_single_burst_read <= 1'b1;
            end else begin
              start_single_burst_read <= 1'b0; //Negate to generate a pulse                            
            end
          end
        end
        FILL_AUDIO_WAIT: begin
          // TODO wait some axi clks then return to FILL_AUDIO_LAUNCH
          if (fill_audio_wait_axi_counter == (256 + 20)) begin
            mst_exec_state <= FILL_AUDIO_LAUNCH;
          end else begin
            fill_audio_wait_axi_counter <= fill_audio_wait_axi_counter + 1;
          end
        end
      endcase
    end
  end  //MASTER_EXECUTION_PROC                                                                               





  always_ff @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 0 || init_burst_pulse == 1'b1) burst_read_active <= 1'b0;

    //The burst_write_active is asserted when a write burst transaction is initiated                        
    else if (start_single_burst_read) burst_read_active <= 1'b1;
    else if (M_AXI_RVALID && axi_rready && M_AXI_RLAST) burst_read_active <= 0;
  end



  // Add user logic here

  // User logic ends

endmodule

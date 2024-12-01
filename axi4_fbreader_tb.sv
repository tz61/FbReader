`timescale 1ns / 100ps
module axi4_fbreader_tb ();
  localparam FB0_ADDR = 32'h81000000;
  localparam FB1_ADDR = 32'h8112c000;
  localparam FB0_ALT_ADDR = 32'h81258000;
  localparam FB1_ALT_ADDR = 32'h81384000;
  // to 814aFFFF(814B 0000 -1)
  localparam integer C_M00_AXI_BURST_LEN = 64;
  localparam integer C_M00_AXI_ID_WIDTH = 1;
  localparam integer C_M00_AXI_ADDR_WIDTH = 32;
  localparam integer C_M00_AXI_DATA_WIDTH = 64;

  localparam AUDIO_BASE_ADDR = 32'h814B0000;
  localparam AUDIO_FILE_SIZE = 32'h50bfe0;
  logic hdmi_clk_n;
  logic hdmi_clk_p;
  logic [2:0] hdmi_tx_n;
  logic [2:0] hdmi_tx_p;
  logic fb_use_alt;
  logic clk_25m;  //25m exactly for xc7s50-2csga324
  logic left_out;
  logic right_out;
  logic [4:0] audio_type_in;
  logic write_audio_type_en;

  // Ports of Axi Master Bus Interface M00_AXI
  logic m00_axi_machine_busy;
  logic m00_axi_error;
  logic m00_axi_aclk;
  logic m00_axi_aresetn;
  logic [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid;
  logic [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr;
  logic [7 : 0] m00_axi_arlen;
  logic [2 : 0] m00_axi_arsize;
  logic [1 : 0] m00_axi_arburst;
  logic m00_axi_arlock;
  logic [3 : 0] m00_axi_arcache;
  logic [2 : 0] m00_axi_arprot;
  logic [3 : 0] m00_axi_arqos;
  logic m00_axi_arvalid;
  logic m00_axi_arready;
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata;
  logic [1 : 0] m00_axi_rresp;
  logic m00_axi_rlast;
  logic m00_axi_rvalid;
  logic m00_axi_rready;
  initial begin : CLOCK_INITIALIZATION
    m00_axi_aclk = 1'b0;
    clk_25m = 1'b0;
  end

  always begin : CLOCK_GENERATION
    #1 m00_axi_aclk = ~m00_axi_aclk;
  end
  always begin : CLOCK_GENERATION_25M
    #4 clk_25m <= ~clk_25m;
  end
  axi4_fbreader_to_hdmi_v1_0 inst (.*);
  // binding
  logic init_read_line;
  assign init_read_line = inst.init_read_line;
  logic [9:0] hc, vc;
  assign hc = inst.vgac.hc;
  assign vc = inst.vgac.vc;
  logic [7:0] red, green, blue;
  assign red   = inst.red;
  assign green = inst.green;
  assign blue  = inst.blue;
  logic [63:0] doutb_fb0, doutb_fb1;
  logic [8:0] bram_read_addr;
  logic [8:0] bram_write_addr;
  assign doutb_fb0 = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.doutb_fb0;
  assign doutb_fb1 = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.doutb_fb1;
  assign bram_read_addr = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.bram_read_addr;
  assign bram_write_addr = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.bram_write_addr;
  logic start_single_burst_read;
  assign start_single_burst_read = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.start_single_burst_read;
  logic [3:0] host_state;
  assign host_state = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.mst_exec_state;
  logic [2:0] read_burst_counter;
  assign read_burst_counter = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.read_burst_counter;
  // audio
  logic [20:0] ch1_addr_stride, ch2_addr_stride, ch3_addr_stride, ch4_addr_stride;
  logic [2:0] cur_fill_ch;
  logic [4:0] ch1_sound_id, ch2_sound_id, ch3_sound_id, ch4_sound_id;
  logic ch1_half_empty, ch2_half_empty, ch3_half_empty, ch4_half_empty;
  logic ch1_busy, ch2_busy, ch3_busy, ch4_busy;
  logic [4:0] ch1_end_counter, ch2_end_counter, ch3_end_counter, ch4_end_counter;
  logic ch1_empty, ch2_empty, ch3_empty, ch4_empty;
  logic [2:0] fill_audio_wait_counter;
  logic [2:0] clear_audio_event_fifo_counter;  // max 7
  logic [8:0] fill_audio_wait_axi_counter;
  logic ch1_wr_en, ch2_wr_en, ch3_wr_en, ch4_wr_en;
  logic ch1_rd_en, ch2_rd_en, ch3_rd_en, ch4_rd_en;
  logic ch1_audio_done, ch2_audio_done, ch3_audio_done, ch4_audio_done;
  logic [31 : 0] ch1_dout, ch2_dout, ch3_dout, ch4_dout;
  logic [15:0] left_mixer, right_mixer;
  logic [11:0] counter_44k1;  // max 4095
  logic write_audio_type_pulse, read_audio_type_pulse;
  logic [4:0] audio_type_out;
  logic write_audio_type_en_ff1;
  logic write_audio_type_en_ff2;
  logic audio_event_fifo_empty, audio_event_fifo_almost_empty;
  assign ch1_addr_stride = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch1_addr_stride;
  assign ch2_addr_stride = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch2_addr_stride;
  assign ch3_addr_stride = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch3_addr_stride;
  assign ch4_addr_stride = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch4_addr_stride;
  assign cur_fill_ch = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.cur_fill_ch;
  assign ch1_sound_id = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch1_sound_id;
  assign ch2_sound_id = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch2_sound_id;
  assign ch3_sound_id = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch3_sound_id;
  assign ch4_sound_id = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch4_sound_id;
  assign ch1_half_empty = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch1_half_empty;
  assign ch2_half_empty = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch2_half_empty;
  assign ch3_half_empty = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch3_half_empty;
  assign ch4_half_empty = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch4_half_empty;
  assign ch1_busy = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch1_busy;
  assign ch2_busy = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch2_busy;
  assign ch3_busy = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch3_busy;
  assign ch4_busy = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch4_busy;
  assign ch1_end_counter = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch1_end_counter;
  assign ch2_end_counter = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch2_end_counter;
  assign ch3_end_counter = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch3_end_counter;
  assign ch4_end_counter = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch4_end_counter;
  assign ch1_empty = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch1_empty;
  assign ch2_empty = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch2_empty;
  assign ch3_empty = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch3_empty;
  assign ch4_empty = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch4_empty;
  assign fill_audio_wait_counter = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.fill_audio_wait_counter;
  assign clear_audio_event_fifo_counter = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.clear_audio_event_fifo_counter;
  assign fill_audio_wait_axi_counter = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.fill_audio_wait_axi_counter;
  assign ch1_wr_en = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch1_wr_en;
  assign ch2_wr_en = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch2_wr_en;
  assign ch3_wr_en = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch3_wr_en;
  assign ch4_wr_en = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch4_wr_en;
  assign ch1_rd_en = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch1_rd_en;
  assign ch2_rd_en = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch2_rd_en;
  assign ch3_rd_en = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch3_rd_en;
  assign ch4_rd_en = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch4_rd_en;
  assign ch1_audio_done = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch1_audio_done;
  assign ch2_audio_done = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch2_audio_done;
  assign ch3_audio_done = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch3_audio_done;
  assign ch4_audio_done = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch4_audio_done;
  assign ch1_dout = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch1_dout;
  assign ch2_dout = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch2_dout;
  assign ch3_dout = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch3_dout;
  assign ch4_dout = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.ch4_dout;
  assign left_mixer = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.left_mixer;
  assign right_mixer = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.right_mixer;
  assign counter_44k1 = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.counter_44k1;
  assign write_audio_type_pulse = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.write_audio_type_pulse;
  assign read_audio_type_pulse = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.read_audio_type_pulse;
  assign audio_type_out = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.audio_type_out;
  assign write_audio_type_en_ff1 = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.write_audio_type_en_ff1;
  assign write_audio_type_en_ff2 = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.write_audio_type_en_ff2;
  assign audio_event_fifo_empty = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.audio_event_fifo_empty;
  assign audio_event_fifo_almost_empty = inst.axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst.audio_event_fifo_almost_empty;
  // END of binding  



  // testbench buffer
  logic [2:0] write_type;
  // 0, fb0; 1, fb1; 2, fb0_alt; 3, fb1_alt, 4, audio0, 5, audio1, 6, audio2, 7, audio3
  logic [7:0] slave_burst_counter;
  logic [C_M00_AXI_ADDR_WIDTH-1 : 0] slave_addr;
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] slave_data_fb0[(640/2)*480];// 64bit for 2 pixel, 640x480
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] slave_data_fb1[(640/2)*480];
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] slave_data_fb0_alt[(640/2)*480];
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] slave_data_fb1_alt[(640/2)*480];
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] slave_data_audio0[AUDIO_FILE_SIZE];
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] slave_data_audio1[AUDIO_FILE_SIZE];
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] slave_data_audio2[AUDIO_FILE_SIZE];
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] slave_data_audio3[AUDIO_FILE_SIZE];
  task clear_slave_data();
    // init axi data line
    m00_axi_rlast = 1'b0;
    m00_axi_rdata = 'h1145141919810893;
    m00_axi_arready = 1'b0;
    m00_axi_rresp = 2'b0;
    m00_axi_rvalid = 1'b0;
    slave_addr = 0;
    // init slave side data
    slave_burst_counter = 0;
    write_type = 0;
    begin
      integer i;
      for (i = 0; i < (640 / 2) * 480; i = i + 1) begin
        // blue channel: current col(capped to 8 bits)
        // row number lies between red and green channel
        slave_data_fb0[i] = ((((i % 320)*2) | ((i / 320) << 12))<<8)+((((i % 320)*2+1) | ((i / 320) << 12))<<(32+8));
        slave_data_fb1[i] = ((((i % 320)*2) | ((i / 320) << 12))<<8)+((((i % 320)*2+1) | ((i / 320) << 12))<<(32+8));
        // switch row and col in fb alt test data
        slave_data_fb0_alt[i] = (((((i % 320)*2)<< 12) | (i / 320))<<8)+(((((i % 320)*2+1) << 12) | (i / 320))<<(32+8));
        slave_data_fb1_alt[i] = (((((i % 320)*2)<< 12) | (i / 320))<<8)+(((((i % 320)*2+1) << 12) | (i / 320))<<(32+8));
      end
      for (i = 0; i < 12; i = i + 1) begin
        slave_data_audio0[i] = 64'h0101010101010101;
        slave_data_audio1[i] = 64'h0202020202020202;
        slave_data_audio2[i] = 64'h0303030303030303;
        slave_data_audio3[i] = 64'h0404040404040404;
      end
      for (i = 12 + 8; i < AUDIO_FILE_SIZE; i = i + 1) begin
        slave_data_audio0[i] = i;
        slave_data_audio1[i] = i;
        slave_data_audio2[i] = i;
        slave_data_audio3[i] = i;
      end
      // write end of file
      for (i = 12; i < 12 + 8; i = i + 1) begin
        slave_data_audio0[i] = 64'h0011004500110045;
        slave_data_audio1[i] = 64'h0011004500110045;
        slave_data_audio2[i] = 64'h0011004500110045;
        slave_data_audio3[i] = 64'h0011004500110045;
      end
    end
  endtask
  // used only for FB, and for Audio data
  task axi_slave_provide_read_burst();
    begin
      wait (m00_axi_arvalid);
      @(posedge m00_axi_aclk);
      m00_axi_arready <= 1'b1;
      slave_burst_counter <= 0;
      if (m00_axi_araddr < FB1_ADDR) begin
        write_type <= 0;
        slave_addr <= (m00_axi_araddr - FB0_ADDR) / 8;  // byte addr to 8byte addr
      end else if (m00_axi_araddr < FB0_ALT_ADDR) begin
        write_type <= 1;
        slave_addr <= (m00_axi_araddr - FB1_ADDR) / 8;
      end else if (m00_axi_araddr < FB1_ALT_ADDR) begin
        write_type <= 2;
        slave_addr <= (m00_axi_araddr - FB0_ALT_ADDR) / 8;
      end else if (m00_axi_araddr < AUDIO_BASE_ADDR) begin
        write_type <= 3;
        slave_addr <= (m00_axi_araddr - FB1_ALT_ADDR) / 8;
      end else if (m00_axi_araddr < AUDIO_BASE_ADDR + AUDIO_FILE_SIZE) begin
        write_type <= 4;
        slave_addr <= (m00_axi_araddr - AUDIO_BASE_ADDR) / 8;
      end else if (m00_axi_araddr < AUDIO_BASE_ADDR + AUDIO_FILE_SIZE * 2) begin
        write_type <= 5;
        slave_addr <= (m00_axi_araddr - AUDIO_BASE_ADDR - AUDIO_FILE_SIZE) / 8;
      end else if (m00_axi_araddr < AUDIO_BASE_ADDR + AUDIO_FILE_SIZE * 3) begin
        write_type <= 6;
        slave_addr <= (m00_axi_araddr - AUDIO_BASE_ADDR - AUDIO_FILE_SIZE * 2) / 8;
      end else if (m00_axi_araddr < AUDIO_BASE_ADDR + AUDIO_FILE_SIZE * 4) begin
        write_type <= 7;
        slave_addr <= (m00_axi_araddr - AUDIO_BASE_ADDR - AUDIO_FILE_SIZE * 3) / 8;
      end else begin
        $info("Error: address out of range,%h", m00_axi_araddr);
        $finish();
      end
      @(posedge m00_axi_aclk);
      m00_axi_arready <= 1'b0;
      #12;  // simulate DDR3 latency
      while (1) begin
        @(posedge m00_axi_aclk);
        m00_axi_rvalid <= 1'b1;
        if (write_type == 0) begin
          m00_axi_rdata <= slave_data_fb0[slave_addr+slave_burst_counter];
        end else if (write_type == 1) begin
          m00_axi_rdata <= slave_data_fb1[slave_addr+slave_burst_counter];
        end else if (write_type == 2) begin
          m00_axi_rdata <= slave_data_fb0_alt[slave_addr+slave_burst_counter];
        end else if (write_type == 3) begin
          m00_axi_rdata <= slave_data_fb1_alt[slave_addr+slave_burst_counter];
        end else if (write_type == 4) begin
          m00_axi_rdata <= slave_data_audio0[slave_addr+slave_burst_counter];
        end else if (write_type == 5) begin
          m00_axi_rdata <= slave_data_audio1[slave_addr+slave_burst_counter];
        end else if (write_type == 6) begin
          m00_axi_rdata <= slave_data_audio2[slave_addr+slave_burst_counter];
        end else if (write_type == 7) begin
          m00_axi_rdata <= slave_data_audio3[slave_addr+slave_burst_counter];
        end
        // $info("slave_addr = %h,slave_data=%h",
        //       (slave_addr + slave_burst_counter) * 8 + FB0_ADDR,
        //       slave_data_fb0[slave_addr+slave_burst_counter]);
        if (slave_burst_counter == m00_axi_arlen) begin  // read single burst
          m00_axi_rlast <= 1'b1;
          break;
        end
        slave_burst_counter <= slave_burst_counter + 1;  // 8byte addr+1
        wait (m00_axi_rready);
      end
      wait (m00_axi_rready);
      @(posedge m00_axi_aclk);
      m00_axi_rvalid <= 1'b0;
      m00_axi_rlast  <= 1'b0;

      //end of write transaction
    end
  endtask

  task slave_read_single_line();
    begin
      wait (init_read_line);
      // Read FB0
      repeat (5) axi_slave_provide_read_burst();
      // Read FB1
      repeat (5) axi_slave_provide_read_burst();
    end
  endtask
  // task slave_read_audio();
  //   begin
  //     wait (init_read_line);
  //     // Read FB0
  //     repeat (5) axi_slave_provide_read_burst();
  //     // Read FB1
  //     repeat (5) axi_slave_provide_read_burst();
  //   end
  // endtask
  // set_property library xil_defaultlib [get_files]
  initial begin : TEST_VECTORS
    m00_axi_aresetn = 0;  // active low
    fb_use_alt = 1;  // using alt buffer
    write_audio_type_en = 0;
    #8 m00_axi_aresetn = 1;
    #8 clear_slave_data();
    // add four audios
    audio_type_in = 5'b00000;  // audio 0
    write_audio_type_en = 1;
    #8 write_audio_type_en = 0;
    audio_type_in = 5'b00001;  // audio 1
    #8 write_audio_type_en = 1;
    #8 write_audio_type_en = 0;
    audio_type_in = 5'b10010;  // audio 2 (BGM)
    #8 write_audio_type_en = 1;
    #8 write_audio_type_en = 0;
    // audio_type_in = 5'b00011;  // audio 3
    // #8 write_audio_type_en = 1;
    // #8 write_audio_type_en = 0;
    // audio_type_in = 5'b00011;  // audio 3
    // #8 write_audio_type_en = 1;
    // #8 write_audio_type_en = 0;
    // audio_type_in = 5'b00010;  // audio 2
    // #8 write_audio_type_en = 1;
    // #8 write_audio_type_en = 0;
    // audio_type_in = 5'b00001;  // audio 1
    // #8 write_audio_type_en = 1;
    // #8 write_audio_type_en = 0;
    // audio_type_in = 5'b00000;  // audio 0
    // #8 write_audio_type_en = 1;
    // #8 write_audio_type_en = 0;
    slave_read_single_line();
    repeat (40000) axi_slave_provide_read_burst();
    // when reach 2.5ms, next half load
    #2000 $finish();
  end
endmodule

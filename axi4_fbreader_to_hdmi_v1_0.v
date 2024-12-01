
`timescale 1 ns / 1 ps

module axi4_fbreader_to_hdmi_v1_0 #(
    // Users to add parameters here

    // User parameters ends
    // Do not modify the parameters beyond this line


    // Parameters of Axi Master Bus Interface M00_AXI
    parameter FB0_ADDR = 32'h81000000,
    parameter FB1_ADDR = 32'h8112c000,
    parameter FB0_ALT_ADDR = 32'h81258000,
    parameter FB1_ALT_ADDR = 32'h81384000,
    parameter AUDIO_BASE_ADDR = 32'h814B0000,
    parameter AUDIO_FILE_SIZE = 32'h50bfe0,
    parameter integer FB_BEATS_LEN = 64,
    parameter integer AUDIO_BEATS_LEN = 256,
    parameter integer C_M00_AXI_ID_WIDTH = 1,
    parameter integer C_M00_AXI_ADDR_WIDTH = 32,
    parameter integer C_M00_AXI_DATA_WIDTH = 64
) (
    // Video Port
    input wire fb_use_alt,
    output wire hdmi_clk_n,
    output wire hdmi_clk_p,
    output wire [2:0] hdmi_tx_n,
    output wire [2:0] hdmi_tx_p,
    //25m exactly for xc7s50-2csga324
    input wire clk_25m,
    // Audio Port
    output wire left_out,
    output wire right_out,
    input wire [4:0] audio_type_in,
    input wire write_audio_type_en,
    // Ports of Axi Master Bus Interface M00_AXI
    output wire m00_axi_machine_busy,
    output wire m00_axi_error,
    input wire m00_axi_aclk,
    input wire m00_axi_aresetn,
    output wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid,
    output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr,
    output wire [7 : 0] m00_axi_arlen,
    output wire [2 : 0] m00_axi_arsize,
    output wire [1 : 0] m00_axi_arburst,
    output wire m00_axi_arlock,
    output wire [3 : 0] m00_axi_arcache,
    output wire [2 : 0] m00_axi_arprot,
    output wire [3 : 0] m00_axi_arqos,
    output wire m00_axi_arvalid,
    input wire m00_axi_arready,
    input wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata,
    input wire [1 : 0] m00_axi_rresp,
    input wire m00_axi_rlast,
    input wire m00_axi_rvalid,
    output wire m00_axi_rready
);
  // Instantiation of Axi Bus Interface M00_AXI
  wire [7:0] red, green, blue;
  wire hs, vs, active_nblank, sync;
  wire [9:0] drawX, drawY;
  wire init_read_line, v_blank;
  wire clk_125m, clk_200mhz, locked;
  axi4_fbreader_to_hdmi_v1_0_M00_AXI #(
      .FB0_ADDR(FB0_ADDR),
      .FB1_ADDR(FB1_ADDR),
      .FB0_ALT_ADDR(FB0_ALT_ADDR),
      .FB1_ALT_ADDR(FB1_ALT_ADDR),
      .AUDIO_BASE_ADDR(AUDIO_BASE_ADDR),
      .AUDIO_FILE_SIZE(AUDIO_FILE_SIZE),
      .FB_BEATS_LEN(FB_BEATS_LEN),
      .AUDIO_BEATS_LEN(AUDIO_BEATS_LEN),
      .C_M_AXI_ID_WIDTH(C_M00_AXI_ID_WIDTH),
      .C_M_AXI_ADDR_WIDTH(C_M00_AXI_ADDR_WIDTH),
      .C_M_AXI_DATA_WIDTH(C_M00_AXI_DATA_WIDTH)
  ) axi4_fbreader_to_hdmi_v1_0_M00_AXI_inst (
      // audio
      .left_out(left_out),
      .right_out(right_out),
			.clk_200mhz(clk_200mhz),
      .audio_type_in(audio_type_in),
      .write_audio_type_en(write_audio_type_en),
      // video (audio read is dominated by video read so call it INIT_AXI_TXN)
      .fb_use_alt(fb_use_alt),
      .INIT_AXI_TXN(init_read_line),
      .MACHINE_BUSY(m00_axi_machine_busy),
      .ERROR(m00_axi_error),
      .M_AXI_ACLK(m00_axi_aclk),
      .M_AXI_ARESETN(m00_axi_aresetn),
      .M_AXI_ARID(m00_axi_arid),
      .M_AXI_ARADDR(m00_axi_araddr),
      .M_AXI_ARLEN(m00_axi_arlen),
      .M_AXI_ARSIZE(m00_axi_arsize),
      .M_AXI_ARBURST(m00_axi_arburst),
      .M_AXI_ARLOCK(m00_axi_arlock),
      .M_AXI_ARCACHE(m00_axi_arcache),
      .M_AXI_ARPROT(m00_axi_arprot),
      .M_AXI_ARQOS(m00_axi_arqos),
      .M_AXI_ARVALID(m00_axi_arvalid),
      .M_AXI_ARREADY(m00_axi_arready),
      .M_AXI_RDATA(m00_axi_rdata),
      .M_AXI_RRESP(m00_axi_rresp),
      .M_AXI_RLAST(m00_axi_rlast),
      .M_AXI_RVALID(m00_axi_rvalid),
      .M_AXI_RREADY(m00_axi_rready),
      .drawX(drawX),
      .v_blank(v_blank),
      .R(red),
      .G(green),
      .B(blue)
  );
  clk_wiz_0 main_clkgen (
      .clk_125m(clk_125m),
      .clk_200mhz(clk_200mhz),
      .reset(~m00_axi_aresetn),  //active high reset
      .locked(locked),
      .clk_in1(clk_25m)  // 100M from clk local
  );
  // User logic ends
  vga_controller vgac (
      .hs(hs),
      .vs(vs),
      .active_nblank(active_nblank),
      .sync(sync),
      .drawX(drawX),
      .drawY(drawY),
      .init_read_line(init_read_line),
      .v_blank(v_blank),
      .pixel_clk(clk_25m),
      .reset(~m00_axi_aresetn)
  );  //active high reset
  // Add user logic here
  hdmi_tx_v1_0 #(
      .MODE("HDMI"),  // Encoder Mode: HDMI or DVI
      .C_RED_WIDTH(8),  // Width of Red Channel
      .C_GREEN_WIDTH(8),  // Width of Green Channel
      .C_BLUE_WIDTH(8)  // Width of Blue Channel
  ) vga_to_hdmi (
      .pix_clk(clk_25m),
      .pix_clkx5(clk_125m),
      .pix_clk_locked(locked),
      //active high reset
      .rst(~m00_axi_aresetn),
      .red(red),
      .green(green),
      .blue(blue),
      .hsync(hs),
      .vsync(vs),
      .vde(active_nblank),

      .aux0_din(4'b0),
      .aux1_din(4'b0),
      .aux2_din(4'b0),
      .ade(1'b0),

      .TMDS_CLK_P (hdmi_clk_p),
      .TMDS_CLK_N (hdmi_clk_n),
      .TMDS_DATA_P(hdmi_tx_p),
      .TMDS_DATA_N(hdmi_tx_n)
  );
  // User logic ends

endmodule

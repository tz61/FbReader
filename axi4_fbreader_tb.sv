`timescale 1ns / 100ps
module axi4_fbreader_tb ();
  localparam C_M00_AXI_TARGET_SLAVE_BASE_ADDR = 32'h81000000;
  localparam integer C_M00_AXI_BURST_LEN = 64;
  localparam integer C_M00_AXI_ID_WIDTH = 1;
  localparam integer C_M00_AXI_ADDR_WIDTH = 32;
  localparam integer C_M00_AXI_DATA_WIDTH = 64;
  logic hdmi_clk_n;
  logic hdmi_clk_p;
  logic [2:0] hdmi_tx_n;
  logic [2:0] hdmi_tx_p;
  logic clk_25m;  //25m exactly for xc7s50-2csga324

  // Ports of Axi Master Bus Interface M00_AXI
  logic m00_axi_machine_idle;
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
  logic [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid;
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
  // testbench buffer
  logic is_fb0;
  logic [C_M00_AXI_ADDR_WIDTH-1 : 0] slave_addr;
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] slave_data_fb0[(640/2)*480];// 64bit for 2 pixel, 640x480
  logic [C_M00_AXI_DATA_WIDTH-1 : 0] slave_data_fb1[(640/2)*480];// 64bit for 2 pixel, 640x480
  logic is_read_fb0;
  task clear_slave_data();
    is_fb0 = 1;
    begin
      integer i;
      for (i = 0; i < (640 / 2) * 480; i = i + 1) begin
        slave_data_fb0[i] = i % 64;
        slave_data_fb1[i] = i % 64;
      end
    end
  endtask
  task axi_slave_provide_read_line();
    begin
      wait (init_read_line);  // pulse
      wait (m00_axi_arvalid);
      @(posedge m00_axi_aclk);
      m00_axi_arready <= 1'b1;
      slave_addr <= (m00_axi_araddr - C_M00_AXI_TARGET_SLAVE_BASE_ADDR)/8; // byte addr to 8byte addr
      @(posedge m00_axi_aclk);
      m00_axi_arready <= 1'b0;
      #4;
      while (1) begin
        @(posedge m00_axi_aclk);
        m00_axi_rvalid <= 1'b1;
        m00_axi_rdata  <= slave_data_fb0[slave_addr];
        $info("slave_addr = %h,slave_data[slave_addr]=%h",
              slave_addr * 8 + C_M00_AXI_TARGET_SLAVE_BASE_ADDR, slave_data_fb0[slave_addr]);
        if (slave_addr == (640 / 2) * 480 - 1) begin
          m00_axi_rlast <= 1'b1;
          break;
        end
        slave_addr <= slave_addr + 1; // 8byte addr+1
      end
      wait (m00_axi_rready);
      @(posedge m00_axi_aclk);
      m00_axi_rvalid <= 1'b0;
      m00_axi_rlast  <= 1'b0;

      //end of write transaction
    end
  endtask
  // set_property library xil_defaultlib [get_files]
  initial begin : TEST_VECTORS

    m00_axi_aresetn = 0;  // active low
    #8 m00_axi_aresetn = 1;
    #8 hc = 10'b1001111000;  // less than 10'b1001111111

    // initiate a read from master to slave(testbench act as slave)
    clear_slave_data();
    axi_slave_provide_read();
    $finish();
  end
endmodule

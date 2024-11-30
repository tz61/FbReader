
`timescale 1 ns / 1 ps

module axi4_fbreader_to_hdmi_v1_0_M00_AXI #(
    // Users to add parameters here

    // User parameters ends
    // Do not modify the parameters beyond this line

    // Base address of targeted slave
    parameter FB0_ADDR = 32'h81000000,
    parameter FB1_ADDR = 32'h8112c000,
    // Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
    parameter integer C_M_AXI_BURST_LEN = 64,
    // Thread ID Width
    parameter integer C_M_AXI_ID_WIDTH = 1,
    // Width of Address Bus
    parameter integer C_M_AXI_ADDR_WIDTH = 32,
    // Width of Data Bus
    parameter integer C_M_AXI_DATA_WIDTH = 64
) (
    // Users to add ports here

    // User ports ends
    // Do not modify the ports beyond this line

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
  // function called clogb2 that returns an integer which has the
  //value of the ceiling of the log base 2

  // function called clogb2 that returns an integer which has the 
  // value of the ceiling of the log base 2.                      
  function integer clogb2(input integer bit_depth);
    begin
      for (clogb2 = 0; bit_depth > 0; clogb2 = clogb2 + 1) bit_depth = bit_depth >> 1;
    end
  endfunction

  // C_TRANSACTIONS_NUM is the width of the index counter for 
  // number of write or read transaction.
  localparam integer C_TRANSACTIONS_NUM = clogb2(C_M_AXI_BURST_LEN - 1);  //6


  localparam integer READ_BEATS_COUNT = 5;  // 5*128=640 pixels

  typedef enum logic [3:0] {
    IDLE = 4'h0,
    FB0_READ = 4'h1,
    FB1_READ = 4'h2
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
  logic [C_TRANSACTIONS_NUM : 0] read_index;

  logic [2:0] read_burst_counter;
  // hex(640*4*480)= 0x12c000, 21 bits
  logic [20:0] line_stride_addr_counter;
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



  //Read Address (AR)
  assign M_AXI_ARID = 'b0;
  assign M_AXI_ARADDR = axi_araddr + axi_addr_base;
  //Burst LENgth is number of transaction beats, minus 1
  assign M_AXI_ARLEN = C_M_AXI_BURST_LEN - 1;
  //Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
  assign M_AXI_ARSIZE = clogb2((C_M_AXI_DATA_WIDTH / 8) - 1);  //011,8bytes per transfer
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
      if (M_AXI_RLAST && axi_rready && (read_burst_counter == (READ_BEATS_COUNT - 1)) && (mst_exec_state == FB1_READ))
        line_stride_addr_counter <= line_stride_addr_counter + 12'hA00;  //640*4=2560,0xA00
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
      axi_araddr <= line_stride_addr_counter;
    end else if (M_AXI_ARREADY && axi_arvalid) begin
      //Burst size in bytes One beat, 64*8=512 Byte, 128 pixels, 5 beat=640 pixels
      axi_araddr <= axi_araddr + C_M_AXI_BURST_LEN * C_M_AXI_DATA_WIDTH / 8;
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
    end                                                               
	    else if (rnext && (read_index != C_M_AXI_BURST_LEN-1))// max index of beat in a single burst is C_M_AXI_BURST_LEN-1, 63
	      begin
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
    if (mst_exec_state == FB0_READ) begin
      bram0_wea = rnext;
      bram1_wea = 1'b0;
    end else if (mst_exec_state == FB1_READ) begin
      bram0_wea = 1'b0;
      bram1_wea = rnext;
    end else begin
      bram0_wea = 1'b0;
      bram1_wea = 1'b0;
    end
  end
  // read_burst_counter counter keeps track with the number of burst transaction initiated                   
  // against the number of burst transactions the master needs to initiate                                   
  always_ff @(posedge M_AXI_ACLK) begin
    if (M_AXI_ARESETN == 0) begin
      read_burst_counter <= 'b0;
      // end else if (M_AXI_ARREADY && axi_arvalid) begin, to prevent generating erroneous bram addr(eg from 0x0 to 0x40)
    end else if (M_AXI_RLAST && axi_rready) begin
      if (read_burst_counter != READ_BEATS_COUNT) begin
        read_burst_counter <= read_burst_counter + 1'b1;
      end
    end else if (read_burst_counter == READ_BEATS_COUNT) begin
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
      mst_exec_state          <= IDLE;
      start_single_burst_read <= 1'b0;
      MACHINE_BUSY            <= 1'b0;
      axi_addr_base           <= FB0_ADDR;
      init_burst_pulse        <= 1'b0;
    end else begin
      // state transition                                                                                 
      case (mst_exec_state)
        IDLE:
        // This state is responsible to wait for user defined C_M_START_COUNT                           
        // number of clock cycles.                                                                      
        if (init_txn_pulse == 1'b1) begin
          mst_exec_state <= FB0_READ;
          axi_addr_base <= FB0_ADDR;
          init_burst_pulse <= 1'b1;
          MACHINE_BUSY <= 1'b1;
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
        if (read_burst_counter == READ_BEATS_COUNT) begin
          // do FB1 read
          mst_exec_state <= FB1_READ;
          axi_addr_base <= FB1_ADDR;
          init_burst_pulse <= 1'b1;  // at start of each bunch of burst
        end else begin
          init_burst_pulse <= 1'b0;  // disable pulse
          mst_exec_state   <= FB0_READ;
          if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read) begin
            start_single_burst_read <= 1'b1;
          end else begin
            start_single_burst_read <= 1'b0; //Negate to generate a pulse                            
          end
        end
        FB1_READ:  // state 'h02
        if (read_burst_counter == READ_BEATS_COUNT) begin
          mst_exec_state <= IDLE;
          axi_addr_base  <= FB0_ADDR;  // not necessary to do this
        end else begin
          init_burst_pulse <= 1'b0;  // disable pulse
          mst_exec_state   <= FB1_READ;
          if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read) begin
            start_single_burst_read <= 1'b1;
          end else begin
            start_single_burst_read <= 1'b0; //Negate to generate a pulse                            
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

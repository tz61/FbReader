// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu Dec  5 23:38:31 2024
// Host        : DESKTOP-9D7T4FN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Embedded/Xilinx/myprojects/ip_repo/zynq7010_axi4_fbreader_to_hdmi_1_0/src/event_fifo/event_fifo_stub.v
// Design      : event_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_7,Vivado 2022.2" *)
module event_fifo(clk, srst, din, wr_en, rd_en, dout, full, empty, 
  almost_empty)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[4:0],wr_en,rd_en,dout[4:0],full,empty,almost_empty" */;
  input clk;
  input srst;
  input [4:0]din;
  input wr_en;
  input rd_en;
  output [4:0]dout;
  output full;
  output empty;
  output almost_empty;
endmodule

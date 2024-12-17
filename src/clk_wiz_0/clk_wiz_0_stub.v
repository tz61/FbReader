// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu Dec  5 23:39:47 2024
// Host        : DESKTOP-9D7T4FN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Embedded/Xilinx/myprojects/ip_repo/zynq7010_axi4_fbreader_to_hdmi_1_0/src/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_125m, clk_200mhz, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_125m,clk_200mhz,reset,locked,clk_in1" */;
  output clk_125m;
  output clk_200mhz;
  input reset;
  output locked;
  input clk_in1;
endmodule

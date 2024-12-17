// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu Dec  5 23:34:18 2024
// Host        : DESKTOP-9D7T4FN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Embedded/Xilinx/myprojects/ip_repo/zynq7010_axi4_fbreader_to_hdmi_1_0/src/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    ena,
    wea,
    addra,
    dina,
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [8:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [63:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [8:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [63:0]doutb;

  wire [8:0]addra;
  wire [8:0]addrb;
  wire clka;
  wire clkb;
  wire [63:0]dina;
  wire [63:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [63:0]NLW_U0_douta_UNCONNECTED;
  wire [8:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [8:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [63:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "9" *) 
  (* C_ADDRB_WIDTH = "9" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     6.966099 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "512" *) 
  (* C_READ_DEPTH_B = "512" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "64" *) 
  (* C_READ_WIDTH_B = "64" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "512" *) 
  (* C_WRITE_DEPTH_B = "512" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "64" *) 
  (* C_WRITE_WIDTH_B = "64" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[63:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[8:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[8:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[63:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31264)
`pragma protect data_block
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
JSSp2DP7GmqgdDQhM5ogPBi1OhhitSImvV1zvg==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif

// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Fri Dec  6 20:06:46 2024
// Host        : DESKTOP-9D7T4FN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Embedded/Xilinx/myprojects/ip_repo/zynq7010_axi4_fbreader_to_hdmi_1_0/src/blk_mem_gen_0_1/blk_mem_gen_0_sim_netlist.v
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
  (* C_READ_DEPTH_A = "320" *) 
  (* C_READ_DEPTH_B = "320" *) 
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
  (* C_WRITE_DEPTH_A = "320" *) 
  (* C_WRITE_DEPTH_B = "320" *) 
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
pMn4TEDjD+QJbcJEO3BOxGPi2Nvy80atPYm0Mg==
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

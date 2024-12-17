

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "zynq7010_axi4_fbreader_to_hdmi" "NUM_INSTANCES" "DEVICE_ID"  "C_S00_AXI_BASEADDR" "C_S00_AXI_HIGHADDR"
}

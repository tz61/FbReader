# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S00_AXI_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_HIGHADDR" -parent ${Page_0}

  ipgui::add_param $IPINST -name "FB0_ADDR"
  ipgui::add_param $IPINST -name "FB1_ADDR"
  ipgui::add_param $IPINST -name "FB0_ALT_ADDR"
  ipgui::add_param $IPINST -name "FB1_ALT_ADDR"
  ipgui::add_param $IPINST -name "AUDIO_BGM_ADDR"
  ipgui::add_param $IPINST -name "AUDIO_SFX_ADDR"
  ipgui::add_param $IPINST -name "AUDIO_BGM_SIZE"
  ipgui::add_param $IPINST -name "AUDIO_SFX_SIZE"

}

proc update_PARAM_VALUE.AUDIO_BEATS_LEN { PARAM_VALUE.AUDIO_BEATS_LEN } {
	# Procedure called to update AUDIO_BEATS_LEN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDIO_BEATS_LEN { PARAM_VALUE.AUDIO_BEATS_LEN } {
	# Procedure called to validate AUDIO_BEATS_LEN
	return true
}

proc update_PARAM_VALUE.AUDIO_BGM_ADDR { PARAM_VALUE.AUDIO_BGM_ADDR } {
	# Procedure called to update AUDIO_BGM_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDIO_BGM_ADDR { PARAM_VALUE.AUDIO_BGM_ADDR } {
	# Procedure called to validate AUDIO_BGM_ADDR
	return true
}

proc update_PARAM_VALUE.AUDIO_BGM_SIZE { PARAM_VALUE.AUDIO_BGM_SIZE } {
	# Procedure called to update AUDIO_BGM_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDIO_BGM_SIZE { PARAM_VALUE.AUDIO_BGM_SIZE } {
	# Procedure called to validate AUDIO_BGM_SIZE
	return true
}

proc update_PARAM_VALUE.AUDIO_SFX_ADDR { PARAM_VALUE.AUDIO_SFX_ADDR } {
	# Procedure called to update AUDIO_SFX_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDIO_SFX_ADDR { PARAM_VALUE.AUDIO_SFX_ADDR } {
	# Procedure called to validate AUDIO_SFX_ADDR
	return true
}

proc update_PARAM_VALUE.AUDIO_SFX_SIZE { PARAM_VALUE.AUDIO_SFX_SIZE } {
	# Procedure called to update AUDIO_SFX_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDIO_SFX_SIZE { PARAM_VALUE.AUDIO_SFX_SIZE } {
	# Procedure called to validate AUDIO_SFX_SIZE
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_ADDR_WIDTH { PARAM_VALUE.C_M00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_M00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_ADDR_WIDTH { PARAM_VALUE.C_M00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_M00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_DATA_WIDTH { PARAM_VALUE.C_M00_AXI_DATA_WIDTH } {
	# Procedure called to update C_M00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_DATA_WIDTH { PARAM_VALUE.C_M00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_M00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_ID_WIDTH { PARAM_VALUE.C_M00_AXI_ID_WIDTH } {
	# Procedure called to update C_M00_AXI_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_ID_WIDTH { PARAM_VALUE.C_M00_AXI_ID_WIDTH } {
	# Procedure called to validate C_M00_AXI_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.FB0_ADDR { PARAM_VALUE.FB0_ADDR } {
	# Procedure called to update FB0_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FB0_ADDR { PARAM_VALUE.FB0_ADDR } {
	# Procedure called to validate FB0_ADDR
	return true
}

proc update_PARAM_VALUE.FB0_ALT_ADDR { PARAM_VALUE.FB0_ALT_ADDR } {
	# Procedure called to update FB0_ALT_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FB0_ALT_ADDR { PARAM_VALUE.FB0_ALT_ADDR } {
	# Procedure called to validate FB0_ALT_ADDR
	return true
}

proc update_PARAM_VALUE.FB1_ADDR { PARAM_VALUE.FB1_ADDR } {
	# Procedure called to update FB1_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FB1_ADDR { PARAM_VALUE.FB1_ADDR } {
	# Procedure called to validate FB1_ADDR
	return true
}

proc update_PARAM_VALUE.FB1_ALT_ADDR { PARAM_VALUE.FB1_ALT_ADDR } {
	# Procedure called to update FB1_ALT_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FB1_ALT_ADDR { PARAM_VALUE.FB1_ALT_ADDR } {
	# Procedure called to validate FB1_ALT_ADDR
	return true
}

proc update_PARAM_VALUE.FB_BEATS_LEN { PARAM_VALUE.FB_BEATS_LEN } {
	# Procedure called to update FB_BEATS_LEN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FB_BEATS_LEN { PARAM_VALUE.FB_BEATS_LEN } {
	# Procedure called to validate FB_BEATS_LEN
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to update C_S00_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to validate C_S00_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to update C_S00_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to validate C_S00_AXI_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.FB0_ADDR { MODELPARAM_VALUE.FB0_ADDR PARAM_VALUE.FB0_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FB0_ADDR}] ${MODELPARAM_VALUE.FB0_ADDR}
}

proc update_MODELPARAM_VALUE.FB1_ADDR { MODELPARAM_VALUE.FB1_ADDR PARAM_VALUE.FB1_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FB1_ADDR}] ${MODELPARAM_VALUE.FB1_ADDR}
}

proc update_MODELPARAM_VALUE.FB0_ALT_ADDR { MODELPARAM_VALUE.FB0_ALT_ADDR PARAM_VALUE.FB0_ALT_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FB0_ALT_ADDR}] ${MODELPARAM_VALUE.FB0_ALT_ADDR}
}

proc update_MODELPARAM_VALUE.FB1_ALT_ADDR { MODELPARAM_VALUE.FB1_ALT_ADDR PARAM_VALUE.FB1_ALT_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FB1_ALT_ADDR}] ${MODELPARAM_VALUE.FB1_ALT_ADDR}
}

proc update_MODELPARAM_VALUE.AUDIO_BGM_ADDR { MODELPARAM_VALUE.AUDIO_BGM_ADDR PARAM_VALUE.AUDIO_BGM_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDIO_BGM_ADDR}] ${MODELPARAM_VALUE.AUDIO_BGM_ADDR}
}

proc update_MODELPARAM_VALUE.AUDIO_SFX_ADDR { MODELPARAM_VALUE.AUDIO_SFX_ADDR PARAM_VALUE.AUDIO_SFX_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDIO_SFX_ADDR}] ${MODELPARAM_VALUE.AUDIO_SFX_ADDR}
}

proc update_MODELPARAM_VALUE.AUDIO_BGM_SIZE { MODELPARAM_VALUE.AUDIO_BGM_SIZE PARAM_VALUE.AUDIO_BGM_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDIO_BGM_SIZE}] ${MODELPARAM_VALUE.AUDIO_BGM_SIZE}
}

proc update_MODELPARAM_VALUE.AUDIO_SFX_SIZE { MODELPARAM_VALUE.AUDIO_SFX_SIZE PARAM_VALUE.AUDIO_SFX_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDIO_SFX_SIZE}] ${MODELPARAM_VALUE.AUDIO_SFX_SIZE}
}

proc update_MODELPARAM_VALUE.FB_BEATS_LEN { MODELPARAM_VALUE.FB_BEATS_LEN PARAM_VALUE.FB_BEATS_LEN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FB_BEATS_LEN}] ${MODELPARAM_VALUE.FB_BEATS_LEN}
}

proc update_MODELPARAM_VALUE.AUDIO_BEATS_LEN { MODELPARAM_VALUE.AUDIO_BEATS_LEN PARAM_VALUE.AUDIO_BEATS_LEN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDIO_BEATS_LEN}] ${MODELPARAM_VALUE.AUDIO_BEATS_LEN}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_ID_WIDTH { MODELPARAM_VALUE.C_M00_AXI_ID_WIDTH PARAM_VALUE.C_M00_AXI_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_ID_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_M00_AXI_ADDR_WIDTH PARAM_VALUE.C_M00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_M00_AXI_DATA_WIDTH PARAM_VALUE.C_M00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_DATA_WIDTH}
}


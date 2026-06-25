##########
# Clocks #
##########
create_clock -name CLK -period 10 -waveform {0 5} [get_ports CLK]

###############
# Input Delay #
###############
set_input_delay 0 -clock CLK  -add_delay  [get_ports {TESTMODE RESET LOAD ADDRS* DATA_IN*}]

################
# Output Delay #
################
set_output_delay 0 -clock CLK  -add_delay  [get_ports {LED_OUT* ANODE_ACTIVATE* LED_OUT_SSD* CATHODE_ACTIVATE_SSD }]

##############################
# Pin Locations and Voltages #
##############################
set_property -dict { PACKAGE_PIN W5    	IOSTANDARD LVCMOS33 } [get_ports { CLK       	}]; 
set_property -dict { PACKAGE_PIN U17   	IOSTANDARD LVCMOS33 } [get_ports { RESET     	}];
set_property -dict { PACKAGE_PIN T18   	IOSTANDARD LVCMOS33 } [get_ports { TESTMODE  	}];
set_property -dict { PACKAGE_PIN W19   	IOSTANDARD LVCMOS33 } [get_ports { LOAD   		}];
set_property -dict { PACKAGE_PIN V17   	IOSTANDARD LVCMOS33 } [get_ports { ADDRS[0]  	}];
set_property -dict { PACKAGE_PIN V16   	IOSTANDARD LVCMOS33 } [get_ports { ADDRS[1]  	}];
set_property -dict { PACKAGE_PIN T2   	IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[0]  	}];
set_property -dict { PACKAGE_PIN R3   	IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[1]  	}];
set_property -dict { PACKAGE_PIN W2   	IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[2]  	}];
set_property -dict { PACKAGE_PIN U1   	IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[3]  	}];
set_property -dict { PACKAGE_PIN T1   	IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[4] 	}];
set_property -dict { PACKAGE_PIN R2   	IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[5]  	}];

#### SSG (On-board 7-Segment) ####
set_property -dict { PACKAGE_PIN V7    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT[0] }];
set_property -dict { PACKAGE_PIN U7    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT[1] }];
set_property -dict { PACKAGE_PIN V5   	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT[2] }];
set_property -dict { PACKAGE_PIN U5   	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT[3] }];
set_property -dict { PACKAGE_PIN V8    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT[4] }]; 
set_property -dict { PACKAGE_PIN U8    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT[5] }];
set_property -dict { PACKAGE_PIN W6    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT[6] }];
set_property -dict { PACKAGE_PIN W7    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT[7] }];

set_property -dict { PACKAGE_PIN U2    	IOSTANDARD LVCMOS33 } [get_ports { ANODE_ACTIVATE[0] }];
set_property -dict { PACKAGE_PIN U4    	IOSTANDARD LVCMOS33 } [get_ports { ANODE_ACTIVATE[1] }];
set_property -dict { PACKAGE_PIN V4    	IOSTANDARD LVCMOS33 } [get_ports { ANODE_ACTIVATE[2] }];
set_property -dict { PACKAGE_PIN W4    	IOSTANDARD LVCMOS33 } [get_ports { ANODE_ACTIVATE[3] }];




#### PMOD-SSD ####

set_property -dict { PACKAGE_PIN J2    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT_SSD[0] }];
set_property -dict { PACKAGE_PIN L2    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT_SSD[1] }];
set_property -dict { PACKAGE_PIN J1    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT_SSD[2] }];
set_property -dict { PACKAGE_PIN N2    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT_SSD[3] }];
set_property -dict { PACKAGE_PIN M2    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT_SSD[4] }];
set_property -dict { PACKAGE_PIN L3    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT_SSD[5] }];
set_property -dict { PACKAGE_PIN J3    	IOSTANDARD LVCMOS33 } [get_ports { LED_OUT_SSD[6] }];
set_property -dict { PACKAGE_PIN G2    	IOSTANDARD LVCMOS33 } [get_ports { CATHODE_ACTIVATE_SSD }];

##########################
# Configuration Settings #
##########################
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
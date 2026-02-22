###############################################################
# Clock Definition
###############################################################
create_clock -name clk -period 2.0 [get_ports clk]

set_clock_uncertainty -setup 0.15  [get_clocks clk]
set_clock_uncertainty -hold  0.05 [get_clocks clk]
set_clock_transition  0.15        [get_clocks clk]

###############################################################
# False Paths (Async signals - rstn is active-low async reset)
###############################################################
set_false_path -from [get_ports rstn]
set_false_path -from [get_ports bist_mode]  ;# static config signal
set_false_path -from [get_ports scan_en]    ;# DFT control, not timed normally

###############################################################
# Input Delays (~25% of the clock period)
###############################################################
set inp_max 0.5
set inp_min 0.1

set_input_delay -clock clk -max $inp_max [get_ports scan_in]
set_input_delay -clock clk -min $inp_min [get_ports scan_in]

# data_in is a 4-bit bus (WIDTH=4)
set_input_delay -clock clk -max $inp_max [get_ports {data_in[*]}]
set_input_delay -clock clk -min $inp_min [get_ports {data_in[*]}]

###############################################################
# Output Delays (~25% of the clock period)
###############################################################
set out_max 0.5
set out_min 0.1

set_output_delay -clock clk -max $out_max [get_ports scan_out]
set_output_delay -clock clk -min $out_min [get_ports scan_out]

set_output_delay -clock clk -max $out_max [get_ports {data_out[*]}]
set_output_delay -clock clk -min $out_min [get_ports {data_out[*]}]

set_output_delay -clock clk -max $out_max [get_ports {misr_signature[*]}]
set_output_delay -clock clk -min $out_min [get_ports {misr_signature[*]}]

###############################################################
# Driving Cell & Load
###############################################################
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_2 \
                 -pin X [all_inputs]
set_load 0.1 [all_outputs]

###############################################################
# Clock Groups
###############################################################
set_clock_groups -asynchronous -group [get_clocks clk]

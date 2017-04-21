# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a200tsbg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.cache/wt [current_project]
set_property parent.project_path C:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys_video:part0:1.1 [current_project]
set_property ip_output_repo c:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_mem {
  C:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.srcs/sources_1/new/a_vec.mem
  C:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.srcs/sources_1/new/b_vec.mem
}
read_verilog -library xil_defaultlib C:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.srcs/sources_1/new/top.v
read_ip -quiet c:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.srcs/sources_1/ip/floating_point_MAC/floating_point_MAC.xci
set_property used_in_implementation false [get_files -all c:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.srcs/sources_1/ip/floating_point_MAC/floating_point_MAC_ooc.xdc]
set_property is_locked true [get_files c:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.srcs/sources_1/ip/floating_point_MAC/floating_point_MAC.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.srcs/constrs_1/imports/Projects/NexysVideo_Master.xdc
set_property used_in_implementation false [get_files C:/Users/Scott/Dropbox/Xilinx/Projects/fp_test/fp_test.srcs/constrs_1/imports/Projects/NexysVideo_Master.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top top -part xc7a200tsbg484-1


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
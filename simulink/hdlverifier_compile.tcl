# ======== Create Project ======== 
create_project -force wizprj hdlverifier_wizard_project

# ======== Add source files to project ========
set SRC1 {../hdl/designs/rx}
set SRC2 {../hdl/designs/tx}
set SRC3 {blocks}
add_file "$SRC3/digital_top.sv"
add_file "$SRC1/decoder.sv"
add_file "$SRC1/SIPO.sv"
add_file "$SRC2/encoder.sv"
add_file "$SRC2/PISO.sv"

# ======== Elaboration options ========
set_property -name {xelab.snapshot} -value {mwcosim_query} -objects [get_filesets sim_1]

# ======== Compile and Elaborate ========
# Compile, elaborate, and start a sim image in order to auto determine
# the top module and its interface information.
set_property source_mgmt_mode All [current_project]
set_property SOURCE_SET sources_1 [get_filesets sim_1]
update_compile_order -fileset sim_1
launch_simulation

# ======== Gather Design Info ========
# DO NOT EDIT.  Needed for gathering top-level design information.
set TOP_MODULE [get_property top [get_fileset sim_1]]
set INPORT_NAMES [get_objects -filter { type == in_port }]
set OUTPORT_NAMES [get_objects -filter { type == out_port }]
report_scope [current_scope] > hdlverifier_tcl_query_info.txt
foreach {port} [concat $INPORT_NAMES $OUTPORT_NAMES] { report_object $port >> hdlverifier_tcl_query_info.txt}


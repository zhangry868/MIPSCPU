transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {pipeline.vo}

vlog -vlog01compat -work work +incdir+F:/altera/ComputerArchitectrue/pipeline2TimeSimulation/simulation/modelsim {F:/altera/ComputerArchitectrue/pipeline2TimeSimulation/simulation/modelsim/pipeline.vt}

vsim -t 1ps +transport_int_delays +transport_path_delays -L cycloneii_ver -L gate_work -L work -voptargs="+acc"  pipeline_vlg_tst

add wave *
view structure
view signals
run -all

transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/FPGA_Laboratory/Lab4/VGA_diaplay/RTL {C:/FPGA_Laboratory/Lab4/VGA_diaplay/RTL/vga_pic.v}

vlog -vlog01compat -work work +incdir+C:/FPGA_Laboratory/Lab4/VGA_diaplay/Quartus_prj/../Sim {C:/FPGA_Laboratory/Lab4/VGA_diaplay/Quartus_prj/../Sim/tb_vga_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_Laboratory/Lab4/VGA_diaplay/Quartus_prj/../RTL {C:/FPGA_Laboratory/Lab4/VGA_diaplay/Quartus_prj/../RTL/vga_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_Laboratory/Lab4/VGA_diaplay/Quartus_prj/ip_core/clk_gen {C:/FPGA_Laboratory/Lab4/VGA_diaplay/Quartus_prj/ip_core/clk_gen/clk_gen.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_vga_ctrl

add wave *
view structure
view signals
run 1 us

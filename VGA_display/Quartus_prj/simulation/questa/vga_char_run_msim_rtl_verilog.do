transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/FPGA_Laboratory/Lab4/VGA_diaplay/RTL {C:/FPGA_Laboratory/Lab4/VGA_diaplay/RTL/vga_pic.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_Laboratory/Lab4/VGA_diaplay/RTL {C:/FPGA_Laboratory/Lab4/VGA_diaplay/RTL/vga_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_Laboratory/Lab4/VGA_diaplay/RTL {C:/FPGA_Laboratory/Lab4/VGA_diaplay/RTL/vga_char.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_Laboratory/Lab4/VGA_diaplay/Quartus_prj/ipcore_dir {C:/FPGA_Laboratory/Lab4/VGA_diaplay/Quartus_prj/ipcore_dir/pll_ip.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_Laboratory/Lab4/VGA_diaplay/Quartus_prj/db {C:/FPGA_Laboratory/Lab4/VGA_diaplay/Quartus_prj/db/pll_ip_altpll.v}


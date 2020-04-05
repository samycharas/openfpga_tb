# uvm_tb
UVM testbench for fpga 2x2 inverter

Here's my first UVM testbench for a size 2x2 fpga.

DUT is programmed as an inverter, reference model is described in inv.v
I am using 2 agents which files are located in clknrst_agent/ and bs_agent/
clknrst_agent : Generate clock and reset signals aswell as monitor reference output.
bs_agent      : Load bitstream into the DUT, generate random stimuli and monitor DUT's output

environement files are located in openfpga_env directory
base_test and derived are located in openfpga_tests directory
testbench files are located in openfpga_tb directory
Both dut and reference model input are connected to the same interface, monitors are enabled only after configuration is done.


Project name for Questa is fpga_uvm12.mpf

Compilation files :

# Compile of clknrst_pkg.sv was successful.
# Compile of fpga_top_rIO.v was successful.
# Compile of bs_pkg.sv was successful.
# Compile of inv.v was successful.
# Compile of logic_blocks.v was successful.
# Compile of routing.v was successful.
# Compile of sub_module.v was successful.
# Compile of std_cell_extract.v was successful.
# Compile of openfpga_env_pkg.sv was successful.
# Compile of openfpga_tb_pkg.sv was successful.
# Compile of openfpga_tb.sv was successful.

Additional informations :

Modelsim is using an old UVM version. To run a testbench with uvm-1.2 library follow theses steps :

1- Create new project, copy settings from another modelsim.ini which will have one line modified :
mtiUvm = $MODEL_TECH/../uvm-1.1d = mtiUvm => $MODEL_TECH/../uvm-1.2

2- Add compilation files

3- Right click on uvm files, Compile properties, add the following line next to "Other Verilog options" :
+incdir+/uusoc/facility/cad_tools/Mentor/lnis_tools/modelsim/questasim/verilog_src/uvm-1.2/src



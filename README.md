# uvm_tb
UVM testbench for fpga 2x2 inverter

Here's my first UVM testbench for a size 2x2 fpga.

DUT is programmed as an inverter, reference model is described in inv.v
I am using 2 agents :
clk_agent : Generate clock and reset signals aswell as monitor reference output.
bs_agent  : Generate bitstream to programm the fpga, drive stimuli and monitor dut output.

Both dut and reference model input are connected to the same interface, monitors are enabled only after configuration is done.

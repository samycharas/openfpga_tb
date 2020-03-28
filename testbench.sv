`include "uvm_macros.svh"
`include "my_testbench_pkg.svh"

`timescale 1ns / 1ps

interface clkrst_if ();

   logic [0:0] pReset ;
   logic [0:0] Test_en ;
   logic [0:0] clk ;
   logic [0:0] prog_clock_reg;
   logic [0:0] Reset;
   logic [0:0] clk_stim;
   logic [0:0] OUT; // Monitoring ref dut
   bit	       clk_uvm;

always
	begin
		#5 clk_uvm = ~clk_uvm;
	end
   

endinterface:clkrst_if

interface prog_if(input clk_stim, clk);

   logic       ccff_head;
   logic       config_done = 1'b0;
   logic [0:0] ccff_tail;
   wire  [0:7] gfpga_pad_GPIO;
   logic [0:7] gfpga_pad_GPIO_IN_drv = 8'h00; // Can't connect logic to INOUT
   assign gfpga_pad_GPIO[1:7] = gfpga_pad_GPIO_IN_drv[1:7];
//   assign gfpga_pad_GPIO_IN_drv[0] = gfpga_pad_GPIO[0];
   modport DRIVER (inout gfpga_pad_GPIO); 
 

   bit clk_uvm;

always
	begin
		#50.0000038 clk_uvm = ~clk_uvm;
	end

 // always
 //   begin
//	#50.00000381	prog_clock_reg = ~prog_clock_reg;
 //   end
endinterface:prog_if


module tb;
   
  
   import uvm_pkg::*;
  import my_testbench_pkg::*;   
   
   // Creating instance of interface
   clkrst_if intf();
   prog_if intfp(intf.clk_stim, intf.clk);

   
   // connect to DUT through the interface
   fpga_top DUT(
	    .pReset_pad(intf.pReset),
	    .prog_clk_pad(intf.prog_clock_reg),
	    .Reset_pad(intf.Reset),
	    .Test_en_pad(intf.Test_en),
	    .clk_pad(intf.clk),
	    .gfpga_pad_GPIO(intfp.gfpga_pad_GPIO[0:7]),
	    .ccff_head_pad(intfp.ccff_head),
	    .ccff_tail_pad(intfp.ccff_tail));

  // Reference model

   inv REF_DUT(
		.IN(intfp.gfpga_pad_GPIO[7]),
		.OUT(intf.OUT));


 
 
initial begin  
   uvm_config_db#(virtual clkrst_if)::set(uvm_root::get(),"*","vif",intf);
   uvm_config_db#(virtual prog_if)::set(uvm_root::get(),"*","vif",intfp);
   $dumpfile("log.vcd");
   $dumpvars;
end
   

   
 
   
  initial
    begin
      run_test("my_test");
       
    end
  
  
endmodule


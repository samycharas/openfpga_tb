`ifndef CLK_DRIVER
`define CLK_DRIVER

class clk_driver extends uvm_driver #(clk_seq_item);

   // Virtual Interface
   virtual clkrst_if vif;
   
  
  `uvm_component_utils(clk_driver)

   /**
    * Default constructor.
    */
   extern function new(string name="clk_driver", uvm_component parent=null);
   
   /**
    * Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Obtains the reqs from the sequence item port and calls drv_req()
    */
   extern virtual task run_phase(uvm_phase phase);
   
//   /**
//    * Drives the virtual interface's (cntxt.vif) signals using req's contents.
//    */
//   extern task drive();

  // drive
  virtual task drive();
	req.print();
	$display("-----------------------------------------");
	@(negedge vif.clk_uvm);
		vif.pReset= req.pReset;
		vif.Reset = req.Reset;
		vif.clk   = req.clk;
		vif.Test_en = req.Test_en;
		vif.prog_clock_reg = req.prog_clock_reg;
		vif.clk_stim = req.clk_stim; // clock for 2nd driver
     
  endtask : drive

endclass : clk_driver
  
  function clk_driver::new(string name="clk_driver",uvm_component parent);
	super.new(name,parent);
  endfunction : new

  function void clk_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(virtual clkrst_if)::get(this,"","vif",vif)) `uvm_fatal("NO_VIF",{"virtual interface must be set for :",get_full_name(),".vif"});
  endfunction : build_phase
    
   // run phase
  task clk_driver::run_phase(uvm_phase phase);
	forever begin
       		`uvm_info("driver", $sformatf("debug purpose"), UVM_LOW);      
    		seq_item_port.get_next_item(req);
		drive();
		seq_item_port.item_done();
	end
  endtask : run_phase
 
//  // drive
//  task drive(clk_rst_if vif);
//	req.print();
//	$display("-----------------------------------------");
//	@(negedge vif.clk_uvm);
//		vif.pReset= req.pReset;
//		vif.Reset = req.Reset;
//		vif.clk   = req.clk;
//		vif.Test_en = req.Test_en;
//		vif.prog_clock_reg = req.prog_clock_reg;
//		vif.clk_stim = req.clk_stim; // clock for 2nd driver
     
//  endtask : drive
   
    
`endif

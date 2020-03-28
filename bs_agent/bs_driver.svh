`ifndef BS_DRIVER
`define BS_DRIVER

class bs_driver extends uvm_driver #(prog_seq_item);

   // Virtual Interface
   virtual prog_if vif;
   
  
  `uvm_component_utils(bs_driver)
 
  /**
    * Default constructor.
    */
   extern function new(string name="bs_driver", uvm_component parent=null);
   
   /**
    * Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Obtains the reqs from the sequence item port and calls drv_req()
    */
   extern virtual task run_phase(uvm_phase phase);

   // drive
   virtual task drive();
    req.print();
 //   @(negedge vif.prog_clock_reg);
     @(negedge vif.clk_stim);
     vif.ccff_head   = req.ccff_head;
     vif.config_done = req.config_done;
     vif.DRIVER.gfpga_pad_GPIO_IN_drv[1:7] = req.gfpga_pad_GPIO_IN_drv[1:7];
     req.gfpga_pad_GPIO_IN_drv[0] = vif.DRIVER.gfpga_pad_GPIO_IN_drv[0];

      $display("-----------------------------------------");
   endtask : drive
 
endclass : bs_driver 
  
   function bs_driver::new(string name="bs_driver",uvm_component parent);
      super.new(name,parent);
   endfunction : new

   function void bs_driver::build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual prog_if)::get(this,"","vif",vif)) `uvm_fatal("NO_VIF",{"virtual interface must be set for :",get_full_name(),".vif"});
   endfunction:build_phase
    
   // run phase
   task bs_driver::run_phase(uvm_phase phase);
    forever begin
	seq_item_port.get_next_item(req);
	drive();
	seq_item_port.item_done();
    end
   endtask : run_phase
 

    
`endif

`ifndef BS_MONITOR
`define BS_MONITOR

class bs_monitor extends uvm_monitor;

   virtual prog_if vif;

   uvm_analysis_port #(prog_seq_item) prog_collected_port;
   prog_seq_item trans_collected;
   
  `uvm_component_utils(bs_monitor)
 
   /**
    * Default constructor.
    */
   extern function new(string name="bs_monitor", uvm_component parent=null);
   
   /**
    * Builds scoreboard port.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Monitor signals for scoreboard to be send to scoreboard.
    */
   extern virtual task run_phase(uvm_phase phase);

endclass : bs_monitor
   
    function bs_monitor::new(string name="bs_monitor",uvm_component parent);
      super.new(name,parent);
      trans_collected =new();
      prog_collected_port =new("prog_collected_port",this);
       
    endfunction // new

   function void bs_monitor::build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual prog_if)::get(this,"","vif",vif)) `uvm_fatal("NOVIF",{"virtual interface must be set for:",get_full_name(),".vif"});
   endfunction: build_phase

   task bs_monitor::run_phase(uvm_phase phase);
      forever begin
	 @(posedge vif.clk);
	 trans_collected.gfpga_pad_GPIO = vif.gfpga_pad_GPIO;
	 prog_collected_port.write(trans_collected);
      end
   endtask: run_phase
   


      

`endif

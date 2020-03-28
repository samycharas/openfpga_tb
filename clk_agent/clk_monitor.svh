`ifndef CLK_MONITOR
`define CLK_MONITOR

class clk_monitor extends uvm_monitor;

   // Virtual interface
   virtual clkrst_if vif;

   uvm_analysis_port #(clk_seq_item) item_collected_port;
   clk_seq_item trans_collected;
   
  `uvm_component_utils(clk_monitor)
  
   /**
    * Default constructor.
    */
   extern function new(string name="clk_monitor", uvm_component parent=null);
   
   /**
    * Builds scoreboard port.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Monitor signals for scoreboard to be send to scoreboard.
    */
   extern virtual task run_phase(uvm_phase phase);

endclass : clk_monitor 
 
    function clk_monitor::new(string name="clk_monitor",uvm_component parent);
      super.new(name,parent);
      trans_collected =new();
      item_collected_port =new("item_collected_port",this);
       
    endfunction // new

   function void clk_monitor::build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual clkrst_if)::get(this,"","vif",vif)) `uvm_fatal("NOVIF",{"virtual interface must be set for:",get_full_name(),".vif"});
   endfunction: build_phase

   task clk_monitor::run_phase(uvm_phase phase);
      forever begin
	 @(posedge vif.clk);
	 trans_collected.OUT = vif.OUT;
	 item_collected_port.write(trans_collected);
      end
   endtask: run_phase
   


      

`endif

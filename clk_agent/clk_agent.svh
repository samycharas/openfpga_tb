`ifndef CLK_AGENT
`define CLK_AGENT

class clk_agent extends uvm_agent;
  
  `uvm_component_utils(clk_agent)
  
  clk_driver 	m_clk_driver;
  clk_sequencer m_clk_sequencer;
  clk_monitor	m_clk_monitor;
    

   /**
    * Default constructor.
    */
   extern function new(string name="clk_agent", uvm_component parent=null);
   
   /**
    * Builds all components
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Links agent's analysis ports to sub-components'
    */
   extern virtual function void connect_phase(uvm_phase phase);


endclass

    function clk_agent::new(string name="clk_agent",uvm_component parent);
	super.new(name,parent);
    endfunction
      
    function void clk_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(get_is_active() == UVM_ACTIVE)begin
    	    m_clk_driver    =clk_driver::type_id::create("clk_driver",this);
    	    m_clk_sequencer =clk_sequencer::type_id::create("clk_sequencer",this);
	end
	 
        m_clk_monitor=clk_monitor::type_id::create("clk_monitor",this);
    endfunction:build_phase
        
    function void clk_agent::connect_phase(uvm_phase phase);
	if(get_is_active() ==UVM_ACTIVE) begin
	   m_clk_driver.seq_item_port.connect(m_clk_sequencer.seq_item_export);
	end
      
    endfunction:connect_phase


   
`endif

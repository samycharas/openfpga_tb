`ifndef BS_AGENT
`define BS_AGENT

class bs_agent extends uvm_agent;
  
  `uvm_component_utils(bs_agent)
  
  bs_driver 	m_bs_driver;
  bs_sequencer m_bs_sequencer;
  bs_monitor	m_bs_monitor;
    

   /**
    * Default constructor.
    */
   extern function new(string name="bs_agent", uvm_component parent=null);
   
   /**
    * Builds all components
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Links agent's analysis ports to sub-components'
    */
   extern virtual function void connect_phase(uvm_phase phase);


endclass

    function bs_agent::new(string name="bs_agent",uvm_component parent);
	super.new(name,parent);
    endfunction
      
    function void bs_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(get_is_active() == UVM_ACTIVE)begin
    	    m_bs_driver    =bs_driver::type_id::create("bs_driver",this);
    	    m_bs_sequencer =bs_sequencer::type_id::create("bs_sequencer",this);
	end
	 
        m_bs_monitor=bs_monitor::type_id::create("bs_monitor",this);
    endfunction:build_phase
        
    function void bs_agent::connect_phase(uvm_phase phase);
	if(get_is_active() ==UVM_ACTIVE) begin
	   m_bs_driver.seq_item_port.connect(m_bs_sequencer.seq_item_export);
	end
      
    endfunction:connect_phase


   
`endif

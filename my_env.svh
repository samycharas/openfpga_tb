`ifndef MY_ENV
`define MY_ENV

class my_env extends uvm_env;
  
   clk_agent	 m_clk_agent;
   bs_agent 	 m_bs_agent;
   my_scoreboard m_my_sb;
   
  `uvm_component_utils(my_env)

   /**
    * Default constructor.
    */
   extern function new(string name="my_env", uvm_component parent=null);
   
   /**
    * Builds all components via create_<x>()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Connects agents to scoreboard()
    */
   extern virtual function void connect_phase(uvm_phase phase);

endclass:my_env

   function my_env::new(string name="my_env",uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void my_env::build_phase(uvm_phase phase);
      super.build_phase(phase);

      m_clk_agent = clk_agent::type_id::create("clk_agent",this);
      m_bs_agent  = bs_agent::type_id::create("bs_agent",this);
      m_my_sb     = my_scoreboard::type_id::create("my_sb",this);
   endfunction:build_phase

   function void my_env::connect_phase(uvm_phase phase);
      m_clk_agent.m_clk_monitor.item_collected_port.connect(m_my_sb.item_collected_export);
      m_bs_agent.m_bs_monitor.prog_collected_port.connect(m_my_sb.prog_collected_export);
      
   endfunction:connect_phase
   


`endif

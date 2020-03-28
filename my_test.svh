`ifndef MY_TEST
`define MY_TEST

class my_test extends uvm_test;

  `uvm_component_utils(my_test)
   
  my_env      		m_my_env;
  bitstream   		m_bitstream;
  clock_sequence 	m_clock_sequence;
  stimuli     		m_stimuli;
  clock_sequence_stim 	m_clock_sequence_stim;
  

   /**
    * Default constructor.
    */
   extern function new(string name="my_test", uvm_component parent=null);
   
   /**
    * Builds all components via create_<x>()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Launch sequences
    */
   extern task run_phase(uvm_phase phase);

endclass : my_test
 
   function my_test::new(string name = "my_test",uvm_component parent=null);
      super.new(name,parent);
   endfunction : new

   function void my_test::build_phase(uvm_phase phase);
      super.build_phase(phase);
      m_my_env			=my_env::type_id::create("env",this);
      m_clock_sequence		=clock_sequence::type_id::create("seq");
      m_bitstream		=bitstream::type_id::create("bitstream");
      m_stimuli			=stimuli::type_id::create("stimuli");
      m_clock_sequence_stim	=clock_sequence_stim::type_id::create("clock");
   endfunction:build_phase

   task my_test::run_phase(uvm_phase phase);
      phase.raise_objection(this);
      fork // first fork is fpga programing
      begin
      m_clock_sequence.start(m_my_env.m_clk_agent.m_clk_sequencer);
      end
      begin                      
      m_bitstream.start(m_my_env.m_bs_agent.m_bs_sequencer);	 
      end
      join_any
      disable fork;

      fork
      begin
      m_clock_sequence_stim.start(m_my_env.m_clk_agent.m_clk_sequencer);
      end
      begin
      m_stimuli.start(m_my_env.m_bs_agent.m_bs_sequencer);
      end
      join_any
      phase.drop_objection(this);
   endtask:run_phase
  
    
`endif

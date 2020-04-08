`ifndef stimuli_ENV
`define stimuli_ENV

class stimuli_env extends uvm_env;
   stimuli_agent	m_stimuli_agent;
   stimuli_scoreboard   m_stimuli_scoreboard;
   
  `uvm_component_utils(stimuli_env)

   function new(string name,uvm_component parent);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      m_stimuli_agent     = stimuli_agent::type_id::create("m_stimuli_agent",this);
      m_stimuli_scoreboard= stimuli_scoreboard::type_id::create("m_stimuli_scoreboard",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      
   endfunction:connect_phase
   
endclass

`endif

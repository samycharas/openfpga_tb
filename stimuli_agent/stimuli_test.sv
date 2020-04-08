`ifndef stimuli_BASE_TEST
`define stimuli_BASE_TEST

class stimuli_base_test extends uvm_test;

   `uvm_component_utils(stimuli_base_test)

   stimuli_env m_stimuli_env;
// Add sequences handle

   function new(string name ="", uvm_component parent);
	super.new(name,parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	m_stimuli_env=stimuli_env::type_id::create("stimuli_env",this);
// Build sequences

   endfunction:build_phase

   task run_phase(uvm_phase phase);
	phase.raise_objection(this);
// Launch sequences

	phase.drop_objection(this);
   endtask:run_phase

endclass:stimuli_base_test;

`endif


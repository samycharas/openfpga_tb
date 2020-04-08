`ifndef stimuli_SCOREBOARD
`define stimuli_SCOREBOARD



class stimuli_scoreboard extends uvm_scoreboard;
        
   
   `uvm_component_utils(stimuli_scoreboard)


function new(string name="", uvm_component parent);  
   super.new(name, parent);  
endfunction : new


function void build_phase(uvm_phase phase);  
   super.build_phase(phase);
endfunction : build_phase



  virtual task run_phase(uvm_phase phase);

 
  endtask : run_phase

endclass

`endif



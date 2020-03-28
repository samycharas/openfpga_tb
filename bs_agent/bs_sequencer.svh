`ifndef BS_SEQUENCER
`define BS_SEQUENCER

class bs_sequencer extends uvm_sequencer#(prog_seq_item);
  
  `uvm_component_utils(bs_sequencer)
    
   extern function new(string name="bs_sequencer",uvm_component parent=null);

endclass

function bs_sequencer::new(string name="bs_sequencer",uvm_component parent=null);
      super.new(name,parent);
endfunction   
   
`endif

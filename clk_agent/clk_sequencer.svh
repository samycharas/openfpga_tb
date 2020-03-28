`ifndef CLK_SEQUENCER
`define CLK_SEQUENCER

class clk_sequencer extends uvm_sequencer#(clk_seq_item);
  
  `uvm_component_utils(clk_sequencer)
    
   /**
    * Default constructor.
    */
   extern function new(string name="clk_sequencer", uvm_component parent=null);

endclass : clk_sequencer

function clk_sequencer::new(string name="clk_sequencer",uvm_component parent);
      super.new(name,parent);
    endfunction

  
   
`endif

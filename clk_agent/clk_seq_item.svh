`ifndef CLK_SEQ_ITEM
`define CLK_SEQ_ITEM

class clk_seq_item extends uvm_sequence_item;
 
   rand bit [0:0] clk ;
   rand bit [0:0] clk_stim;
   rand bit [0:0] prog_clock_reg;
   bit	    [0:0] clk_uvm;
   rand bit [0:0] Reset;
   rand bit [0:0] pReset ;
   rand bit [0:0] Test_en ;
   bit      [0:0] OUT;
   
   
   
  //Utility and Field macros
  `uvm_object_utils_begin(clk_seq_item)
    `uvm_field_int(clk,UVM_ALL_ON)
    `uvm_field_int(prog_clock_reg,UVM_ALL_ON)
    `uvm_field_int(clk_stim,UVM_ALL_ON)
    `uvm_field_int(clk_uvm,UVM_ALL_ON)
    `uvm_field_int(Reset,UVM_ALL_ON)
    `uvm_field_int(pReset,UVM_ALL_ON)
    `uvm_field_int(Test_en,UVM_ALL_ON)
    `uvm_field_int(OUT,UVM_ALL_ON)
  `uvm_object_utils_end
   
   /**
    * Default constructor.
    */
   extern function new(string name="clk_seq_item");

endclass : clk_seq_item


  function clk_seq_item::new(string name = "clk_seq_item");
    super.new(name);
  endfunction
   


`endif

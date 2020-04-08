`ifndef BS_SEQ_ITEM
`define BS_SEQ_ITEM

class bs_seq_item extends uvm_sequence_item;

   rand bit 		config_done;
   rand bit 		ccff_head;
   bit      [0:0]	ccff_tail;

  //Utility and Field macros
  `uvm_object_utils_begin(bs_seq_item)
    `uvm_field_int(config_done,UVM_ALL_ON)
    `uvm_field_int(ccff_head,UVM_ALL_ON)
    `uvm_field_int(ccff_tail,UVM_ALL_ON)
  `uvm_object_utils_end
   
   /**
    * Default constructor.
    */
   extern function new(string name="bs_seq_item"); 
 

endclass : bs_seq_item


function bs_seq_item::new(string name = "bs_seq_item");

    super.new(name);

endfunction


`endif // BS_SEQ_ITEM

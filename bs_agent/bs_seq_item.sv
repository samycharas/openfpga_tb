`ifndef BS_SEQ_ITEM
`define BS_SEQ_ITEM

class bs_seq_item extends uvm_sequence_item;

   rand bit 		config_done;
   rand bit 		ccff_head;
   rand bit [0:7] 	gfpga_pad_GPIO_IN_drv;
   bit      [0:0]	ccff_tail;
   bit 	    [0:7]	gfpga_pad_GPIO;
   
  //Utility and Field macros
  `uvm_object_utils_begin(bs_seq_item)
    `uvm_field_int(config_done,UVM_ALL_ON)
    `uvm_field_int(ccff_head,UVM_ALL_ON)
    `uvm_field_int(ccff_tail,UVM_ALL_ON)
    `uvm_field_int(gfpga_pad_GPIO_IN_drv,UVM_ALL_ON)
    `uvm_field_int(gfpga_pad_GPIO,UVM_ALL_ON)
  `uvm_object_utils_end
   
   /**
    * Default constructor.
    */
   extern function new(string name="bs_seq_item"); 
 
   constraint never_used { gfpga_pad_GPIO_IN_drv[1:6] == 8'b000000;};
   constraint unused 	 { gfpga_pad_GPIO_IN_drv[1:7] == 8'b000000;} 

endclass : bs_seq_item


  function bs_seq_item::new(string name = "bs_seq_item");
    super.new(name);
  endfunction


`endif

`ifndef RESET_AFTER_BS
`define RESET_AFTER_BS

class reset_after_bs extends clknrst_base_seq;
   
  `uvm_object_utils(reset_after_bs)

   /**
    * Default constructor.
    */
   extern function new(string name="reset_after_bs");
   /**
    * Reset to be send to DUT
    */
   extern virtual task body(); 
  
endclass : reset_after_bs


function reset_after_bs::new(string name = "reset_after_bs");

    super.new(name);

endfunction
   
task reset_after_bs::body();

     	`uvm_do_with(req,{req.pReset == 1'b0;
			  req.Reset  == 1'b0;
	})
 
endtask // body

`endif // RESET_AFTER_BS

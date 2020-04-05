`ifndef "STIMULI"
`define "STIMULI"

class stimuli extends bs_base_seq;

   `uvm_object_utils(stimuli)

   /**
    * Default constructor.
    */
   extern function new(string name="stimuli");
   /**
    * Sequence body
    */
   extern virtual task body();

endclass : stimuli


function stimuli::new(string name = "stimuli");

	super.new(name);

endfunction // body

task stimuli::body();

     `uvm_info("Stimuli", $sformatf("stimuli sequence started"), UVM_LOW);     
     repeat(100)
     begin
			`uvm_create(req)
			req.unused.constraint_mode(0); // Overriding constraints
			start_item(req);
			assert(req.randomize() with  {req.ccff_head == 1'b1; req.config_done == 1'b1;});
			finish_item(req);

     end

     `uvm_info("Stimfuli", $sformatf("stimuli sequence stopped"), UVM_LOW);
 
endtask // body
   

`endif

`ifndef "CLK_SEQUENCE"
`define "CLK_SEQUENCE"

class clock_sequence extends uvm_sequence#(clk_seq_item);
   
   
  `uvm_object_utils(clock_sequence)
   `uvm_declare_p_sequencer(clk_sequencer)
  //Constructor
  function new(string name = "my_sequence");
    super.new(name);
  endfunction
   
  virtual task body();

     begin
	`uvm_do_with(req,{req.pReset == 1'b1;
			  req.Reset  == 1'b1;
			  req.Test_en== 1'b0;
			  req.clk    == 1'b0;
			  req.prog_clock_reg == 1'b0;
			  req.clk_stim == 1'b0;})
     #100.0000076
	`uvm_do_with(req,{req.pReset == 1'b0;
			  req.Reset  == 1'b1;
			  req.Test_en== 1'b0;
			  req.clk    == 1'b0;
			  req.prog_clock_reg == 1'b0;
			  req.clk_stim == 1'b0;})
     end

     forever begin
     	`uvm_do_with(req,{req.pReset == 1'b0;
			  req.Reset  == 1'b1;
			  req.Test_en== 1'b0;
			  req.clk    == 1'b0;
			  req.prog_clock_reg == 1'b1;
			  req.clk_stim == 1'b1;})
       #50.0000038
     	`uvm_do_with(req,{req.pReset == 1'b0;
			  req.Reset  == 1'b1;
			  req.Test_en== 1'b0;
			  req.clk    == 1'b0;
			  req.prog_clock_reg == 1'b0;
			  req.clk_stim == 1'b0;})
     end
 
  endtask
   
endclass // my_sequence
 
class clock_sequence_stim extends uvm_sequence#(clk_seq_item);
   
   
  `uvm_object_utils(clock_sequence_stim)
   `uvm_declare_p_sequencer(clk_sequencer)
  //Constructor
  function new(string name = "my_sequence");
    super.new(name);
  endfunction
   
  virtual task body();

     	`uvm_do_with(req,{req.pReset == 1'b0;
			  req.Reset  == 1'b0;
			  req.Test_en== 1'b0;
			  req.clk    == 1'b0;
			  req.prog_clock_reg == 1'b0;
			  req.clk_stim == 1'b1;})

     forever begin
     	`uvm_do_with(req,{req.pReset == 1'b0;
			  req.Reset  == 1'b0;
			  req.Test_en== 1'b0;
			  req.clk    == 1'b1;
			  req.prog_clock_reg == 1'b0;
			  req.clk_stim == 1'b1;})
       #50.0000038
     	`uvm_do_with(req,{req.pReset == 1'b0;
			  req.Reset  == 1'b0;
			  req.Test_en== 1'b0;
			  req.clk    == 1'b0;
			  req.prog_clock_reg == 1'b0;
			  req.clk_stim == 1'b0;})
     end
 
  endtask
   
endclass // my_sequence
  
class stimuli extends uvm_sequence#(prog_seq_item);

   `uvm_object_utils(stimuli)
   `uvm_declare_p_sequencer(bs_sequencer)
  //Constructor
  function new(string name = "stimuli");
    super.new(name);
  endfunction
   
  virtual task body();
     
     repeat(100)
     begin
			`uvm_create(req)
			req.unused.constraint_mode(0); // Overriding constraints
			start_item(req);
			assert(req.randomize() with  {req.ccff_head == 1'b1; req.config_done == 1'b1;});
			finish_item(req);

     end

     `uvm_info("debug", $sformatf("debugpurpose"), UVM_LOW);
 
  endtask
   
endclass // my_sequence   

`endif


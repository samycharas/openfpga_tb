`ifndef "BITSTREAM_SEQUENCE"
`define "BITSTREAM_SEQUENCE"

class bitstream extends uvm_sequence#(prog_seq_item);
   `uvm_object_utils(bitstream)
   `uvm_declare_p_sequencer(bs_sequencer)
   
   
   function new(string name = "fpga_prog");
      super.new(name);
   endfunction // new

   virtual task body();
     `uvm_info("Programing", $sformatf("Starting programming fpga"), UVM_LOW);
      low(215-185); // c'était 215 - 184 je réduis de 1 après observation sur les waveform
      simple();
      low(1);
      double();
      low(550-219);     
      simple();
      low(554-551);
      double();
      low(559-557); // un low de moins parce que y'en a un dans alternate
      alternate();
      low(634-592);
      double_75(9);
      low(1444-1236);
      double();
      low(1586-1446);
      double();
      simple();
      low(2332-1589);
      double_75(10);
      // we're at 3008
      low(4145-3009);
      double_75(10); 
      low(5912-4822);
      double_75(10); 
      low(7321-6589);    
      simple();
      low(7548-7322);
      simple();
      low(7781-7549);
      simple();
      low(7891-7782);
      simple();      
      low(7893-7892);
      simple();
      low(7958-7894);
      double();    
      low(7980-7960);    
      simple();
      low(8007-7981);
      double();
      low(8396-8009);
      simple();
      low(8641-8397);
      double();
      double();
// add config done
 
      `uvm_do_with(req,{req.config_done == 1'b1;
			req.ccff_head   == 1'b1;})
   endtask // body
   


   // Sequences to reduce hardcoding
   virtual task double_75(int z);

	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
      repeat (z-1)
	begin
	 repeat (73)
	   begin
	 	`uvm_do_with(req,{req.ccff_head   == 1'b0;
	                  req.config_done == 1'b0;})        
	   end
	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})

       end
      
   endtask // double_75

   virtual task double();
	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
   endtask // double

   virtual task simple();
	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
   endtask // simple

   virtual task alternate();
       repeat(17)
       begin
	 `uvm_do_with(req,{req.ccff_head   == 1'b0;
	                   req.config_done == 1'b0;})
      	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
       end
   endtask // alternate
   
      
   virtual task low(int x);
     repeat(x)
       begin
	 `uvm_do_with(req,{req.ccff_head   == 1'b0;
	                   req.config_done == 1'b0;})
       end
   endtask // low
   
endclass // init


`endif

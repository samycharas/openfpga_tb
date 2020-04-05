`ifndef "BITSTREAM"
`define "BITSTREAM"

  
// Hardcoding bitstream
class bitstream extends bs_base_seq;
   `uvm_object_utils(bitstream)
   
   /**
    * Default constructor.
    */
   extern function new(string name="bitstream");
   /**
    * Sequence body
    */
   extern virtual task body();
   /**
    * Sequence to reduce hardcoding
    */
   extern virtual task double_75(int z)	;
   extern virtual task double()		;
   extern virtual task simple()		;
   extern virtual task alternate()	;
   extern virtual task low(int x)	;
endclass : bitstream
   
function bitstream::new(string name = "bitstream");

      super.new(name);

endfunction // new

task bitstream::body();
     `uvm_info("Programing", $sformatf("Starting bsramming fpga"), UVM_LOW);
      low(215-185);
      simple();
      low(1);
      double();
      low(550-219);     
      simple();
      low(554-551);
      double();
      low(559-557);
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
 
      `uvm_do_with(req,{req.config_done == 1'b1;
			req.ccff_head   == 1'b1;})
endtask // body
   


   // Sequences to reduce hardcoding
task bitstream::double_75(int z);

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

task bitstream::double();
	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
endtask // double

task bitstream::simple();
	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
endtask // simple

task bitstream::alternate();
       repeat(17)
       begin
	 `uvm_do_with(req,{req.ccff_head   == 1'b0;
	                   req.config_done == 1'b0;})
      	 `uvm_do_with(req,{req.ccff_head   == 1'b1;
	                   req.config_done == 1'b0;})
       end
endtask // alternate
   
      
task bitstream::low(int x);
     repeat(x)
       begin
	 `uvm_do_with(req,{req.ccff_head   == 1'b0;
	                   req.config_done == 1'b0;})
       end
endtask // low
   

`endif // BITSTREAM

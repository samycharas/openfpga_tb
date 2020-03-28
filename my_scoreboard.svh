`ifndef MY_SCOREBOARD
`define MY_SCOREBOARD

//Declaring two ports
`uvm_analysis_imp_decl(_dut)
`uvm_analysis_imp_decl(_ref)

class my_scoreboard extends uvm_scoreboard;

   `uvm_component_utils(my_scoreboard)
   uvm_analysis_imp_dut#(prog_seq_item,my_scoreboard)	prog_collected_export;
   uvm_analysis_imp_ref#(clk_seq_item,my_scoreboard)	item_collected_export;
   
   clk_seq_item	  pkt_ref_qu[$];
   prog_seq_item  pkt_dut_qu[$];

   /**
    * Default constructor.
    */
   extern function new(string name="my_scoreboard", uvm_component parent=null);
   
   /**
    * Builds all components via create_<x>()
    */
   extern function void build_phase(uvm_phase phase);
  /**
    * Receive DUT Pkt
    */
   extern virtual function void write_dut(prog_seq_item trans_collected);
   /**
    * Receive Ref Pkt
    */
   extern virtual function void write_ref(clk_seq_item trans_collected);
   /**
    * Compare DUT Output to reference model
    */
   extern virtual task run_phase(uvm_phase phase);



endclass : my_scoreboard

   function my_scoreboard::new(string name="my_scoreboard", uvm_component parent=null);
      super.new(name,parent);
   endfunction : new

   function void my_scoreboard::build_phase(uvm_phase phase);
      super.build_phase(phase);
      item_collected_export = new("item_collected_export",this);
      prog_collected_export = new("prog_collected_export",this);
      
   endfunction: build_phase


  function void my_scoreboard::write_dut(prog_seq_item trans_collected); // Print the top item in the queue
    `uvm_info(get_type_name(),$sformatf(" Value of sequence item in SCOREBOARD \n"),UVM_LOW)
    trans_collected.print();
    pkt_dut_qu.push_back(trans_collected);
  endfunction:write_dut
  
  function void my_scoreboard::write_ref(clk_seq_item trans_collected); // Print the top item in the queue
    `uvm_info(get_type_name(),$sformatf(" Value of sequence item in SCOREBOARD \n"),UVM_LOW)
    trans_collected.print();
    pkt_ref_qu.push_back(trans_collected);
  endfunction:write_ref


  task my_scoreboard::run_phase (uvm_phase phase);

    // Handle to transactions
    clk_seq_item  ref_seq;
    prog_seq_item dut_seq;
    forever begin
      wait(pkt_dut_qu.size()>0 && pkt_ref_qu.size()>0); // If the queue isn't empty
      dut_seq=pkt_dut_qu.pop_front(); 			    // Pick the top transaction coming out of our DUT
      ref_seq=pkt_ref_qu.pop_front(); 		    // Pick the top transaction coming out of the reference model
      if(dut_seq.gfpga_pad_GPIO[0]==ref_seq.OUT)
	begin

	  `uvm_info("my_scoreboard",$sformatf("Test Passed"),UVM_LOW)
	end
      else
	begin
	  `uvm_info("my_scoreboard",$sformatf("Test Failed"),UVM_LOW)	
          `uvm_info(get_type_name(),$sformatf(" Expected Value = %0d", ref_seq.OUT),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf(" Actual Value   = %0d", dut_seq.gfpga_pad_GPIO[0]),UVM_LOW)    
	end
  end	    
		    

  endtask: run_phase


`endif
      

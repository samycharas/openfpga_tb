// Reference model class to check the 
// inverter function of OpenFPGA

`ifndef REFERENCE_MODEL
`define REFERENCE_MODEL

//`include "inv.v"

class reference_model extends uvm_component;

   // Objects
   openfpga_env_cfg    	m_openfpga_env_cfg;
   openfpga_env_cntxt  	m_openfpga_env_cntxt;

//   uvm_analysis_imp	#(bs_seq_item,reference_model) port;
//   uvm_analysis_port	#(bs_seq_item) ap;
int i = 0;
//   bs_seq_item       	pkt_qu[$];
   uvm_analysis_imp	#(stimuli_seq_item,reference_model) port;
   uvm_analysis_port	#(stimuli_seq_item) ap;

   stimuli_seq_item    	pkt_qu[$];

   `uvm_component_utils_begin(reference_model)
      `uvm_field_object(m_openfpga_env_cfg  , UVM_DEFAULT)
      `uvm_field_object(m_openfpga_env_cntxt, UVM_DEFAULT)
   `uvm_component_utils_end

   /**
    * Default constructor.
    */
   extern function new(string name="reference_model", uvm_component parent=null);
   /**
    * Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   /**
    * Connect both reference model ports to transactions
    */
   extern virtual function void connect_phase(uvm_phase phase);
  /**
    * Receive monitor Pkt
    */
   extern virtual function void write(stimuli_seq_item trans_collected);
   /**
    * Obtains the reqs from the sequence item port and calls drv_req()
    */
   extern virtual task run_phase(uvm_phase phase);

endclass : reference_model


function reference_model::new(string name="reference_model", uvm_component parent=null);

	super.new(name,parent);

endfunction : new



function void reference_model::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(openfpga_env_cfg)::get(this, "", "cfg", m_openfpga_env_cfg));
   if (!m_openfpga_env_cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", m_openfpga_env_cfg.sprint()), UVM_DEBUG)
   end
   
   void'(uvm_config_db#(openfpga_env_cntxt)::get(this, "", "cntxt", m_openfpga_env_cntxt));
      if (!m_openfpga_env_cntxt) begin
         `uvm_fatal("CNTXT", "Context handle is null")
      end

      port = new("port", this);
      ap = new("ap", this);
endfunction : build_phase

function void reference_model::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
   

endfunction : connect_phase

function void reference_model::write(stimuli_seq_item trans_collected); // Print the top item in the queue

    `uvm_info(get_type_name(),$sformatf(" Value of sequence item in reference model \n"),UVM_LOW)
    trans_collected.print();
    pkt_qu.push_back(trans_collected);

endfunction:write

task reference_model::run_phase(uvm_phase phase);

   stimuli_seq_item new_tr;
   super.run_phase(phase);
   forever begin
     wait(pkt_qu.size()>0); 
     i = i+1; // debuging 
      new_tr=pkt_qu.pop_front();

   case (m_openfpga_env_cfg.m_which_bitstream)
	INV:
		begin
 //    			 new_tr.OUT = ~new_tr.gfpga_pad_GPIO_IN_drv[7]; // INV function to be implemented here
		new_tr.OUT = inv_pkg::inv(new_tr.gfpga_pad_GPIO_IN_drv[7]); // working
		end
	NOT_INV:
		begin
      			 new_tr.OUT = new_tr.gfpga_pad_GPIO_IN_drv[7]; // Another benchmark function to be implemented here
		end

  endcase
      `uvm_info("my_model", $sformatf("get one transaction, copy and print it: "), UVM_LOW)
      new_tr.print();
      ap.write(new_tr);      
   end
endtask : run_phase



`endif // REFERENCE_MODEL

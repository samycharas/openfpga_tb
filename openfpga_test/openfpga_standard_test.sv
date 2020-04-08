`ifndef OPENFPGA_STANDARD_TEST
`define OPENFPGA_STANDARD_TEST

class openfpga_standard_test extends openfpga_base_test;

    
   `uvm_component_utils(openfpga_standard_test)  

  constraint openfpga_env_cfg_cons {
      m_openfpga_env_cfg.enabled         == 1;
      m_openfpga_env_cfg.is_active       == UVM_ACTIVE;
      m_openfpga_env_cfg.trn_log_enabled == 1;
      m_openfpga_env_cfg.m_which_bitstream == INV; // This doesn't work
   }

   /**
    * Default constructor.
    */
   extern function new(string name="openfpga_base_test", uvm_component parent=null);
   
   /**
    * Launch sequences
    */
   extern task run_phase(uvm_phase phase);

endclass : openfpga_standard_test

function openfpga_standard_test::new(string name = "openfpga_base_test",uvm_component parent=null);

      super.new(name,parent);

endfunction : new

task openfpga_standard_test::run_phase(uvm_phase phase);
      phase.raise_objection(this);

      fork
      	m_openfpga_env_cntxt.m_clknrst_cntxt.vif.start_bs_clk();
      	begin
      		m_reset_at_start.start(m_openfpga_env.m_clknrst_agent.m_clknrst_sqr);
      	end
      	begin                      
     		m_bitstream.start(m_openfpga_env.m_bs_agent.m_bs_sqr);	 
      	end
      join
      m_openfpga_env_cntxt.m_clknrst_cntxt.vif.stop_bs_clk();
      begin
     	 m_reset_after_bs.start(m_openfpga_env.m_clknrst_agent.m_clknrst_sqr);
      end
      fork
	begin
      	m_openfpga_env_cntxt.m_clknrst_cntxt.vif.start_clk();
	end
	begin
      	m_openfpga_env_cntxt.m_clknrst_cntxt.vif.set_period_bs(5);
	end
      join
      begin
	m_stimuli_standard_seq.start(m_openfpga_env.m_stimuli_agent.m_stimuli_sqr);
      end
      phase.drop_objection(this);
endtask:run_phase
  
    
`endif // OPENFPGA_BASE_TEST

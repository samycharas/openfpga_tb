`ifndef MY_TESTBENCH_PKG
`define MY_TESTBENCH_PKG

package my_testbench_pkg;
  import uvm_pkg::*;
 
  `include "clk_agent/clk_seq_item.svh"
  `include "bs_agent/bs_seq_item.svh"
  `include "clk_agent/clk_sequencer.svh"
  `include "bs_agent/bs_sequencer.svh"
  `include "clk_agent/seq_lib/clk_sequence.svh"
  `include "bs_agent/seq_lib/bitstream_sequence.svh"
  `include "my_defines.svh"
   
  `include "clk_agent/clk_driver.svh" // Clock Agent
  `include "clk_agent/clk_monitor.svh"
  `include "clk_agent/clk_agent.svh"
   
  `include "bs_agent/bs_driver.svh" // Bitstream Agent
  `include "bs_agent/bs_monitor.svh"
  `include "bs_agent/bs_agent.svh"
   
  `include "my_scoreboard.svh"
  `include "my_env.svh"
  
  `include "my_test.svh"
  
endpackage : my_testbench_pkg

`endif

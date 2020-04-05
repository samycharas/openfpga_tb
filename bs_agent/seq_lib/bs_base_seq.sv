// 
// Copyright 2020 OpenHW Group
// Copyright 2020 Datum Technology Corporation
// 
// Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     https://solderpad.org/licenses/
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// 

`ifndef "BS_BASE_SEQ"
`define "BS_BASE_SEQ"


class bs_base_seq extends uvm_sequence#(
   .REQ(bs_seq_item),
   .RSP(bs_seq_item)
);

   `uvm_object_utils(bs_base_seq)
   `uvm_declare_p_sequencer(bs_sqr)

   /**
    * Default constructor.
    */
   extern function new(string name="bs_base_seq");

endclass : bs_base_seq

function bs_base_seq::new(string name = "bs_base_seq");

    super.new(name);

endfunction
  

`endif // BS_BASE_SEQ

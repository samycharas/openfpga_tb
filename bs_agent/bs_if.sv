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

`ifndef BS_IF
`define BS_IF

`timescale 1ns / 1ps

interface bs_if(input clk_uvm, clk);

   logic       ccff_head;
   logic       config_done; // deprecated
   logic [0:0] ccff_tail;
   wire  [0:7] gfpga_pad_GPIO;
   logic [0:7] gfpga_pad_GPIO_IN_drv = 8'h00; // Can't connect logic to INOUT
   assign gfpga_pad_GPIO[1:7] = gfpga_pad_GPIO_IN_drv[1:7];
   modport DRIVER (inout gfpga_pad_GPIO); 
 


endinterface:bs_if

`endif // BS_IF

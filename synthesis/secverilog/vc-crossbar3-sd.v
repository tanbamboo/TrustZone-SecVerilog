//========================================================================
// Verilog Components: Crossbars
//========================================================================

`ifndef VC_CROSSBAR3_SAMEDOMAIN_V
`define VC_CROSSBARS_SAMEDOMAIN_V

`include "vc-mux3-sd.v"

//------------------------------------------------------------------------
// 3 input, 3 output crossbar
//------------------------------------------------------------------------

module vc_Crossbar3_sd
#(
  parameter p_nbits = 32
)
(
  
  input	 [1:0]			 				domain,

  input  [p_nbits-1:0]   	in0,
  input  [p_nbits-1:0]   	in1,
  input  [p_nbits-1:0]   	in2,

  input  [1:0]           				sel0,
  input  [1:0]           				sel1,
  input  [1:0]           				sel2,

  output [p_nbits-1:0]   	out0,
  output [p_nbits-1:0]   	out1,
  output [p_nbits-1:0]   	out2
);

  vc_Mux3#(p_nbits) out0_mux
  (
    .in0 (in0),
    .in1 (in1),
    .in2 (in2),
	.domain(domain),
    .sel (sel0),
    .out (out0)
  );

  vc_Mux3#(p_nbits) out1_mux
  (
    .in0 (in0),
    .in1 (in1),
    .in2 (in2),
	.domain(domain),
    .sel (sel1),
    .out (out1)
  );

  vc_Mux3#(p_nbits) out2_mux
  (
    .in0 (in0),
    .in1 (in1),
    .in2 (in2),
	.domain(domain),
    .sel (sel2),
    .out (out2)
  );

endmodule

`endif /* VC_CROSSBARS_V */

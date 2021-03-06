//========================================================================
// Processor Access Control Module 
//========================================================================

`ifndef PLAB5_MCORE_PROC_ACC_V
`define PLAB5_MCORE_PROC_ACC_V

`include "vc-mem-msgs.v"

module plab5_mcore_proc_resp_acc
#(
	parameter p_opaque_nbits = 8,   // mem message opaque field num bits
	parameter p_addr_nbits	 = 32,  // mem message address num bits
	parameter p_data_nbits	 = 32,  // mem message data num bits

	// shorted names for message type, not to be set from outside the module
	parameter o = p_opaque_nbits,
	parameter a = p_addr_nbits,
	parameter d = p_data_nbits,

	// Local constants not meant to be set from outside the module
	parameter resp_nbits  = `VC_MEM_RESP_MSG_NBITS(o,d)
)
(
	input						 clk,

	// response security level
	input						 resp_sec_level,
	// processor security level
	input						 proc_sec_level,

	// inputs from network
	input						 net_resp_val,
	output reg					 net_resp_rdy,
	input	   [resp_nbits-1:0]  net_resp_msg,
	input						net_resp_fail,

	// output to processor
	output reg					 proc_resp_val,
	input						 proc_resp_rdy,
	output reg [resp_nbits-1:0]	 proc_resp_msg,
	output reg					proc_resp_fail
);

	always @(*) begin
		// if response security level is not stable, we just disable the
		// transmitting path
		/* if ( resp_sec_level === 1'bx ) begin	
			proc_resp_val = net_resp_val;
			net_resp_rdy  = proc_resp_rdy;
			proc_resp_msg = 'hx;
		end*/

		// if response security level is less than or euqal to processor 
		// security level, we pass response data to the processor
	    //else if ( resp_sec_level <= proc_sec_level ) begin
        if ( proc_sec_level == resp_sec_level) begin
			proc_resp_val = net_resp_val;
			net_resp_rdy  = proc_resp_rdy;
			proc_resp_msg = net_resp_msg;
			proc_resp_fail = net_resp_fail;
		end

		// if response secruity level is higehr than processor security
		// level, we drop the data
		else if ( resp_sec_level == 1'b0 &&  proc_sec_level == 1'b1 ) begin
			proc_resp_val = net_resp_val;
			net_resp_rdy  = proc_resp_rdy;
			proc_resp_msg = net_resp_msg;
			proc_resp_fail = net_resp_fail;
		end
	end
endmodule

`endif /* PLAB5_MCORE_PROC_ACC_V */

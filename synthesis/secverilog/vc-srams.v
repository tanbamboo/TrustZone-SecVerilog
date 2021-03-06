//========================================================================
// Verilog Components: SRAMs
//========================================================================

`ifndef VC_SRAMS_V
`define VC_SRAMS_V

//------------------------------------------------------------------------
// 1rw Combinational SRAM
//------------------------------------------------------------------------

module vc_CombinationalSRAM_1rw
#(
  parameter p_data_nbits  = 1,
  parameter p_num_entries = 2,

  // Local constants not meant to be set from outside the module
  parameter c_addr_nbits  = $clog2(p_num_entries),
  parameter c_data_nbytes = (p_data_nbits+7)/8 // $ceil(p_data_nbits/8)
)(
  input                          clk,
  input                          reset,

  input                          in_domain,
  // Read port (combinational read)

  input                          read_en,
  input  [c_addr_nbits-1:0]      read_addr,
  output [p_data_nbits-1:0]      read_data,
  output  reg                    out_domain,

  // Write port (sampled on the rising clock edge)

  input                          write_en,
  input  [c_data_nbytes-1:0]     write_byte_en,
  input  [c_addr_nbits-1:0]      write_addr,
  input  [p_data_nbits-1:0]      write_data
);

  reg [p_data_nbits-1:0]  mem[p_num_entries-1:0];
  reg                     domain[p_num_entries-1:0];

  // Combinational read. We ensure the read data is all X's if we are
  // doing a write because we are modeling an SRAM with a single
  // read/write port (i.e., not a dual ported SRAM). We also ensure the
  // read data is all X's if the read is not enable at all to avoid
  // (potentially) incorrectly assuming the SRAM latches the read data.

  reg   [p_data_nbits-1:0] read_data;
  always @(*) begin
    if ( read_en ) begin
      read_data = mem[read_addr];
      out_domain = domain[read_addr];
    end
    else
      read_data = 'hx;
  end

  // Inspired by http://www.xilinx.com/support/documentation/sw_manuals/xilinx11/xst.pdf, page 159

  genvar i;
  generate
    for ( i = 0; i < c_data_nbytes; i = i + 1 )
    begin : test
      always @( posedge clk ) begin
        if ( write_en && write_byte_en[i] )
          mem[write_addr][ (i+1)*8-1 : i*8 ] <= write_data[ (i+1)*8-1 : i*8 ];
      end
    end
  endgenerate

endmodule

//------------------------------------------------------------------------
// 1rw Synchronous SRAM
//------------------------------------------------------------------------

module vc_SynchronousSRAM_1rw
#(
  parameter p_data_nbits  = 1,
  parameter p_num_entries = 2,

  // Local constants not meant to be set from outside the module
  parameter c_addr_nbits  = $clog2(p_num_entries),
  parameter c_data_nbytes = (p_data_nbits+7)/8 // $ceil(p_data_nbits/8)
)(
  input                     clk,
  input                     reset,

  // Read port (synchronous read)

  input                     read_en,
  input  [c_addr_nbits-1:0] read_addr,
  output [p_data_nbits-1:0] read_data,

  // Write port (sampled on the rising clock edge)

  input                     write_en,
  input [c_data_nbytes-1:0] write_byte_en,
  input  [c_addr_nbits-1:0] write_addr,
  input  [p_data_nbits-1:0] write_data
);

  reg [p_data_nbits-1:0] mem[p_num_entries-1:0];

  // Combinational read. We ensure the read data is all X's if we are
  // doing a write because we are modeling an SRAM with a single
  // read/write port (i.e., not a dual ported SRAM). We also ensure the
  // read data is all X's if the read is not enable at all to avoid
  // (potentially) incorrectly assuming the SRAM latches the read data.

  reg [c_addr_nbits-1:0] read_data;
  always @( posedge clk ) begin
    if ( read_en )
      read_data <= mem[read_addr];
    else
      read_data <= 'hx;
  end

  // Inspired by http://www.xilinx.com/support/documentation/sw_manuals/xilinx11/xst.pdf, page 159

  genvar i;
  generate
    for ( i = 0; i < c_data_nbytes; i = i + 1 )
    begin : test
      always @( posedge clk ) begin
        if ( write_en && write_byte_en[i] )
          mem[write_addr][ (i+1)*8-1 : i*8 ] <= write_data[ (i+1)*8-1 : i*8 ];
      end
    end
  endgenerate

endmodule

`endif /* VC_SRAMS_V */


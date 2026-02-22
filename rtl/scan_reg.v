module scan_reg #(
    parameter integer WIDTH = 4,
    parameter integer INJECT_FAULT = 4,
    parameter integer FAULT_BIT = 0,
    parameter integer FAULT_TYPE = 0
) (
    input  [WIDTH-1:0] data_in,
    input              clk,
    input              rstn,
    input              scan_en,
    input              scan_in,
    output             scan_out,
    output [WIDTH-1:0] data_out
);
  wire [WIDTH-1:0] data_out_internal;

  scan_dff ff0 (
      .d(data_in[0]),
      .scan_in(scan_in),
      .clk(clk),
      .rstn(rstn),
      .scan_en(scan_en),
      .q(data_out_internal[0])
  );

  scan_dff ff1 (
      .d(data_in[1]),
      .scan_in(data_out_internal[0]),
      .clk(clk),
      .rstn(rstn),
      .scan_en(scan_en),
      .q(data_out_internal[1])
  );

  scan_dff ff2 (
      .d(data_in[2]),
      .scan_in(data_out_internal[1]),
      .clk(clk),
      .rstn(rstn),
      .scan_en(scan_en),
      .q(data_out_internal[2])
  );

  scan_dff ff3 (
      .d(data_in[3]),
      .scan_in(data_out_internal[2]),
      .clk(clk),
      .rstn(rstn),
      .scan_en(scan_en),
      .q(data_out_internal[3])
  );

  genvar i;
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin : g_fault_inject
      assign data_out[i] = (INJECT_FAULT && FAULT_BIT == i) ? FAULT_TYPE : data_out_internal[i];
    end
  endgenerate
  assign scan_out = data_out_internal[3];
endmodule

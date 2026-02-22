module bist_top #(
    parameter integer WIDTH = 4,
    parameter integer INJECT_FAULT = 0,
    parameter integer FAULT_BIT = 0,
    parameter integer FAULT_TYPE = 0
) (
    input clk,
    input rstn,
    input bist_mode,
    input scan_en,
    input scan_in,
    input [WIDTH-1:0] data_in,
    output scan_out,
    output [WIDTH-1:0] data_out,
    output [WIDTH-1:0] misr_signature
);

  wire [WIDTH-1:0] lfsr_pattern;
  wire [WIDTH-1:0] cut_input;

  assign cut_input = bist_mode ? lfsr_pattern : data_in;

  lfsr #(
      .WIDTH(WIDTH)
  ) lfsr_inst (
      .clk(clk),
      .rstn(rstn),
      .pattern(lfsr_pattern)
  );

  scan_reg #(
      .WIDTH(WIDTH),
      .FAULT_BIT(FAULT_BIT),
      .FAULT_TYPE(FAULT_TYPE),
      .INJECT_FAULT(INJECT_FAULT)
  ) dut (
      .data_in(cut_input),
      .clk(clk),
      .rstn(rstn),
      .scan_out(scan_out),
      .scan_en(scan_en),
      .scan_in(scan_in),
      .data_out(data_out)
  );

  misr #(
      .WIDTH(WIDTH)
  ) misr_inst (
      .clk(clk),
      .rstn(rstn),
      .data_in(data_out),
      .signature(misr_signature)
  );

endmodule  // bist_top

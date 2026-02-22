module scan_dff (
    input d,
    input scan_in,
    input clk,
    input rstn,
    input scan_en,
    output reg q
);

  wire d_sel;
  assign d_sel = scan_en ? scan_in : d;

  always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      q <= 1'b0;
    end else begin
      q <= d_sel;
    end
  end
endmodule  // scan_dff

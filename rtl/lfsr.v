module lfsr #(
    parameter integer WIDTH = 4
) (
    input                  clk,
    input                  rstn,
    output reg [WIDTH-1:0] pattern
);
  wire feedback;
  assign feedback = pattern[2] ^ pattern[3];

  always @(posedge clk or negedge rstn) begin
    if (!rstn) pattern <= 4'b0001;
    else pattern <= {pattern[2:0], feedback};
  end
endmodule  // lfsr

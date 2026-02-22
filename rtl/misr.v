module misr #(
    parameter integer WIDTH = 4
) (
    input                  clk,
    input                  rstn,
    input      [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] signature
);
  wire feedback;
  reg [WIDTH-1:0] signature_buff;
  assign feedback = signature[2] ^ signature[3] ^ data_in[0];

  always @(posedge clk or negedge rstn) begin
    if (!rstn) signature <= 4'b1111;
    else begin
      signature_buff <= signature[2:0] ^ data_in[3:1];
      signature <= {signature_buff, feedback};
    end

  end
endmodule  // misr

module scan_reg_tb;
  parameter integer WIDTH = 4;

  reg [WIDTH-1:0] d_in;
  reg clk, rstn, scan_en, scan_in;
  wire             scan_out;
  wire [WIDTH-1:0] d_out;

  scan_reg #(
      .WIDTH(WIDTH)
  ) dut (
      .data_in(d_in),
      .clk(clk),
      .rstn(rstn),
      .scan_en(scan_en),
      .scan_in(scan_in),
      .scan_out(scan_out),
      .data_out(d_out)
  );

  always #10 clk = ~clk;

  initial begin
    clk = 0;
    rstn = 0;
    scan_en = 0;
    scan_in = 0;
    d_in = 4'b0000;

    #20 rstn = 1;

    @(posedge clk) d_in = 4'b1010;
    @(posedge clk);

    scan_en = 1;
    @(posedge clk) scan_in = 1;
    @(posedge clk) scan_in = 0;
    @(posedge clk) scan_in = 1;
    @(posedge clk) scan_in = 1;

    scan_en = 0;
    @(posedge clk) d_in = 4'b0011;

    scan_en = 1;
    repeat (4) @(posedge clk);

    #20 $finish;
  end  // initial begin

  initial begin
    $monitor("T=%0t rstn=%b scan_en=%b scan_in=%b | d_in=%b d_out=%b scan_out=%b", $time, rstn,
             scan_en, scan_in, d_in, d_out, scan_out);
  end
endmodule  // scan_reg_tb

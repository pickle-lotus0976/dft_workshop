module bist_top_tb;
  parameter integer WIDTH = 4;

  reg clk, rstn, bist_mode, scan_en, scan_in;
  reg  [WIDTH-1:0] data_in;
  wire             scan_out;
  wire [WIDTH-1:0] data_out, misr_signature;

  bist_top #(.WIDTH(WIDTH)) dut (.*);
  always #10 clk = ~clk;

  initial begin
    clk = 0;
    rstn = 0;
    bist_mode = 0;
    scan_en = 0;
    scan_in = 0;
    data_in = 4'b0000;

    #20 rstn = 1;

    $display("\nBIST Mode:");
    bist_mode = 1;
    scan_en   = 0;
    repeat (16) @(posedge clk);
    $display("Final MISR signature: %b", misr_signature);

    rstn = 0;
    #20 rstn = 1;

    $display("\nScan Mode:");
    bist_mode = 0;
    scan_en   = 1;
    @(posedge clk) scan_in = 1;
    @(posedge clk) scan_in = 1;
    @(posedge clk) scan_in = 0;
    @(posedge clk) scan_in = 1;
    $display("\nLoaded: 1101 | data_out = %b", data_out);

    #40 $finish;
  end  // initial begin

  initial begin
    $monitor("T=%0t bist_mode=%b scan_en=%b | LFSR=%b CUT_out=%b MISR=%b", $time, bist_mode,
             scan_en, dut.lfsr_pattern, data_out, misr_signature);
  end
endmodule  // bist_top_tb

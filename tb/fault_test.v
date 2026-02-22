module fault_test;
  parameter integer WIDTH = 4;
  reg clk, rstn;
  wire [WIDTH-1:0] sig_fault_free, sig_f0_sa0, sig_f0_sa1, sig_f1_sa0, sig_f1_sa1, sig_f2_sa0, sig_f2_sa1, sig_f3_sa0, sig_f3_sa1;
  integer detected = 0;

  // Fault free
  bist_top #(
      .WIDTH(WIDTH),
      .INJECT_FAULT(0)
  ) dut_clean (
      .clk(clk),
      .rstn(rstn),
      .bist_mode(1'b1),
      .scan_en(1'b0),
      .scan_in(1'b0),
      .data_in(4'b0),
      .misr_signature(sig_fault_free)
  );

  // Bit 0 SA0
  bist_top #(
      .WIDTH(WIDTH),
      .INJECT_FAULT(1),
      .FAULT_BIT(0),
      .FAULT_TYPE(0)
  ) dut_f0_sa0 (
      .clk(clk),
      .rstn(rstn),
      .bist_mode(1'b1),
      .scan_en(1'b0),
      .scan_in(1'b0),
      .data_in(4'b0),
      .misr_signature(sig_f0_sa0)
  );

  // Bit 0 SA1
  bist_top #(
      .WIDTH(WIDTH),
      .INJECT_FAULT(1),
      .FAULT_BIT(0),
      .FAULT_TYPE(1)
  ) dut_f0_sa1 (
      .clk(clk),
      .rstn(rstn),
      .bist_mode(1'b1),
      .scan_en(1'b0),
      .scan_in(1'b0),
      .data_in(4'b0),
      .misr_signature(sig_f0_sa1)
  );

  // Bit 1 SA0
  bist_top #(
      .WIDTH(WIDTH),
      .INJECT_FAULT(1),
      .FAULT_BIT(1),
      .FAULT_TYPE(0)
  ) dut_f1_sa0 (
      .clk(clk),
      .rstn(rstn),
      .bist_mode(1'b1),
      .scan_en(1'b0),
      .scan_in(1'b0),
      .data_in(4'b0),
      .misr_signature(sig_f1_sa0)
  );

  // Bit 1 SA1
  bist_top #(
      .WIDTH(WIDTH),
      .INJECT_FAULT(1),
      .FAULT_BIT(1),
      .FAULT_TYPE(1)
  ) dut_f1_sa1 (
      .clk(clk),
      .rstn(rstn),
      .bist_mode(1'b1),
      .scan_en(1'b0),
      .scan_in(1'b0),
      .data_in(4'b0),
      .misr_signature(sig_f1_sa1)
  );

  // Bit 2 SA0
  bist_top #(
      .WIDTH(WIDTH),
      .INJECT_FAULT(1),
      .FAULT_BIT(2),
      .FAULT_TYPE(0)
  ) dut_f2_sa0 (
      .clk(clk),
      .rstn(rstn),
      .bist_mode(1'b1),
      .scan_en(1'b0),
      .scan_in(1'b0),
      .data_in(4'b0),
      .misr_signature(sig_f2_sa0)
  );

  // Bit 2 SA1
  bist_top #(
      .WIDTH(WIDTH),
      .INJECT_FAULT(1),
      .FAULT_BIT(2),
      .FAULT_TYPE(1)
  ) dut_f2_sa1 (
      .clk(clk),
      .rstn(rstn),
      .bist_mode(1'b1),
      .scan_en(1'b0),
      .scan_in(1'b0),
      .data_in(4'b0),
      .misr_signature(sig_f2_sa1)
  );

  // Bit 3 SA0
  bist_top #(
      .WIDTH(WIDTH),
      .INJECT_FAULT(1),
      .FAULT_BIT(3),
      .FAULT_TYPE(0)
  ) dut_f3_sa0 (
      .clk(clk),
      .rstn(rstn),
      .bist_mode(1'b1),
      .scan_en(1'b0),
      .scan_in(1'b0),
      .data_in(4'b0),
      .misr_signature(sig_f3_sa0)
  );

  // Bit 3 SA1
  bist_top #(
      .WIDTH(WIDTH),
      .INJECT_FAULT(1),
      .FAULT_BIT(3),
      .FAULT_TYPE(1)
  ) dut_f3_sa1 (
      .clk(clk),
      .rstn(rstn),
      .bist_mode(1'b1),
      .scan_en(1'b0),
      .scan_in(1'b0),
      .data_in(4'b0),
      .misr_signature(sig_f3_sa1)
  );

  always #10 clk = ~clk;

  initial begin
    clk  = 0;
    rstn = 0;
    #20 rstn = 1;

    repeat (16) @(posedge clk);

    $display("\nFAULT COVERAGE RESULTS:");
    $display("Fault-free:     %b", sig_fault_free);
    $display("Bit[0] SA0:     %b %s", sig_f0_sa0, (sig_f0_sa0 != sig_fault_free) ? "yes" : "no");
    $display("Bit[0] SA1:     %b %s", sig_f0_sa1, (sig_f0_sa1 != sig_fault_free) ? "yes" : "no");
    $display("Bit[1] SA0:     %b %s", sig_f1_sa0, (sig_f1_sa0 != sig_fault_free) ? "yes" : "no");
    $display("Bit[1] SA1:     %b %s", sig_f1_sa1, (sig_f1_sa1 != sig_fault_free) ? "yes" : "no");
    $display("Bit[2] SA0:     %b %s", sig_f2_sa0, (sig_f2_sa0 != sig_fault_free) ? "yes" : "no");
    $display("Bit[2] SA1:     %b %s", sig_f2_sa1, (sig_f2_sa1 != sig_fault_free) ? "yes" : "no");
    $display("Bit[3] SA0:     %b %s", sig_f3_sa0, (sig_f3_sa0 != sig_fault_free) ? "yes" : "no");
    $display("Bit[3] SA1:     %b %s", sig_f3_sa1, (sig_f3_sa1 != sig_fault_free) ? "yes" : "no");

    detected = (sig_f0_sa0 != sig_fault_free) + (sig_f0_sa1 != sig_fault_free) +
           (sig_f1_sa0 != sig_fault_free) + (sig_f1_sa1 != sig_fault_free) +
           (sig_f2_sa0 != sig_fault_free) + (sig_f2_sa1 != sig_fault_free) +
           (sig_f3_sa0 != sig_fault_free) + (sig_f3_sa1 != sig_fault_free);

    $display("\nCoverage: %0d/8 faults detected = %0d%%", detected, (detected * 100) / 8);
    $finish;
  end  // initial begin
endmodule  // fault_test

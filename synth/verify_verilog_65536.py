#!/usr/bin/env python3
import subprocess

with open('/tmp/tb_full.v', 'w') as f:
    f.write("""
`timescale 1ns/1ps
module tb_full;
  reg [7:0] a, b;
  wire [15:0] product;
  reg clk;
  reg reset;
  
  RegularBooth8Full dut (
    .clock(clk),
    .reset(reset),
    .io_a(a),
    .io_b(b),
    .io_product(product)
  );

  integer i, j;
  integer golden;
  integer error_sum;
  integer err;
  
  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
    
    error_sum = 0;
    
    for (i = 0; i < 256; i = i + 1) begin
      for (j = 0; j < 256; j = j + 1) begin
        // Verilog bit conversions to signed correctly
        a = i;
        b = j;
        #10;
        
        golden = $signed(a) * $signed(b);
        err = $signed(product) - golden;
        error_sum = error_sum + err;
        
      end
    end
    
    $display("ALL 65536 TESTS DONE.");
    $display("MEAN ERROR SUM = %d. (Divide by 65536 to get actual Mean Error)", error_sum);
    
    if (error_sum == 0) begin
        $display("✅ ABSOLUTE PERFECTION! Zero-Bias achieved across all combinations.");
    end else begin
        $display("❌ FAILED. Mean error sum is non-zero.");
    end
    
    $finish;
  end
  
  always #5 clk = ~clk;
endmodule
""")

print("Compiling iverilog testbench...")
res = subprocess.run(
    ['iverilog', '-o', '/tmp/sim_full', '/home/qq/projects/approx-multiplier/RegularBooth8Full.v', '/tmp/tb_full.v'],
    capture_output=True, text=True
)
if res.returncode != 0:
    print("Compilation Failed:\n", res.stderr)
    exit(1)

print("Running simulation...")
res = subprocess.run(['vvp', '/tmp/sim_full'], capture_output=True, text=True)
output = res.stdout

print(output.strip())

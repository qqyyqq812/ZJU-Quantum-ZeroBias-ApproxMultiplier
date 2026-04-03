#!/usr/bin/env python3
import subprocess
import os

def test_module(module_name):
    print(f"=====================================")
    print(f"Testing {module_name} (65536 Exhaustive)")
    print(f"=====================================")
    
    tb_content = f"""
`timescale 1ns/1ps
module tb;
  reg [7:0] a, b;
  wire [15:0] product;
  reg clk;
  reg reset;
  
  {module_name} dut (
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
        a = i;
        b = j;
        #10;
        
        golden = $signed(a) * $signed(b);
        err = $signed(product) - golden;
        error_sum = error_sum + err;
        
        // Exact 必定全对。Approx 由于近似本身允许单点误差，但全局 Mean Error必须是0
        if (golden != $signed(product) && "{module_name}" == "StructuralExactBooth8") begin
             $display("Fatal ERROR on Exact at a=%d, b=%d", $signed(a), $signed(b));
             $finish;
        end
      end
    end
    
    if (error_sum == 0) begin
        $display("✅ ABSOLUTE PERFECTION! Zero-Bias / Perfect Match achieved across all combinations.");
    end else begin
        $display("❌ FAILED. Mean error sum is %d.", error_sum);
    end
    
    $finish;
  end
  
  always #5 clk = ~clk;
endmodule
"""
    tb_file = f'/tmp/tb_{module_name}.v'
    with open(tb_file, 'w') as f:
        f.write(tb_content)

    v_file = f'/home/qq/projects/approx-multiplier/{module_name}.v'
    sim_file = f'/tmp/sim_{module_name}'
    
    res = subprocess.run(
        ['iverilog', '-o', sim_file, v_file, tb_file],
        capture_output=True, text=True
    )
    if res.returncode != 0:
        print("Compilation Failed:\n", res.stderr)
        return
        
    res = subprocess.run(['vvp', sim_file], capture_output=True, text=True)
    print(res.stdout.strip())

if __name__ == "__main__":
    test_module("StructuralExactBooth8")
    test_module("RegularBooth8FullOpt")

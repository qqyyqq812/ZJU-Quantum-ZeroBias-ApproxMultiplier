#!/usr/bin/env python3
import subprocess
import os
import csv

print("[*] Generating Verilog Testbench for 65536 exact-approx combinations (2-Row Approx)...")

tb_code = """
`timescale 1ns/1ps
module tb_v3_2row_lut;
  reg [7:0] a, b;
  wire [15:0] product;
  reg clk;
  reg reset;
  
  KMap_V3_2Row_Approx dut (
    .clock(clk),
    .reset(reset),
    .io_a(a),
    .io_b(b),
    .io_product(product)
  );

  integer i, j;
  integer golden;
  integer approx;
  
  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
    
    // Print CSV header
    $display("inputA,inputB,exact,approx");
    
    for (i = -128; i < 128; i = i + 1) begin
      for (j = -128; j < 128; j = j + 1) begin
        a = i[7:0];
        b = j[7:0];
        #5;
        
        // Exact sign-extended math
        golden = i * j;
        approx = $signed(product); // Sign extend to integer
        
        $display("%d,%d,%d,%d", i, j, golden, approx);
        #5;
      end
    end
    
    $finish;
  end
  
  always #5 clk = ~clk;
endmodule
"""

tb_path = '/tmp/tb_v3_2row_lut.v'
sim_exec = '/tmp/sim_v3_2row_lut'
v3_verilog_path = '/home/qq/projects/approx-multiplier/generated_rtl/KMap_V3_2Row_Approx.v'

with open(tb_path, 'w') as f:
    f.write(tb_code)

print("[*] Compiling with iverilog...")
res = subprocess.run(
    ['iverilog', '-o', sim_exec, v3_verilog_path, tb_path],
    capture_output=True, text=True
)

if res.returncode != 0:
    print("❌ Compilation Failed:\n", res.stderr)
    exit(1)

print("[*] Running simulation and capturing data (this may take a few seconds)...")
sim_res = subprocess.run(['vvp', sim_exec], capture_output=True, text=True)

lines = sim_res.stdout.strip().split('\n')
# Expected first line is the CSV header
header_idx = -1
for idx, line in enumerate(lines):
    if line.startswith("inputA,inputB,exact,approx"):
        header_idx = idx
        break

if header_idx == -1:
    print("❌ Error: Could not find CSV header in simulation output.")
    exit(1)

csv_lines = lines[header_idx:]

raw_csv_path = '/tmp/raw_v3_2row_lut.csv'
with open(raw_csv_path, 'w') as f:
    f.write('\n'.join(csv_lines))

print(f"[*] Processing data and calculating abs_error & rel_error...")

final_csv_path = '/home/qq/projects/approx-multiplier/synth/v3_2row_lut.csv'
with open(raw_csv_path, 'r') as fin, open(final_csv_path, 'w', newline='') as fout:
    reader = csv.DictReader(fin)
    fields = list(reader.fieldnames) + ['abs_error', 'rel_error']
    writer = csv.DictWriter(fout, fieldnames=fields)
    writer.writeheader()
    
    count = 0
    for row in reader:
        exact = int(row['exact'])
        approx = int(row['approx'])
        
        abs_err = approx - exact
        if exact != 0:
            rel_err = abs(abs_err) / abs(exact)
        else:
            rel_err = 0.0 if approx == 0 else 1.0
            
        row['abs_error'] = abs_err
        row['rel_error'] = rel_err
        writer.writerow(row)
        count += 1

print(f"✅ Generated final standardized dataset: {final_csv_path} with {count} samples.")

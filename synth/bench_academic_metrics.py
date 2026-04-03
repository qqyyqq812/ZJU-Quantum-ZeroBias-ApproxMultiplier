#!/usr/bin/env python3
import subprocess
import os
import csv
import math

# 配置我们需要测算的模型与输出名映射
TARGETS = {
    "KMap_V3_1Row_Approx": "ZBA-R4ABM-1A3E",
    "KMap_V3_2Row_Approx": "ZBA-R4ABM-2A2E",
    "KMap_V3_3Row_Approx": "ZBA-R4ABM-3A1E",
    "KMap_V3_4Row_Approx": "ZBA-R4ABM-4A0E-Pure",
    "KMap_V3_Final_SchemeD": "ZBA-R4ABM-4A0E-SchemeD"
}

RTL_DIR = "/home/qq/projects/approx-multiplier/generated_rtl"
# Final_SchemeD may be in synth/rtl/ or generated_rtl/, let's assume generated_rtl for 1-4, and synth/rtl for Final
FINAL_RTL = "/home/qq/projects/approx-multiplier/synth/rtl/KMap_V3_Final_SchemeD.v"

OUT_DIR = "/home/qq/chipyard_workspace/docs/parallel/agent_2/LUTs"
os.makedirs(OUT_DIR, exist_ok=True)

tb_template = """
`timescale 1ns/1ps
module tb_MODNAME;
  reg [7:0] a, b;
  wire [15:0] product;
  reg clk;
  reg reset;
  
  MODNAME dut (
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
        #2;
        
        golden = i * j;
        approx = $signed(product);
        
        $display("%d,%d,%d,%d", i, j, golden, approx);
        #3;
      end
    end
    
    $finish;
  end
  
  always #5 clk = ~clk;
endmodule
"""

print(f"{'ApprName':<22} | {'ER(%)':>8} | {'MRED(%)':>8} | {'NMED(x10^-2)':>12} | {'P(RED<2%)':>10} | {'ME':>8}")
print("-" * 80)

results = {}

for mod, academic_name in TARGETS.items():
    v_file = os.path.join(RTL_DIR, f"{mod}.v")
    if mod == "KMap_V3_Final_SchemeD":
        # Check alternative path if needed
        if not os.path.exists(v_file):
            v_file = FINAL_RTL

    if not os.path.exists(v_file):
        print(f"File not found for {mod}: {v_file}")
        continue
        
    tb_content = tb_template.replace("MODNAME", mod)
    tb_file = f"/tmp/tb_{mod}.v"
    sim_file = f"/tmp/sim_{mod}"
    
    with open(tb_file, 'w') as f:
        f.write(tb_content)
        
    res = subprocess.run(['iverilog', '-o', sim_file, v_file, tb_file], capture_output=True, text=True)
    if res.returncode != 0:
        print(f"Compilation Failed for {mod}:\n{res.stderr}")
        continue
        
    res = subprocess.run(['vvp', sim_file], capture_output=True, text=True)
    
    lines = res.stdout.strip().split('\n')
    header_idx = -1
    for idx, line in enumerate(lines):
        if line.startswith("inputA,inputB"):
            header_idx = idx
            break
            
    if header_idx == -1:
        continue
        
    csv_lines = lines[header_idx:]
    
    # Calculate metrics
    error_count = 0
    total_abs_error = 0.0
    total_rel_error_non_zero = 0.0
    small_rel_error_count = 0
    non_zero_cases = 0
    sum_err = 0
    
    # Save LUT
    csv_out_path = os.path.join(OUT_DIR, f"{academic_name}_lut.csv")
    with open(csv_out_path, 'w', newline='') as fout:
        writer = csv.writer(fout)
        writer.writerow(['inputA', 'inputB', 'exact', 'approx', 'abs_error', 'rel_error'])
        
        # Skip header
        for line in csv_lines[1:]:
            parts = line.split(',')
            if len(parts) < 4: continue
            
            exact = int(parts[2])
            approx = int(parts[3])
            
            err = approx - exact
            sum_err += err
            abs_err = abs(err)
            
            total_abs_error += abs_err
            if abs_err > 0:
                error_count += 1
            
            rel_err = 0.0
            if exact != 0:
                rel_err = abs_err / abs(exact)
                total_rel_error_non_zero += rel_err
                non_zero_cases += 1
                if rel_err < 0.02:
                    small_rel_error_count += 1
            else:
                rel_err = 0.0 if approx == 0 else 1.0
                
            writer.writerow(parts + [abs_err, rel_err])
            

    # Formulate
    test_cases = 65536
    me = sum_err / test_cases
    er = (error_count / test_cases) * 100
    nmed = (total_abs_error / test_cases) / 16384.0 * 100  # scaled by 10^2
    mred = (total_rel_error_non_zero / non_zero_cases) * 100 if non_zero_cases > 0 else 0
    pred = (small_rel_error_count / non_zero_cases) * 100 if non_zero_cases > 0 else 0
    
    results[academic_name] = {
        "ME": me,
        "ER": er,
        "NMED": nmed,
        "MRED": mred,
        "PRED": pred
    }
    
    print(f"{academic_name:<22} | {er:>8.2f} | {mred:>8.2f} | {nmed:>12.4f} | {pred:>10.2f} | {me:>8.4f}")


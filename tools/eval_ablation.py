#!/usr/bin/env python3
import subprocess
import os

MODULES = [
    "KMap_4Row_NoZG",
    "KMap_4Row_WithZG",
    "KMap_4Row_ZG_NaiveNeg",
    "KMap_4Row_ZG_EmbeddedNeg",
    "KMap_4Row_ZG_EmbeddedNeg_BARC"
]

def run_exhaustive_test():
    print("==================================================")
    print("   全空域 (65536) 精度与误差矩阵分析 (Ablation)     ")
    print("==================================================")
    
    for mod in MODULES:
        print(f"\n[编译与验证] {mod} ...")
        
        tb_content = """
`timescale 1ns/1ps
module tb_MODNAME;
  reg [7:0] a, b;
  wire [15:0] product;
  reg clk, reset;
  
  MODNAME dut (
    .clock(clk),
    .reset(reset),
    .io_a(a),
    .io_b(b),
    .io_product(product)
  );

  integer i, j;
  integer golden, err, abs_err;
  
  integer error_sum;
  real abs_error_sum;
  integer error_count;
  real mred_sum;
  
  initial begin
    clk = 0; reset = 1; #10 reset = 0;
    
    error_sum = 0;
    abs_error_sum = 0.0;
    error_count = 0;
    mred_sum = 0.0;
    
    for (i = 0; i < 256; i = i + 1) begin
      for (j = 0; j < 256; j = j + 1) begin
        a = i; b = j;
        #2;
        
        golden = $signed(a) * $signed(b);
        err = $signed(product) - golden;
        
        if (err < 0) abs_err = -err; else abs_err = err;
        
        error_sum = error_sum + err;
        abs_error_sum = abs_error_sum + abs_err;
        
        if (err != 0) begin
            error_count = error_count + 1;
        end
        
        if (golden != 0) begin
            mred_sum = mred_sum + (abs_err * 1.0 / ((golden < 0) ? -golden : golden));
        end
      end
    end
    
    $display("RESULTS: Mean Error Sum=%0d | Error Count=%0d | MAE Sum=%f  | MRED Sum=%f", error_sum, error_count, abs_error_sum, mred_sum);
    $finish;
  end
  
  always #1 clk = ~clk;
endmodule
"""
        tb_content = tb_content.replace("MODNAME", mod)
        
        tb_file = f'/tmp/tb_{mod}.v'
        with open(tb_file, 'w') as f:
            f.write(tb_content)

        v_file = f'/home/qq/projects/approx-multiplier/{mod}.v'
        sim_file = f'/tmp/sim_{mod}'
        
        if not os.path.exists(v_file):
            print(f"Error: {v_file} does not exist!")
            continue

        res = subprocess.run(
            ['iverilog', '-o', sim_file, v_file, tb_file],
            capture_output=True, text=True
        )
        if res.returncode != 0:
            print(f"Compilation Failed for {mod}:\n", res.stderr)
            continue
            
        res = subprocess.run(['vvp', sim_file], capture_output=True, text=True)
        for line in res.stdout.splitlines():
            if "RESULTS:" in line:
                parts = line.replace("RESULTS: ", "").split("|")
                esum = int(parts[0].split("=")[1])
                ecount = int(parts[1].split("=")[1])
                maesum = float(parts[2].split("=")[1])
                mredsum = float(parts[3].split("=")[1])
                
                mean_error = esum / 65536.0
                er = (ecount / 65536.0) * 100.0
                nmed = (maesum / 65536.0) / (127.0 * 128.0)
                mred = mredsum / 65536.0
                
                print(f"  --> Mean Error (µ) : {mean_error:.6f}")
                print(f"  --> Error Rate (ER): {er:.2f}%")
                print(f"  --> NMED           : {nmed:.6f}")
                print(f"  --> MRED           : {mred:.6f}")
                if mean_error == 0.0:
                    print("  --> [√] ABSOLUTE ZERO BIAS ACHIEVED")
                else:
                    print("  --> [!] BIASED")
                break

if __name__ == "__main__":
    run_exhaustive_test()

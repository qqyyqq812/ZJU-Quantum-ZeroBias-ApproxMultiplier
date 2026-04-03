#!/usr/bin/env python3
import subprocess
import os

MODULES = [
    "KMap_4Row_ZG_EmbeddedNeg",      # Base 4Row
    "KMap_4Row_ZG_EmbeddedNeg_BARC"   # Scheme D
]

LUT_OUTPUT_DIR = "/home/qq/projects/adapt/adapt/cpu-kernels/axx_mults/"

def generate_lut_for_module(mod):
    print(f"Generating LUT for {mod} using Verilog Simulation...")
    tb_content = f"""
`timescale 1ns/1ps
module tb_dump_{mod};
  reg [7:0] a, b;
  wire [15:0] product;
  
  {mod} dut (
    .io_a(a),
    .io_b(b),
    .io_product(product)
  );

  integer i, j;
  
  initial begin
    for (i = 0; i < 256; i = i + 1) begin
      for (j = 0; j < 256; j = j + 1) begin
        a = i; b = j;
        #1;
        $display("R %d", $signed(product));
      end
    end
    $finish;
  end
endmodule
"""
    tb_file = f'/tmp/tb_dump_{mod}.v'
    with open(tb_file, 'w') as f:
        f.write(tb_content)

    v_file = f'/home/qq/projects/approx-multiplier/{mod}.v'
    sim_file = f'/tmp/sim_dump_{mod}'
    
    res = subprocess.run(['iverilog', '-o', sim_file, v_file, tb_file], capture_output=True, text=True)
    if res.returncode != 0:
        print(f"Compile failed: {res.stderr}")
        return
        
    res = subprocess.run(['vvp', sim_file], capture_output=True, text=True)
    
    results = []
    for line in res.stdout.splitlines():
        if line.startswith("R "):
            results.append(line.split()[1])
            
    if len(results) != 65536:
        print(f"Error: expected 65536 results, got {len(results)}")
        return
        
    out_file = os.path.join(LUT_OUTPUT_DIR, f"{mod}.h")
    with open(out_file, "w") as f:
        f.write("#include <stdint.h>\n\n")
        f.write("const int16_t lut[256][256] = {\n")
        
        idx = 0
        for i in range(256):
            row = results[idx:idx+256]
            idx += 256
            f.write("    {" + ", ".join(row) + "}")
            if i != 255:
                f.write(",\n")
            else:
                f.write("\n")
        f.write("};\n")
    print(f"Saved to {out_file}")

if __name__ == "__main__":
    os.makedirs(LUT_OUTPUT_DIR, exist_ok=True)
    for m in MODULES:
        generate_lut_for_module(m)
